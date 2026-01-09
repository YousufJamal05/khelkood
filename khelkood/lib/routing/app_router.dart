import 'dart:async';
import 'package:common/providers/auth_state_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

  static final Provider<GoRouter> routerProvider = Provider<GoRouter>((ref) {
    final authState = ref.watch(authStateProvider);

    return GoRouter(
      initialLocation: splash,
      refreshListenable: _GoRouterRefreshStream(
        ref.read(authServiceProvider).authStateChanges,
      ),
      redirect: (context, state) {
        final isLoggedIn = authState.value != null;
        final isLoggingIn = state.uri.toString() == auth;
        final isSplash = state.uri.toString() == splash;
        final isOnboarding = state.uri.toString() == onboarding;
        final isOtp = state.uri.toString() == otp;

        if (authState.isLoading) {
          return null; // Let the splash screen stay or whatever is current
        }

        if (!isLoggedIn) {
          if (isLoggingIn || isSplash || isOnboarding || isOtp) {
            return null;
          }
          return auth;
        }

        if (isLoggedIn && (isLoggingIn || isSplash || isOnboarding)) {
          return explore;
        }

        return null;
      },
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
            final extras = state.extra as Map<String, dynamic>? ?? {};
            final phoneNumber = extras['phoneNumber'] as String? ?? "";
            final verificationId = extras['verificationId'] as String? ?? "";
            return OtpPage(
              phoneNumber: phoneNumber,
              verificationId: verificationId,
            );
          },
        ),
        GoRoute(
          path: explore,
          builder: (context, state) => const ExplorePage(),
        ),
        GoRoute(path: search, builder: (context, state) => const SearchPage()),
        GoRoute(
          path: details,
          builder: (context, state) => const DetailsPage(),
        ),
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
        GoRoute(
          path: profile,
          builder: (context, state) => const ProfilePage(),
        ),
        GoRoute(path: map, builder: (context, state) => const MapPage()),
        GoRoute(
          path: notifications,
          builder: (context, state) => const NotificationsPage(),
        ),
        GoRoute(
          path: favorites,
          builder: (context, state) => const FavoriteCourtsPage(),
        ),
        GoRoute(
          path: reviews,
          builder: (context, state) => const ReviewsPage(),
        ),
      ],
    );
  });

  // Static getter for legacy support if needed, but prefer routerProvider
  // This might break if accessed directly before ref is available.
  // Better to refactor main.dart to use the provider.
  static GoRouter get router =>
      throw UnimplementedError("Use routerProvider instead");
}

class _GoRouterRefreshStream extends ChangeNotifier {
  _GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
      (dynamic _) => notifyListeners(),
    );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
