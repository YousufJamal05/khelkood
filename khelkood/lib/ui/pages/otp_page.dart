import 'package:common/providers/auth_state_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../design/app_colors.dart';
import 'package:khelkood/providers/auth_providers.dart';
import '../widgets/khelkhood_button.dart';

class OtpPage extends ConsumerWidget {
  final String phoneNumber;
  final String verificationId;

  const OtpPage({
    super.key,
    required this.phoneNumber,
    required this.verificationId,
  });

  void _onChanged(String value, int index, List<FocusNode> focusNodes) {
    if (value.length == 1 && index < 5) {
      focusNodes[index + 1].requestFocus();
    }
    if (value.isEmpty && index > 0) {
      focusNodes[index - 1].requestFocus();
    }
  }

  Future<void> _verifyOtp(BuildContext context, WidgetRef ref) async {
    final controllers = ref.read(otpControllersProvider);
    final otp = controllers.map((c) => c.text).join();

    if (otp.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a complete 6-digit code')),
      );
      return;
    }

    ref.read(authLoadingProvider.notifier).setLoading(true);
    try {
      final authService = ref.read(authServiceProvider);
      await authService.verifyOTP(verificationId: verificationId, smsCode: otp);
      // Navigation handled by router
    } catch (e) {
      ref.read(authLoadingProvider.notifier).setLoading(false);
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Invalid code: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isLoading = ref.watch(authLoadingProvider);
    final controllers = ref.watch(otpControllersProvider);
    final focusNodes = ref.watch(otpFocusNodesProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: isDark ? Colors.white : AppColors.textPrimaryLight,
          ),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 20),
              // Illustration
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Image.network(
                    "https://lh3.googleusercontent.com/aida-public/AB6AXuC6b2ZG32UUMt7icis6unE_8UsaK4ew1fUCJRLDDSvKjzU_PhSwz1-hYIAAz7NrzBDrVd5TbUwj-J6Pt9iABH7lC5Fz5zTQHdnOx6pkUOOJOheNZU3cH6wxaujTNIg4cNXJGN8jx1foKgKgxr1iBlk1UHNQt_6-Ji2uQCu2TopJw97I_NvMOIl6LGn677w7Ff9-0mXLOT-lcxkAfvRZHW2XGvaZf5qwLz1DAuaxZJrF0tTjnou_pkdGfo5yPF2_b-4VZPUhjxQGaEE",
                    width: 80,
                    height: 80,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Title & Description
              Text(
                "Enter Verification Code",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: isDark
                        ? AppColors.textSecondaryDark
                        : AppColors.textSecondaryLight,
                  ),
                  children: [
                    const TextSpan(
                      text:
                          "We have sent a 6-digit verification code to the number ending in ",
                    ),
                    TextSpan(
                      text: phoneNumber.length > 4
                          ? phoneNumber.substring(phoneNumber.length - 4)
                          : phoneNumber,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),

              // OTP Input
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  6,
                  (index) => Flexible(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      child: TextField(
                        controller: controllers[index],
                        focusNode: focusNodes[index],
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        maxLength: 1,
                        onChanged: (value) =>
                            _onChanged(value, index, focusNodes),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(
                          counterText: "",
                          filled: true,
                          fillColor: isDark
                              ? AppColors.surfaceDark
                              : const Color(0xFFF9FAFB),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 12,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: isDark
                                  ? AppColors.borderDark
                                  : AppColors.borderLight,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: AppColors.primary,
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Resend Section
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Didn't receive the code? ",
                    style: TextStyle(
                      color: isDark
                          ? AppColors.textSecondaryDark
                          : AppColors.textSecondaryLight,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Resend",
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 48),

              // Verify Button
              KhelKhoodButton(
                text: isLoading ? "Verifying..." : "Verify & Continue",
                onPressed: isLoading ? () {} : () => _verifyOtp(context, ref),
                icon: isLoading ? null : Icons.arrow_forward,
              ),
              const SizedBox(height: 48),
            ],
          ),
        ),
      ),
    );
  }
}
