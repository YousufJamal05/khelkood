import 'package:flutter/material.dart';
import '../../design/app_colors.dart';
import 'package:go_router/go_router.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final List<Map<String, dynamic>> notifications = [
      {
        'title': 'Booking Confirmed!',
        'message':
            'Your booking at Smash Arena for tomorrow has been confirmed.',
        'time': '2 mins ago',
        'isUnread': true,
        'icon': Icons.check_circle_outline,
      },
      {
        'title': 'Slot Available',
        'message': 'A new slot is available at DHA Sports Complex for Friday.',
        'time': '1 hour ago',
        'isUnread': true,
        'icon': Icons.event_available,
      },
      {
        'title': 'Special Offer',
        'message': 'Get 20% off on your next futsal booking this weekend!',
        'time': '5 hours ago',
        'isUnread': false,
        'icon': Icons.local_offer_outlined,
      },
      {
        'title': 'Payment Successful',
        'message': 'Your payment for booking #BK-1234 has been processed.',
        'time': 'Yesterday',
        'isUnread': false,
        'icon': Icons.account_balance_wallet_outlined,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Notifications",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              "Mark all read",
              style: TextStyle(color: AppColors.primary),
            ),
          ),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: notifications.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final item = notifications[index];
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: item['isUnread']
                  ? AppColors.primary.withOpacity(0.05)
                  : (isDark ? AppColors.surfaceDark : Colors.white),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: item['isUnread']
                    ? AppColors.primary.withOpacity(0.2)
                    : (isDark ? AppColors.borderDark : AppColors.borderLight),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: isDark ? Colors.white10 : Colors.grey[100],
                    shape: BoxShape.circle,
                  ),
                  child: Icon(item['icon'], color: AppColors.primary, size: 24),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            item['title'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          if (item['isUnread'])
                            Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: AppColors.primary,
                                shape: BoxShape.circle,
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item['message'],
                        style: TextStyle(
                          color: isDark ? Colors.grey[400] : Colors.grey[600],
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        item['time'],
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
