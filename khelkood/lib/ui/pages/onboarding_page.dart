import 'package:flutter/material.dart';
import '../../design/app_colors.dart';
import '../widgets/khelkhood_button.dart';
import 'package:go_router/go_router.dart';
import '../../routing/app_router.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _onboardingData = [
    {
      'title': 'Discover Courts Near You',
      'description':
          'Find the best indoor cricket nets, futsal grounds, and padel courts right in your neighborhood.',
      'image':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuA5nWMcbc-IaManIzT0KCahPkcDC_2ApniDdZBRm_y5cAnX6irbxxTy4P0LY35oIuaCif3h_TaO_vq-VlG4wJsGXjsM6Xrons6kaYd2E7Ekga6N2UYFALk80ynNbQP1Uyg197jUx5dHmR93OrbtweRWkOlkUt2kIWLzJ6Y99VlZ2EzQR-mcqcEHi1rDcDsm9CMjNXMqjSxxRiyJaOBbVilyiUpk_S_wV79GrreUANmaYABBexm--w-xzd6SDQ6Czpludsvwx7LsVHg',
    },
    {
      'title': 'Book Instantly',
      'description':
          'Browse available slots for cricket, futsal, and padel. Secure your court in just a few taps.',
      'image':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuAJOUXj-hC_yibPW_zVr_qRtcEXrtXfQ_GRsbAWV31HMsYTzoYN3WKRVEgo0LkaaRpgAdc0QXLFzKV2fQ_qfW-Y9FaWWHJkzKNG9WZVBuStapZxF2V9zJZ4vOBdU1yHLzo3Tdn0od0lFg0RawLyUwR_O1OUg--Xw8Tuf3itjzR93HTFR5PsbASKmX2IgtZmeIot1nCN7Zfn1ZDNcldtYI09dlj9cBsajbqGOLZQedpXQlQV95Lscp76avYs3G7bCsNXkhEY_4Gp35A',
    },
    {
      'title': 'Play Without Hassle',
      'description':
          'Say goodbye to endless phone calls. Find, book, and pay for cricket, futsal, and padel courts in seconds.',
      'image':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuB1g8x_v7Z8wIGNwyJ0xV4IXY8nTbVn1uwR4ch6swWlrsI6E6y8y1mtnV8v1KA-oVAAt7kd1ro6RBnD1eWTjUSrJ6rbSCpxHBcgyBWhCU1pwc-CMV1WY8yDD3xtQd8FS9N00D1w79kdHFWn8qgUsnlhVSus95tITHMQQqzkzirBcbgOVnDAAMSRiC5iNOHLjS3ohSfJhAzwBsKzTBxpx_HmfHUxDSUDgHq6weGJnEhCK9ppoyec2U4fVwA_b_OIWhCCC1gdtFGhGZ4',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Skip Button
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: TextButton(
                  onPressed: () => _navigateToRoleSelection(),
                  child: Text(
                    'Skip',
                    style: TextStyle(
                      color: isDark
                          ? AppColors.textSecondaryDark
                          : AppColors.textSecondaryLight,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),

            // Page View
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) => setState(() => _currentPage = index),
                itemCount: _onboardingData.length,
                itemBuilder: (context, index) {
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 24,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Illustration
                          Container(
                            height: 280,
                            decoration: BoxDecoration(
                              color: isDark
                                  ? AppColors.surfaceDark
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(32),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 20,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  width: 220,
                                  height: 220,
                                  decoration: BoxDecoration(
                                    color: AppColors.primary.withOpacity(0.05),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(24),
                                  child: Image.network(
                                    _onboardingData[index]['image']!,
                                    height: 220,
                                    width: 220,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 32),

                          // Text Content
                          Text(
                            _onboardingData[index]['title']!,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.displaySmall
                                ?.copyWith(
                                  fontWeight: FontWeight.w800,
                                  color: isDark
                                      ? Colors.white
                                      : AppColors.textPrimaryLight,
                                  fontSize:
                                      24, // Responsive font size adjustment
                                ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            _onboardingData[index]['description']!,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(
                                  color: isDark
                                      ? AppColors.textSecondaryDark
                                      : AppColors.textSecondaryLight,
                                  height: 1.4,
                                  fontSize:
                                      14, // Responsive font size adjustment
                                ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            // Bottom Actions
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 24, 32, 48),
              child: Column(
                children: [
                  // Page Indicators
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _onboardingData.length,
                      (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.only(right: 8),
                        height: 8,
                        width: _currentPage == index ? 24 : 8,
                        decoration: BoxDecoration(
                          color: _currentPage == index
                              ? AppColors.primary
                              : AppColors.primary.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Next / Get Started Button
                  KhelKhoodButton(
                    text: _currentPage == _onboardingData.length - 1
                        ? 'Get Started'
                        : 'Next',
                    onPressed: () {
                      if (_currentPage < _onboardingData.length - 1) {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      } else {
                        _navigateToRoleSelection();
                      }
                    },
                    icon: Icons.arrow_forward,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToRoleSelection() {
    context.go(AppRouter.roleSelection);
  }
}
