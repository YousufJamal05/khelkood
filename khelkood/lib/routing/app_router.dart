import 'package:common/providers/auth_state_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../ui/pages/splash_page.dart';
import '../ui/pages/onboarding_page.dart';
import '../ui/pages/role_selection_page.dart';
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
import '../ui/pages/complete_profile_page.dart';
import '../ui/court_owner/court_owner_main_screen.dart';
import '../ui/court_owner/court_owner_home_screen.dart';
import '../ui/court_owner/court_bookings_page.dart';
import '../ui/court_owner/court_analytics_page.dart';
import '../ui/court_owner/my_courts_page.dart';
import '../ui/court_owner/add_court_page.dart';
import '../ui/court_owner/block_slots_page.dart';
import '../ui/court_owner/court_owner_profile_page.dart';

class AppRouter {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String roleSelection = '/role-selection';
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
  static const String completeProfile = '/complete-profile';

  // Court Owner Routes
  static const String ownerHome = '/owner-home';
  static const String ownerBookings = '/owner-bookings';
  static const String ownerAnalytics = '/owner-analytics';
  static const String ownerCourts = '/owner-courts';
  static const String ownerAddCourt = '/owner-add-court';
  static const String ownerBlockSlot = '/owner-block-slot';
  static const String ownerProfile = '/owner-profile';

  static final Provider<GoRouter> routerProvider = Provider<GoRouter>((ref) {
    final notifier = RouterNotifier(ref);

    return GoRouter(
      initialLocation: splash,
      refreshListenable: notifier,
      redirect: (context, state) {
        final authState = ref.read(authStateProvider);
        final currentUserAsync = ref.read(currentUserProvider);

        final isLoggedIn = authState.value != null;
        final isLoggingIn = state.uri.toString() == auth;
        final isSplash = state.uri.toString() == splash;
        final isOnboarding = state.uri.toString() == onboarding;
        final isRoleSelection = state.uri.toString() == roleSelection;
        final isOtp = state.uri.toString() == otp;
        final isCompletingProfile = state.uri.toString() == completeProfile;

        if (authState.isLoading) return null;

        if (!isLoggedIn) {
          if (isLoggingIn ||
              isSplash ||
              isOnboarding ||
              isOtp ||
              isRoleSelection)
            return null;
          return auth;
        }

        // isLoggedIn == true
        final isAtAuthFlow =
            isSplash || isLoggingIn || isOnboarding || isOtp || isRoleSelection;

        // If we are at the auth flow, we wait for the profile to decide where to go
        if (currentUserAsync.isLoading && isAtAuthFlow) {
          return null;
        }

        final user = currentUserAsync.value;
        final hasProfile =
            user != null &&
            user.displayName != null &&
            user.displayName!.trim().isNotEmpty;

        if (!hasProfile) {
          if (!isCompletingProfile) return completeProfile;
          return null;
        }

        // Profile exists/complete
        if (isAtAuthFlow || isCompletingProfile) {
          if (user.role == 'owner') return ownerHome;
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
        GoRoute(
          path: roleSelection,
          builder: (context, state) => const RoleSelectionPage(),
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
        GoRoute(
          path: completeProfile,
          builder: (context, state) => const CompleteProfilePage(),
        ),
        // ... existing routes ...
        StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) {
            return CourtOwnerMainScreen(navigationShell: navigationShell);
          },
          branches: [
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: ownerHome,
                  builder: (context, state) => const CourtOwnerHomeScreen(),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: ownerBookings,
                  builder: (context, state) => const CourtBookingsPage(),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: ownerCourts,
                  builder: (context, state) => const MyCourtsPage(),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: ownerProfile,
                  builder: (context, state) => const CourtOwnerProfilePage(),
                ),
              ],
            ),
          ],
        ),
        GoRoute(
          path: ownerAddCourt,
          builder: (context, state) => const AddCourtPage(),
        ),
        GoRoute(
          path: ownerBlockSlot,
          builder: (context, state) => const BlockSlotsPage(),
        ),
        GoRoute(
          path: ownerAnalytics,
          builder: (context, state) => const CourtAnalyticsPage(),
        ),
      ],
    );
  });

  static GoRouter get router =>
      throw UnimplementedError("Use routerProvider instead");
}

class RouterNotifier extends ChangeNotifier {
  RouterNotifier(Ref ref) {
    _subscription1 = ref.listen(
      authStateProvider,
      (_, __) => notifyListeners(),
    );
    _subscription2 = ref.listen(
      currentUserProvider,
      (_, __) => notifyListeners(),
    );
  }

  late final ProviderSubscription _subscription1;
  late final ProviderSubscription _subscription2;

  @override
  void dispose() {
    _subscription1.close();
    _subscription2.close();
    super.dispose();
  }
}
