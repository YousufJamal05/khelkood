import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../design/app_colors.dart';
import '../../design/app_dimensions.dart';
import '../../providers/court_provider.dart';
import '../../providers/feedback_service.dart';
import './widgets/block_slots/court_dropdown.dart';
import './widgets/block_slots/date_scroller.dart';
import './widgets/block_slots/slot_item.dart';
import './widgets/block_slots/reason_selector.dart';
import './widgets/block_slots/block_footer.dart';

class BlockSlotsPage extends ConsumerStatefulWidget {
  const BlockSlotsPage({super.key});

  @override
  ConsumerState<BlockSlotsPage> createState() => _BlockSlotsPageState();
}

class _BlockSlotsPageState extends ConsumerState<BlockSlotsPage> {
  DateTime _selectedDate = DateTime.now();
  CourtModel? _selectedCourt;
  final Set<String> _selectedSlots = {};
  String _selectedReason = 'Maintenance';
  final TextEditingController _detailsController = TextEditingController();
  final GlobalKey _gridKey = GlobalKey();

  // For drag selection
  final Set<int> _draggedIndices = {};
  int? _dragStartRow;
  int? _dragStartIndex;

  final List<String> _reasons = [
    'Maintenance',
    'Private Event',
    'Personal Use',
    'Holiday',
    'Other',
  ];

