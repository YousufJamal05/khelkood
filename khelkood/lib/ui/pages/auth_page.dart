import 'package:common/providers/auth_state_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:khelkood/providers/auth_providers.dart';

import '../../design/app_colors.dart';
import '../../routing/app_router.dart';
import '../../providers/feedback_service.dart';
import '../widgets/khelkhood_button.dart';
import '../widgets/khelkhood_text_field.dart';

class AuthPage extends ConsumerWidget {
  const AuthPage({super.key});

  Future<void> _handleGoogleSignIn(BuildContext context, WidgetRef ref) async {
    ref.read(authLoadingProvider.notifier).setLoading(true);
    try {
      final authService = ref.read(authServiceProvider);
      await authService.signInWithGoogle();
      // Navigation handled by router
    } catch (e) {
      if (context.mounted) {
        ref
            .read(feedbackServiceProvider)
            .showError(
              context,
              title: 'Sign-In Failed',
              message: 'Google Sign-In was unsuccessful. Please try again.',
            );
      }
    } finally {
      ref.read(authLoadingProvider.notifier).setLoading(false);
    }
  }

  Future<void> _handlePhoneSignIn(BuildContext context, WidgetRef ref) async {
    final phoneController = ref.read(authPhoneControllerProvider);

    if (phoneController.text.isEmpty) {
      ref
          .read(feedbackServiceProvider)
          .showError(
            context,
            title: 'Phone Number Required',
            message:
                'Please enter your phone number to receive an verification code.',
          );
      return;
    }

    ref.read(authLoadingProvider.notifier).setLoading(true);
    try {
      final authService = ref.read(authServiceProvider);
      final phoneNumber = '+92${phoneController.text.trim()}';

      await authService.signInWithPhoneNumber(
        phoneNumber,
        onVerificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance.signInWithCredential(credential);
        },
        onVerificationFailed: (FirebaseAuthException e) {
          ref.read(authLoadingProvider.notifier).setLoading(false);
          ref
              .read(feedbackServiceProvider)
              .showError(
                context,
                title: 'Verification Failed',
                message: e.message ?? 'Wait a moment and try again.',
              );
        },
        onCodeSent: (String verificationId, int? resendToken) {
          ref.read(authLoadingProvider.notifier).setLoading(false);
          context.push(
            AppRouter.otp,
            extra: {
              'phoneNumber': phoneNumber,
              'verificationId': verificationId,
            },
          );
        },
        onCodeAutoRetrievalTimeout: (String verificationId) {
          ref.read(authLoadingProvider.notifier).setLoading(false);
        },
      );
    } catch (e) {
      ref.read(authLoadingProvider.notifier).setLoading(false);
      if (context.mounted) {
        ref
            .read(feedbackServiceProvider)
            .showError(
              context,
              title: 'Verification Error',
              message:
                  'We couldn\'t send the code. Please check your connection and try again.',
            );
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isLoading = ref.watch(authLoadingProvider);
    final phoneController = ref.watch(authPhoneControllerProvider);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Image
            Container(
              height: MediaQuery.of(context).size.height * 0.35,
              width: double.infinity,
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                image: const DecorationImage(
                  image: NetworkImage(
                    "https://lh3.googleusercontent.com/aida-public/AB6AXuAQA_b7m5b2dWdKCvzF40AdxNLXJ9Lfdhfw-9lgwqguU2JQbSy5Ji7wiJQajtfipm9uThn6y6C_oejpeOVn5Im857RwePdHCKp__j5qlnwPLudosiP-bd1ik6P69uNKZhFI_ZfhArMjc_JwmrwH56XI2BuwL3mQRsDJulJhpNGPNqAVT_8_hRJApe-hl-jZ-R0ZvRn39mtgICUAX5y1u_Zvqrw6YY8_IU3qubLJXek5zZYKwb6rcu4sSOU3DRQrQzv3QuncUrROJiQ",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 16,
                    left: 16,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: isDark
                            ? Colors.black.withOpacity(0.6)
                            : Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColors.primary.withOpacity(0.2),
                        ),
                      ),
                      child: const Icon(
                        Icons.sports_cricket,
                        color: AppColors.primary,
                        size: 32,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: isDark
                            ? Colors.white
                            : AppColors.textPrimaryLight,
                      ),
                      children: const [
                        TextSpan(text: "Let's Get You "),
                        TextSpan(
                          text: "Playing!",
                          style: TextStyle(color: AppColors.primary),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Verify your number to start booking cricket, futsal, and padel courts.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: isDark
                          ? AppColors.textSecondaryDark
                          : AppColors.textSecondaryLight,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Phone Input
                  KhelKhoodTextField(
                    controller: phoneController,
                    label: "Phone Number",
                    hint: "300 1234567",
                    keyboardType: TextInputType.phone,
                    prefix: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text("🇵🇰", style: TextStyle(fontSize: 20)),
                          const SizedBox(width: 8),
                          Text(
                            "+92",
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            width: 1,
                            height: 24,
                            color: Colors.grey.withOpacity(0.3),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Send OTP Button
                  KhelKhoodButton(
                    text: isLoading ? "Processing..." : "Send OTP",
                    onPressed: isLoading
                        ? () {}
                        : () => _handlePhoneSignIn(context, ref),
                    icon: isLoading ? null : Icons.arrow_forward,
                  ),
                  const SizedBox(height: 24),

                  // Divider
                  Row(
                    children: [
                      Expanded(
                        child: Divider(color: Colors.grey.withOpacity(0.3)),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          "Or continue with",
                          style: Theme.of(context).textTheme.labelSmall
                              ?.copyWith(
                                color: isDark
                                    ? AppColors.textTertiaryDark
                                    : AppColors.textTertiaryLight,
                              ),
                        ),
                      ),
                      Expanded(
                        child: Divider(color: Colors.grey.withOpacity(0.3)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Google Button
                  KhelKhoodButton(
                    text: "Google",
                    isSecondary: true,
                    onPressed: isLoading
                        ? () {}
                        : () => _handleGoogleSignIn(context, ref),
                  ),

                  const SizedBox(height: 48),
                  // Footer
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Text.rich(
                        TextSpan(
                          text: "By continuing, you agree to our ",
                          children: [
                            TextSpan(
                              text: "Terms of Service",
                              style: TextStyle(
                                color: AppColors.primary,
                                decoration: TextDecoration.underline,
                                decorationColor: AppColors.primary.withOpacity(
                                  0.3,
                                ),
                              ),
                            ),
                            const TextSpan(text: " and "),
                            TextSpan(
                              text: "Privacy Policy",
                              style: TextStyle(
                                color: AppColors.primary,
                                decoration: TextDecoration.underline,
                                decorationColor: AppColors.primary.withOpacity(
                                  0.3,
                                ),
                              ),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: isDark
                              ? AppColors.textTertiaryDark
                              : AppColors.textTertiaryLight,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
