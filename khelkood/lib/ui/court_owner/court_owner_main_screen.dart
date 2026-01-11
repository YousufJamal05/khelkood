import 'package:flutter/material.dart';
import 'widgets/court_owner_bottom_nav.dart';
import 'court_owner_home_screen.dart';
import 'court_bookings_page.dart';
import 'court_analytics_page.dart';
import 'my_courts_page.dart';
import 'court_owner_profile_page.dart';

class CourtOwnerMainScreen extends StatefulWidget {
  const CourtOwnerMainScreen({super.key});

  @override
  State<CourtOwnerMainScreen> createState() => _CourtOwnerMainScreenState();
}

class _CourtOwnerMainScreenState extends State<CourtOwnerMainScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const CourtOwnerHomeScreen(),
    const CourtBookingsPage(),
    const CourtAnalyticsPage(),
    const MyCourtsPage(),
    const CourtOwnerProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: CourtOwnerBottomNav(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
