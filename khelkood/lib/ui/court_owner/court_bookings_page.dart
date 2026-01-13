import 'package:flutter/material.dart';
import '../../design/app_colors.dart';
import '../../design/app_dimensions.dart';
import 'widgets/court_owner_card.dart';
import 'package:go_router/go_router.dart';
import '../../routing/app_router.dart';

class CourtBookingsPage extends StatefulWidget {
  const CourtBookingsPage({super.key});

  @override
  State<CourtBookingsPage> createState() => _CourtBookingsPageState();
}

class _CourtBookingsPageState extends State<CourtBookingsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _tabs = [
    'All',
    'Pending (3)',
    'Confirmed',
    'Completed',
    'Cancelled',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? AppColors.backgroundDark
          : AppColors.backgroundLight,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context, isDark),
            _buildTabSelector(context, isDark),
            _buildDateSelector(context, isDark),
            Expanded(child: _buildBookingsList(context, isDark)),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, bool isDark) {
    return Padding(
      padding: const EdgeInsets.all(AppDimensions.paddingLG),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Bookings',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: isDark
                  ? AppColors.textPrimaryDark
                  : AppColors.textPrimaryLight,
            ),
          ),
          Row(
            children: [
              _buildRoundButton(Icons.search, isDark),
              const SizedBox(width: AppDimensions.paddingSM),
              _buildRoundButton(Icons.filter_list, isDark),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRoundButton(IconData icon, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.white,
        shape: BoxShape.circle,
        border: Border.all(
          color: isDark ? AppColors.borderDark : Colors.grey.shade100,
        ),
      ),
      child: Icon(
        icon,
        size: 20,
        color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
      ),
    );
  }

  Widget _buildTabSelector(BuildContext context, bool isDark) {
    return Container(
      height: 48,
      child: TabBar(
        controller: _tabController,
        isScrollable: true,
        indicatorColor: Colors.transparent,
        dividerColor: Colors.transparent,
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingLG,
        ),
        tabAlignment: TabAlignment.start,
        labelPadding: const EdgeInsets.symmetric(horizontal: 4),
        tabs: _tabs.map((tab) {
          return Tab(
            child: AnimatedBuilder(
              animation: _tabController,
              builder: (context, child) {
                final isSelected = _tabs.indexOf(tab) == _tabController.index;
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.primary
                        : (isDark ? AppColors.surfaceDark : AppColors.white),
                    borderRadius: BorderRadius.circular(
                      AppDimensions.radiusRound,
                    ),
                    border: Border.all(
                      color: isSelected
                          ? AppColors.primary
                          : (isDark
                                ? AppColors.borderDark
                                : Colors.grey.shade100),
                    ),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: AppColors.primary.withOpacity(0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ]
                        : null,
                  ),
                  child: Text(
                    tab,
                    style: TextStyle(
                      color: isSelected
                          ? Colors.white
                          : (isDark
                                ? AppColors.textSecondaryDark
                                : AppColors.textSecondaryLight),
                      fontSize: 12,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.w500,
                    ),
                  ),
                );
              },
            ),
          );
        }).toList(),
        onTap: (index) => setState(() {}),
      ),
    );
  }

  Widget _buildDateSelector(BuildContext context, bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingLG,
        vertical: AppDimensions.paddingMD,
      ),
      child: Container(
        padding: const EdgeInsets.only(top: AppDimensions.paddingMD),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: isDark ? AppColors.borderDark : Colors.grey.shade100,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  Icons.calendar_today_outlined,
                  size: 16,
                  color: isDark ? Colors.grey : Colors.grey.shade600,
                ),
                const SizedBox(width: 8),
                Text(
                  'Oct 2023',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: isDark
                        ? AppColors.textSecondaryDark
                        : AppColors.textSecondaryLight,
                  ),
                ),
              ],
            ),
            Text(
              'SELECT RANGE',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBookingsList(BuildContext context, bool isDark) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingLG),
      children: [
        _buildSectionHeader('Today, 24 Oct', isDark),
        _buildBookingLargeCard(
          context,
          name: 'Ali Khan',
          id: '#BK-8392',
          status: 'Confirmed',
          statusColor: Colors.green,
          time: '17:00 - 18:00',
          court: 'Futsal Court A',
          payment: 'Paid via Card',
          price: 'PKR 2,500',
          image:
              'https://lh3.googleusercontent.com/aida-public/AB6AXuAY01BT97KxZ2rszgJrRACrqlqOGfSPOkA_cK0I86j-Nq26E_5zubbCs6OVkZWLxuEZLYaXENPI8DtylEbL_NtZjePfDqpUjHu0hC3N5Ec7As0qmB5g4cex5G7blYMGKWfOEyYInNwMjKC_4Z_8XnXScLQcuesUrtaJr93W0VpECB-vZubPt4zi9T96tU2Yl55jvr4Kq5tuGmQyoQJebzD-S6R5palEpgEH8WOGDzHptiXzU7W95e-yra0POObIQ2VOrPu6qMZrTnU',
          isDark: isDark,
          sideColor: Colors.green,
        ),
        const SizedBox(height: AppDimensions.paddingMD),
        _buildBookingLargeCard(
          context,
          name: 'Sara Ahmed',
          id: '#BK-9921',
          status: 'Pending',
          statusColor: Colors.orange,
          time: '19:30 - 21:30',
          court: 'Tennis Court B',
          payment: 'Payment Pending',
          price: 'PKR 4,000',
          image:
              'https://lh3.googleusercontent.com/aida-public/AB6AXuBtn-B4pJR-Thg7D3YderPKm56UmwaJbi0PxUXDiTkaPLz26ZoXutBDseYOU5LjaOUhAgUpXpVBdL6NzeVr2TIx8mH9TesClGRUEGLDR5fJY8ewP8aNzY3eZD01CAvQ8Br5nsgmKjlqjRjw7JYqRyZh9Nu8M1GK4qSAcyw3Br7k0WaI0FwausdgrVMYT1ml3mP32nxCVUD3pkRdEnxLTf0ZNwiR8bN9pMDn--FNBqkAh6dJqsD1AEgCUS6TYK7Lqp35XC4xvlPsM10',
          isDark: isDark,
          sideColor: Colors.orange,
          showActions: true,
        ),
        const SizedBox(height: AppDimensions.paddingMD),
        _buildBookingLargeCard(
          context,
          name: 'Omar Malik',
          id: '#BK-8100',
          status: 'Completed',
          statusColor: Colors.blue,
          time: '10:00 - 11:00',
          court: 'Badminton Court 1',
          payment: 'Cash Payment',
          price: 'PKR 1,200',
          initials: 'OM',
          isDark: isDark,
          sideColor: Colors.blue,
          opacity: 0.9,
        ),
        const SizedBox(height: AppDimensions.paddingLG),
        _buildSectionHeader('Yesterday, 23 Oct', isDark),
        _buildBookingLargeCard(
          context,
          name: 'Rizwan Ahmed',
          id: '#BK-7721',
          status: 'Cancelled',
          statusColor: Colors.grey,
          time: '20:00 - 21:00',
          court: 'Futsal Court B',
          payment: 'Refunded',
          price: 'PKR 2,500',
          initials: 'RA',
          isDark: isDark,
          sideColor: Colors.grey,
          opacity: 0.7,
          isCancelled: true,
        ),
        const SizedBox(height: AppDimensions.paddingXXL),
      ],
    );
  }

  Widget _buildSectionHeader(String title, bool isDark) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
          letterSpacing: 2,
        ),
      ),
    );
  }

  Widget _buildBookingLargeCard(
    BuildContext context, {
    required String name,
    required String id,
    required String status,
    required Color statusColor,
    required String time,
    required String court,
    required String payment,
    required String price,
    String? image,
    String? initials,
    required bool isDark,
    required Color sideColor,
    bool showActions = false,
    double opacity = 1.0,
    bool isCancelled = false,
  }) {
    return CourtOwnerCard(
      opacity: opacity,
      sideColor: sideColor,
      padding: const EdgeInsets.all(AppDimensions.paddingMD),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  if (image != null)
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(image),
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  else
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: statusColor.withOpacity(0.1),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        initials ?? '',
                        style: TextStyle(
                          color: statusColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: isDark
                              ? AppColors.textPrimaryDark
                              : AppColors.textPrimaryLight,
                        ),
                      ),
                      Text(
                        id,
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  status.toUpperCase(),
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildIconInfo(Icons.schedule_outlined, time, isDark),
              const SizedBox(width: 24),
              _buildIconInfo(Icons.stadium_outlined, court, isDark),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.only(top: 12),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: isDark ? AppColors.borderDark : Colors.grey.shade100,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      isCancelled
                          ? Icons.cancel_schedule_send
                          : (status == 'Pending'
                                ? Icons.hourglass_top
                                : Icons.check_circle_outlined),
                      size: 18,
                      color: isCancelled
                          ? Colors.red
                          : (status == 'Pending'
                                ? Colors.orange
                                : Colors.green),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      payment,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: isDark
                            ? AppColors.textSecondaryDark
                            : AppColors.textSecondaryLight,
                      ),
                    ),
                  ],
                ),
                Text(
                  price,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isDark
                        ? AppColors.textPrimaryDark
                        : AppColors.textPrimaryLight,
                    decoration: isCancelled ? TextDecoration.lineThrough : null,
                  ),
                ),
              ],
            ),
          ),
          if (showActions) ...[
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      foregroundColor: Colors.red,
                      side: BorderSide(color: Colors.red.withOpacity(0.2)),
                      elevation: 0,
                      minimumSize: const Size(0, 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Reject',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      elevation: 2,
                      shadowColor: AppColors.primary.withOpacity(0.4),
                      minimumSize: const Size(0, 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Approve',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildIconInfo(IconData icon, String text, bool isDark) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppColors.primary),
        const SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: isDark
                ? AppColors.textSecondaryDark
                : AppColors.textSecondaryLight,
          ),
        ),
      ],
    );
  }
}