  @override
  void dispose() {
    _detailsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final courtsAsync = ref.watch(ownerCourtsProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? AppColors.backgroundDark
          : AppColors.backgroundLight,
      appBar: AppBar(
        title: const Text('Block Slots'),
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: courtsAsync.when(
        data: (courts) {
          if (courts.isEmpty) {
            return const Center(child: Text('No courts found.'));
          }
          _selectedCourt ??= courts.first;

          return SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      vertical: AppDimensions.paddingMD,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CourtDropdown(
                          courts: courts,
                          selectedCourt: _selectedCourt,
                          onSelected: (court) {
                            setState(() {
                              _selectedCourt = court;
                              _selectedSlots.clear();
                            });
                          },
                          isDark: isDark,
                        ),
                        const SizedBox(height: AppDimensions.paddingLG),
                        DateScroller(
                          selectedDate: _selectedDate,
                          onDateSelected: (date) {
                            setState(() {
                              _selectedDate = date;
                              _selectedSlots.clear();
                            });
                          },
                          onCalendarTap: _showDatePicker,
                          isDark: isDark,
                        ),
                        const SizedBox(height: AppDimensions.paddingLG),
                        _buildSlotGridSection(isDark),
                        const SizedBox(height: AppDimensions.paddingLG),
                        ReasonSelector(
                          reasons: _reasons,
                          selectedReason: _selectedReason,
                          onReasonSelected: (reason) {
                            setState(() => _selectedReason = reason);
                          },
                          detailsController: _detailsController,
                          isDark: isDark,
                        ),
                        const SizedBox(height: AppDimensions.paddingLG),
                      ],
                    ),
                  ),
                ),
                BlockFooter(
                  selectedSlotsCount: _selectedSlots.length,
                  selectedSlotsText: _selectedSlots.isEmpty
                      ? 'None'
                      : _selectedSlots.join(', '),
                  onBlockPressed: _selectedSlots.isEmpty
                      ? null
                      : _handleBlockSlots,
                  isDark: isDark,
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }

  Future<void> _showDatePicker() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 90)),
    );
    if (date != null) {
      setState(() {
        _selectedDate = date;
        _selectedSlots.clear();
      });
    }
  }

  Widget _buildSlotGridSection(bool isDark) {
    if (_selectedCourt == null) return const SizedBox.shrink();

    final hours = SlotUtility.getHoursForDate(
      _selectedDate,
      _selectedCourt!.operationalHours,
    );
    if (hours == null || hours['open'] == null || hours['close'] == null) {
      return const Padding(
        padding: EdgeInsets.all(AppDimensions.paddingLG),
        child: Center(child: Text('Court is closed on this day.')),
      );
    }

    final slots = SlotUtility.generateSlots(
      openTime: hours['open'],
      closeTime: hours['close'],
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.paddingLG,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Available Slots',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              if (_selectedSlots.isNotEmpty)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Selected (${_selectedSlots.length})',
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        StreamBuilder<Map<String, dynamic>>(
          stream: ref
              .read(courtServiceProvider)
              .watchAvailability(
                _selectedCourt!.courtId,
                SlotUtility.formatDateForDoc(_selectedDate),
              ),
          builder: (context, snapshot) {
            final availability = snapshot.data ?? {};
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.paddingLG,
              ),
              child: GestureDetector(
                onPanStart: (details) =>
                    _onPanStart(details, slots, availability),
                onPanUpdate: (details) =>
                    _onPanUpdate(details, slots, availability),
                onPanEnd: (details) => _onPanEnd(),
                child: GridView.builder(
                  key: _gridKey,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 2.2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: slots.length,
                  itemBuilder: (context, index) {
                    final slot = slots[index];
                    final status = availability[slot]?['status'] ?? 'available';
                    final isSelected = _selectedSlots.contains(slot);
                    final isBeingDragged = _draggedIndices.contains(index);

                    return SlotItem(
                      slot: slot,
                      status: status,
                      isSelected: isSelected || isBeingDragged,
                      isDark: isDark,
                      onTap: () {
                        setState(() {
                          if (_selectedSlots.contains(slot)) {
                            _selectedSlots.remove(slot);
                          } else {
                            _selectedSlots.add(slot);
                          }
                        });
                      },
                    );
                  },
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  void _onPanStart(
    DragStartDetails details,
    List<String> slots,
    Map<String, dynamic> availability,
  ) {
    final result = _calculateIndex(details.globalPosition, slots.length);
    if (result != null) {
      _dragStartRow = result.row;
      _dragStartIndex = result.index;
      _updateSelection(details.globalPosition, slots, availability);
    }
  }

  void _onPanUpdate(
    DragUpdateDetails details,
    List<String> slots,
    Map<String, dynamic> availability,
  ) {
    _updateSelection(details.globalPosition, slots, availability);
  }

  void _onPanEnd() {
    setState(() {
      _dragStartRow = null;
      _dragStartIndex = null;
      _draggedIndices.clear();
    });
  }

  ({int index, int row, int col})? _calculateIndex(
    Offset globalPosition,
    int totalSlots,
  ) {
    final RenderBox? renderBox =
        _gridKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return null;

    final Offset localOffset = renderBox.globalToLocal(globalPosition);
    final double gridWidth = renderBox.size.width;

    const int crossAxisCount = 3;
    const double spacing = 10.0;
    const double aspectRatio = 2.2;

    final double columnWidth =
        (gridWidth - (crossAxisCount - 1) * spacing) / crossAxisCount;
    final double rowHeight = (columnWidth / aspectRatio) + spacing;

    final int col = (localOffset.dx / (columnWidth + spacing)).floor();
    final int row = (localOffset.dy / rowHeight).floor();

    if (col >= 0 && col < crossAxisCount && row >= 0) {
      final int index = row * crossAxisCount + col;
      if (index >= 0 && index < totalSlots) {
        return (index: index, row: row, col: col);
      }
    }
    return null;
  }

  void _updateSelection(
    Offset globalPosition,
    List<String> slots,
    Map<String, dynamic> availability,
  ) {
    final result = _calculateIndex(globalPosition, slots.length);
    if (result == null || _dragStartRow == null || _dragStartIndex == null)
      return;

    // Restrict to same row
    if (result.row != _dragStartRow) return;

    final int start = _dragStartIndex!;
    final int end = result.index;

    // Select all slots between start and end (within the row)
    final int minIdx = start < end ? start : end;
    final int maxIdx = start < end ? end : start;

    setState(() {
      for (int i = minIdx; i <= maxIdx; i++) {
        final slot = slots[i];
        final status = availability[slot]?['status'] ?? 'available';
        if (status == 'available') {
          _selectedSlots.add(slot);
        }
      }
    });
  }

  Future<void> _handleBlockSlots() async {
    if (_selectedCourt == null || _selectedSlots.isEmpty) return;

    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );

      await ref
          .read(courtServiceProvider)
          .blockSlots(
            courtId: _selectedCourt!.courtId,
            date: SlotUtility.formatDateForDoc(_selectedDate),
            slots: _selectedSlots.toList(),
            reason: _selectedReason,
            additionalNotes: _detailsController.text,
          );

      if (mounted) {
        context.pop(); // Close loading
        ref
            .read(feedbackServiceProvider)
            .showSuccess(
              context,
              title: 'Success',
              message: 'Successfully blocked ${_selectedSlots.length} slots.',
            );
        setState(() {
          _selectedSlots.clear();
          _detailsController.clear();
        });
      }
    } catch (e) {
      if (mounted) {
        context.pop(); // Close loading
        ref
            .read(feedbackServiceProvider)
            .showError(
              context,
              title: 'Error',
              message: 'Failed to block slots: $e',
            );
      }
    }
  }
}
