import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import '../../design/app_colors.dart';
import '../../design/app_dimensions.dart';
import '../../design/app_text_styles.dart';
import '../widgets/khelkhood_button.dart';
import '../widgets/khelkhood_text_field.dart';
import '../../providers/court_provider.dart';
import 'package:common/common.dart';

class AddCourtPage extends ConsumerStatefulWidget {
  final CourtModel? existingCourt;
  const AddCourtPage({super.key, this.existingCourt});

  @override
  ConsumerState<AddCourtPage> createState() => _AddCourtPageState();
}

class _AddCourtPageState extends ConsumerState<AddCourtPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _locationLinkController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final List<String> _selectedSports = [];
  final List<String> _sports = [
    'Football',
    'Cricket',
    'Padel',
    'Tennis',
    'Badminton',
  ];

  TimeOfDay _weekdayOpen = const TimeOfDay(hour: 9, minute: 0);
  TimeOfDay _weekdayClose = const TimeOfDay(hour: 23, minute: 0);
  TimeOfDay _weekendOpen = const TimeOfDay(hour: 10, minute: 0);
  TimeOfDay _weekendClose = const TimeOfDay(hour: 23, minute: 59);

  final List<XFile> _images = [];
  final ImagePicker _picker = ImagePicker();

  final Map<String, bool> _amenities = {
    'Parking Area': true,
    'Changing Room': false,
    'Floodlights': true,
    'Drinking Water': false,
  };

  final Map<String, IconData> _amenityIcons = {
    'Parking Area': Icons.local_parking,
    'Changing Room': Icons.dry_cleaning_outlined,
    'Floodlights': Icons.lightbulb_outline,
    'Drinking Water': Icons.water_drop_outlined,
  };

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.existingCourt != null) {
      final court = widget.existingCourt!;
      _nameController.text = court.name;
      _locationController.text = court.address;
      _locationLinkController.text = court.location ?? '';
      _priceController.text = court.pricing['base']?.toString() ?? '0';
      _descriptionController.text = court.description ?? '';

      _selectedSports.clear();
      _selectedSports.addAll(
        court.sportTypes.map((s) => s[0].toUpperCase() + s.substring(1)),
      );

      // Pre-fill amenities
      for (var amenity in _amenities.keys) {
        final key = amenity.toLowerCase().replaceAll(' ', '_');
        _amenities[amenity] = court.amenities.contains(key);
      }

      // Pre-fill operational hours (taking Monday and Saturday as defaults for weekday/weekend)
      if (court.operationalHours.containsKey('mon')) {
        _weekdayOpen = _parseTime(court.operationalHours['mon']!['open']!);
        _weekdayClose = _parseTime(court.operationalHours['mon']!['close']!);
      }
      if (court.operationalHours.containsKey('sat')) {
        _weekendOpen = _parseTime(court.operationalHours['sat']!['open']!);
        _weekendClose = _parseTime(court.operationalHours['sat']!['close']!);
      }
    }
  }

  TimeOfDay _parseTime(String time) {
    final parts = time.split(':');
    return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
  }

  Future<void> _pickImage() async {
    if (_images.length >= 3) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Maximum 3 images allowed')));
      return;
    }
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _images.add(image);
      });
    }
  }

  void _removeImage(int index) {
    setState(() {
      _images.removeAt(index);
    });
  }

  Future<void> _selectTime(bool isWeekday, bool isOpening) async {
    final TimeOfDay initialTime = isWeekday
        ? (isOpening ? _weekdayOpen : _weekdayClose)
        : (isOpening ? _weekendOpen : _weekendClose);

    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );

    if (picked != null) {
      setState(() {
        if (isWeekday) {
          if (isOpening) {
            _weekdayOpen = picked;
          } else {
            _weekdayClose = picked;
          }
        } else {
          if (isOpening) {
            _weekendOpen = picked;
          } else {
            _weekendClose = picked;
          }
        }
      });
    }
  }

  String _formatTime(TimeOfDay time) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    return "${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}";
  }

  String _formatTimeDisplay(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final period = time.period == DayPeriod.am ? "AM" : "PM";
    return "${hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')} $period";
  }

  Future<void> _saveCourt() async {
    if (_selectedSports.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select at least one sport type')),
      );
      return;
    }

    // Only require images for new courts
    if (widget.existingCourt == null && _images.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please upload at least one image')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final user = ref.read(authStateProvider).value;
      if (user == null) throw Exception('User not logged in');

      final courtService = ref.read(courtServiceProvider);

      final courtId =
          widget.existingCourt?.courtId ?? courtService.generateCourtId();

      // Real image upload to Firebase Storage under courtId folder
      final List<String> photoUrls = widget.existingCourt != null
          ? List<String>.from(widget.existingCourt!.photos)
          : [];

      for (int i = 0; i < _images.length; i++) {
        final image = _images[i];
        final bytes = await image.readAsBytes();
        final extension = image.path.split('.').last;
        // Use a more unique filename to avoid overwriting existing ones during edit
        final fileName =
            'photo_${DateTime.now().millisecondsSinceEpoch}_$i.$extension';

        final url = await courtService.uploadCourtImage(
          courtId: courtId,
          fileName: fileName,
          imageBytes: bytes,
          contentType: 'image/$extension',
        );
        photoUrls.add(url);
      }

      final court = CourtModel(
        courtId: courtId, // Pass the locally generated ID
        ownerId: user.uid,
        name: _nameController.text,
        description: _descriptionController.text,
        sportTypes: _selectedSports.map((s) => s.toLowerCase()).toList(),
        area: 'Karachi', // Hardcoded for now
        address: _locationController.text,
        location: _locationLinkController.text.isNotEmpty
            ? _locationLinkController.text
            : null,
        pricing: {'base': int.parse(_priceController.text)},
        photos: photoUrls,
        amenities: _amenities.entries
            .where((e) => e.value)
            .map((e) => e.key.toLowerCase().replaceAll(' ', '_'))
            .toList(),
        operationalHours: {
          'mon': {
            'open': _formatTime(_weekdayOpen),
            'close': _formatTime(_weekdayClose),
          },
          'tue': {
            'open': _formatTime(_weekdayOpen),
            'close': _formatTime(_weekdayClose),
          },
          'wed': {
            'open': _formatTime(_weekdayOpen),
            'close': _formatTime(_weekdayClose),
          },
          'thu': {
            'open': _formatTime(_weekdayOpen),
            'close': _formatTime(_weekdayClose),
          },
          'fri': {
            'open': _formatTime(_weekdayOpen),
            'close': _formatTime(_weekdayClose),
          },
          'sat': {
            'open': _formatTime(_weekendOpen),
            'close': _formatTime(_weekendClose),
          },
          'sun': {
            'open': _formatTime(_weekendOpen),
            'close': _formatTime(_weekendClose),
          },
        },

        maxAdvanceBooking: 30,
        cancellationPolicy: {'noticeHours': 24, 'refundPercentage': 50},
        createdAt:
            DateTime.now(), // Model uses DateTime, toMap handles conversion
      );

      if (widget.existingCourt != null) {
        await ref.read(ownerCourtsProvider.notifier).updateCourt(court);
      } else {
        await ref.read(ownerCourtsProvider.notifier).addCourt(court);
      }

      if (mounted) {
        context.pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Court saved successfully!')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error saving court: $e')));
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? AppColors.backgroundDark
          : const Color(0xFFF9FAFB),
      appBar: AppBar(
        title: Text(
          widget.existingCourt != null ? 'Edit Court' : 'Add New Court',
          style: AppTextStyles.h3,
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppDimensions.paddingLG),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionLabel('Court Images'),
              const SizedBox(height: 12),
              _buildImageSelection(),
              const SizedBox(height: 8),
              const Text(
                'Upload at least one high-quality image of the facility.',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              const SizedBox(height: 24),

              _buildSectionLabel('Court Name'),
              const SizedBox(height: 8),
              KhelKhoodTextField(
                controller: _nameController,
                hint: 'e.g. Downtown Futsal Arena',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter court name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              _buildSectionLabel('Sport Type'),
              const SizedBox(height: 8),
              _buildSportChips(isDark),
              const SizedBox(height: 20),

              _buildSectionLabel('Address'),
              const SizedBox(height: 8),
              KhelKhoodTextField(
                controller: _locationController,
                hint: 'e.g. Block 4, Clifton, Karachi',
                prefix: const Icon(
                  Icons.location_on,
                  color: Colors.grey,
                  size: 20,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              _buildSectionLabel('Google Maps Location Link'),
              const SizedBox(height: 8),
              KhelKhoodTextField(
                controller: _locationLinkController,
                hint: 'e.g. https://maps.app.goo.gl/xxxx',
                prefix: const Icon(
                  Icons.map_outlined,
                  color: Colors.grey,
                  size: 20,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter location link';
                  }
                  final regex = RegExp(
                    r'^(https?:\/\/)?(www\.)?(google\.com\/maps\/|maps\.app\.goo\.gl\/).+$',
                  );
                  if (!regex.hasMatch(value)) {
                    return 'Please enter a valid Google Maps link';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              _buildSectionLabel('Pricing per Hour (PKR)'),
              const SizedBox(height: 8),
              KhelKhoodTextField(
                controller: _priceController,
                hint: '0',
                keyboardType: TextInputType.number,
                prefix: const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'Rs',
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Required';
                  if (int.tryParse(value) == null) return 'Invalid number';
                  return null;
                },
              ),
              const SizedBox(height: 24),

              _buildSectionLabel('Operating Hours (Weekdays)'),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: _buildTimePickerField(
                      'Opens at',
                      _weekdayOpen,
                      () => _selectTime(true, true),
                      isDark,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildTimePickerField(
                      'Closes at',
                      _weekdayClose,
                      () => _selectTime(true, false),
                      isDark,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              _buildSectionLabel('Operating Hours (Weekends)'),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: _buildTimePickerField(
                      'Opens at',
                      _weekendOpen,
                      () => _selectTime(false, true),
                      isDark,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildTimePickerField(
                      'Closes at',
                      _weekendClose,
                      () => _selectTime(false, false),
                      isDark,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              _buildSectionLabel('Amenities'),
              const SizedBox(height: 12),
              ..._amenities.keys.map(
                (amenity) => _buildAmenityToggle(amenity, isDark),
              ),

              const SizedBox(height: 40),
              KhelKhoodButton(
                text: widget.existingCourt != null
                    ? 'Update Court'
                    : 'Save Court',
                onPressed: _saveCourt,
                isLoading: _isLoading,
                icon: Icons.save_outlined,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionLabel(String label) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Color(0xFF1F2937),
      ),
    );
  }

  Widget _buildImageSelection() {
    return Container(
      height: 100,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _images.length + 1,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          if (index == 0) {
            return GestureDetector(
              onTap: _pickImage,
              child: Container(
                width: 100,
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5E9),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: AppColors.primary,
                    style: BorderStyle.solid,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Add Photo',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          final imageIndex = index - 1;
          return Stack(
            children: [
              Container(
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: FileImage(File(_images[imageIndex].path)),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 4,
                right: 4,
                child: GestureDetector(
                  onTap: () => _removeImage(imageIndex),
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.black54,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.close,
                      size: 12,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSportChips(bool isDark) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: _sports.map((sport) {
        final isSelected = _selectedSports.contains(sport);
        return FilterChip(
          label: Text(sport),
          selected: isSelected,
          onSelected: (selected) {
            setState(() {
              if (selected) {
                _selectedSports.add(sport);
              } else {
                _selectedSports.remove(sport);
              }
            });
          },
          selectedColor: AppColors.primary.withOpacity(0.2),
          checkmarkColor: AppColors.primary,
          labelStyle: TextStyle(
            color: isSelected
                ? AppColors.primary
                : (isDark
                      ? AppColors.textPrimaryDark
                      : AppColors.textPrimaryLight),
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            fontSize: 13,
          ),
          backgroundColor: isDark ? AppColors.surfaceDark : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
              color: isSelected ? AppColors.primary : Colors.grey.shade300,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildTimePickerField(
    String label,
    TimeOfDay time,
    VoidCallback onTap,
    bool isDark,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        const SizedBox(height: 4),
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: isDark ? AppColors.surfaceDark : Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE5E7EB)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _formatTimeDisplay(time),
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Icon(Icons.access_time, color: Colors.grey, size: 18),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAmenityToggle(String amenity, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: [
          if (!isDark)
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFF3F4F6),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              _amenityIcons[amenity],
              color: const Color(0xFF1F2937),
              size: 18,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              amenity,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ),
          Switch(
            value: _amenities[amenity]!,
            onChanged: (val) => setState(() => _amenities[amenity] = val),
            activeColor: AppColors.primary,
          ),
        ],
      ),
    );
  }
}
