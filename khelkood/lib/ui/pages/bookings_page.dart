import 'package:flutter/material.dart';
import '../../design/app_colors.dart';
import '../views/bottom_nav_view.dart';
import 'package:go_router/go_router.dart';
import '../../routing/app_router.dart';

class BookingsPage extends StatefulWidget {
  const BookingsPage({super.key});

  @override
  State<BookingsPage> createState() => _BookingsPageState();
}

class _BookingsPageState extends State<BookingsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Bookings",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.primary,
          unselectedLabelColor: Colors.grey,
          indicatorColor: AppColors.primary,
          indicatorWeight: 3,
          labelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          tabs: const [
            Tab(text: "Upcoming"),
            Tab(text: "Completed"),
            Tab(text: "Cancelled"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _BookingsList(isDark: isDark),
          const Center(child: Text("No completed bookings")),
          const Center(child: Text("No cancelled bookings")),
        ],
      ),
      bottomNavigationBar: KhelKhoodBottomNav(
        selectedIndex: 1,
        onItemSelected: (index) {
          if (index == 0) context.go(AppRouter.explore);
          if (index == 2) context.push(AppRouter.map);
          if (index == 3) context.go(AppRouter.profile);
        },
      ),
    );
  }
}

class _BookingsList extends StatelessWidget {
  final bool isDark;
  const _BookingsList({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _BookingCard(
          isDark: isDark,
          title: "Smash Arena - Court A",
          location: "Gulshan-e-Iqbal, Block 13",
          date: "Sat, 14 Oct",
          time: "08:00 PM - 09:00 PM",
          sport: "Futsal",
          sportIcon: Icons.sports_soccer,
          status: "Confirmed",
          statusColor: AppColors.primary,
          id: "#BK-2023-889",
          price: "PKR 2,500 Paid",
          imageUrl:
              "https://lh3.googleusercontent.com/aida-public/AB6AXuD0hRfIHAmA5T64ZaeyNqdJsDsKbrCyq-_58ty6yH-vhNWY2zeBtYmANhLTT1gHm266dWJ4LeOier6zVhol5guwdPFUWBfST5S97wLT9-CnO9nWCtCLUlkj2M1CZpcP-BlpbBH4410BaeDs0UEtrZWlDlNOeMY764LzPMDQhUs8Ql9CuaDrnL1ejHXHlSoQeClqiRQsSQQKheL2n7mCpQPjYOrEpu3A6YY6NTGredX6Bj2p9cvF7DaharrxWF4UtINx_WvBMHOy7mE",
        ),
        const SizedBox(height: 16),
        _BookingCard(
          isDark: isDark,
          title: "CricBash Nets",
          location: "DHA Phase 6, Karachi",
          date: "Sun, 15 Oct",
          time: "06:00 PM - 07:00 PM",
          sport: "Cricket",
          sportIcon: Icons.sports_cricket,
          status: "Pending",
          statusColor: Colors.orange,
          id: "#BK-2023-902",
          price: "Pay at venue",
          imageUrl:
              "https://lh3.googleusercontent.com/aida-public/AB6AXuDaHsNnhzWOiwfXcxPg7mLnAhrd-7913po_V5pciOkoiOdHCEFz0o7iUtbW8oANX6HhNPXE0QmijSI8mt_46sx_fwxLMcWyQADusDugODOe6j31_s37BF3j8_FU93Wjof_VEl0TLkDthmYwEYjFueSl3ZOlFh8uYZww9ewS0rsQo7tO4i4BJPwZsg7pRNfjh3EmuOaUSyOMwIagz-SlfizMjoN-KRcfR2VnZfNzRlpbjM102VFOtsEX5VsPxWn2-109aaFLCpI0w5A",
        ),
      ],
    );
  }
}

class _BookingCard extends StatelessWidget {
  final bool isDark;
  final String title, location, date, time, sport, status, id, price, imageUrl;
  final IconData sportIcon;
  final Color statusColor;

  const _BookingCard({
    required this.isDark,
    required this.title,
    required this.location,
    required this.date,
    required this.time,
    required this.sport,
    required this.sportIcon,
    required this.status,
    required this.statusColor,
    required this.id,
    required this.price,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark ? AppColors.borderDark : AppColors.borderLight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          // Image Header
          Stack(
            children: [
              Image.network(
                imageUrl,
                height: 140,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.6),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 12,
                left: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white.withOpacity(0.3)),
                  ),
                  child: Row(
                    children: [
                      Icon(sportIcon, color: Colors.white, size: 14),
                      const SizedBox(width: 6),
                      Text(
                        sport,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          // Body
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on,
                                size: 14,
                                color: Colors.grey,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                location,
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: statusColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            status == "Confirmed"
                                ? Icons.check_circle
                                : Icons.schedule,
                            color: statusColor,
                            size: 14,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            status,
                            style: TextStyle(
                              color: statusColor,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isDark
                        ? AppColors.backgroundDark
                        : AppColors.backgroundLight,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.calendar_today, color: statusColor, size: 20),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            date,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            time,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "ID: $id",
                      style: const TextStyle(color: Colors.grey, fontSize: 10),
                    ),
                    Text(
                      price,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: Text(
                          status == "Confirmed" ? "Cancel" : "Modify",
                          style: const TextStyle(fontWeight: FontWeight.bold),
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
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: Text(
                          status == "Confirmed" ? "View Ticket" : "Directions",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
