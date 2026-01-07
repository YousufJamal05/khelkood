import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../ui/pages/splash_page.dart';
import '../ui/pages/onboarding_page.dart';
import '../ui/pages/auth_page.dart';
import '../ui/pages/otp_page.dart';
import '../ui/pages/explore_page.dart';
import '../ui/pages/search_page.dart';
import '../ui/pages/details_page.dart';
import '../ui/pages/booking_selection_page.dart';
import '../ui/pages/booking_confirmation_page.dart';
import '../ui/pages/bookings_page.dart';
import '../ui/pages/profile_page.dart';
import '../ui/pages/map_page.dart';
import '../ui/pages/notifications_page.dart';
import '../ui/pages/favorite_courts_page.dart';
import '../ui/pages/reviews_page.dart';

class AppRouter {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String auth = '/auth';
  static const String otp = '/otp';
  static const String explore = '/explore';
  static const String search = '/search';
  static const String details = '/details';
  static const String bookingSelection = '/booking-selection';
  static const String bookingConfirmation = '/booking-confirmation';
  static const String bookings = '/bookings';
  static const String profile = '/profile';
  static const String map = '/map';
  static const String notifications = '/notifications';
  static const String favorites = '/favorites';
  static const String reviews = '/reviews';

  static final GoRouter router = GoRouter(
    initialLocation: splash,
    routes: [
      GoRoute(path: splash, builder: (context, state) => const SplashPage()),
      GoRoute(
        path: onboarding,
        builder: (context, state) => const OnboardingPage(),
      ),
      GoRoute(path: auth, builder: (context, state) => const AuthPage()),
      GoRoute(
        path: otp,
        builder: (context, state) {
          final phoneNumber = state.extra as String? ?? "";
          return OtpPage(phoneNumber: phoneNumber);
        },
      ),
      GoRoute(path: explore, builder: (context, state) => const ExplorePage()),
      GoRoute(path: search, builder: (context, state) => const SearchPage()),
      GoRoute(path: details, builder: (context, state) => const DetailsPage()),
      GoRoute(
        path: bookingSelection,
        builder: (context, state) => const BookingSelectionPage(),
      ),
      GoRoute(
        path: bookingConfirmation,
        builder: (context, state) => const BookingConfirmationPage(),
      ),
      GoRoute(
        path: bookings,
        builder: (context, state) => const BookingsPage(),
      ),
      GoRoute(path: profile, builder: (context, state) => const ProfilePage()),
      GoRoute(path: map, builder: (context, state) => const MapPage()),
      GoRoute(
        path: notifications,
        builder: (context, state) => const NotificationsPage(),
      ),
      GoRoute(
        path: favorites,
        builder: (context, state) => const FavoriteCourtsPage(),
      ),
      GoRoute(path: reviews, builder: (context, state) => const ReviewsPage()),
    ],
  );
}
