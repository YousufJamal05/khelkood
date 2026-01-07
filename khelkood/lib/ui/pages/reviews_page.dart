import 'package:flutter/material.dart';
import '../../design/app_colors.dart';
import 'package:go_router/go_router.dart';

class ReviewsPage extends StatelessWidget {
  const ReviewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "User Reviews",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Column(
        children: [
          // Rating Summary
          Container(
            padding: const EdgeInsets.all(24),
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark ? AppColors.surfaceDark : Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: isDark ? AppColors.borderDark : AppColors.borderLight,
              ),
            ),
            child: Row(
              children: [
                Column(
                  children: [
                    const Text(
                      "4.8",
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                    Row(
                      children: List.generate(
                        5,
                        (i) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 16,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      "124 Reviews",
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
                const SizedBox(width: 32),
                Expanded(
                  child: Column(
                    children: [
                      _RatingBar(label: "5", progress: 0.8),
                      _RatingBar(label: "4", progress: 0.15),
                      _RatingBar(label: "3", progress: 0.03),
                      _RatingBar(label: "2", progress: 0.01),
                      _RatingBar(label: "1", progress: 0.01),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Filters
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                _FilterChip(label: "Recent", isSelected: true),
                _FilterChip(label: "Highest Rating"),
                _FilterChip(label: "With Photos"),
                _FilterChip(label: "Lowest Rating"),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Reviews List
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: 5,
              separatorBuilder: (context, index) => const Divider(height: 32),
              itemBuilder: (context, index) {
                return const _ReviewItem();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _RatingBar extends StatelessWidget {
  final String label;
  final double progress;
  const _RatingBar({required this.label, required this.progress});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(2),
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.grey[200],
                valueColor: const AlwaysStoppedAnimation(AppColors.primary),
                minHeight: 4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  const _FilterChip({required this.label, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primary : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSelected ? AppColors.primary : Colors.grey[300]!,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.grey,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
        ),
      ),
    );
  }
}

class _ReviewItem extends StatelessWidget {
  const _ReviewItem();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const CircleAvatar(
              backgroundImage: NetworkImage(
                "https://lh3.googleusercontent.com/aida-public/AB6AXuApjhvZQBlUtgEPBMV0Z4oOgy0WbV4F2nLl714gndZQLitZzmaEsfZEbEXtkXrcMNfoVHh9XiB-BVoyHn7Hzz9AGfAygLPyPFWH5vTouDLkAZQnLSasGZwQVblMOYtdc-TeqsIZFxFo9ALPskJt8AwBwy_mECWaMeqAj5oD-x6vBnzpDGvZMO7WJSop_gNgWhoeuBbg6JCVK2-rOxQ4NZ7vZSqbnV389vRoKwlrVxlliXsnpLk1gXkL_amhYRtEhUrV6JEGganIa2A",
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Hamza Ali",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "2 days ago",
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ),
            Row(
              children: List.generate(
                5,
                (i) => Icon(
                  Icons.star,
                  color: i < 5 ? Colors.amber : Colors.grey[300],
                  size: 14,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          "Excellent facility! The lighting is great and the booking process was very smooth through KhelKhood. Highly recommend for night matches.",
          style: TextStyle(
            color: isDark ? Colors.grey[300] : Colors.grey[800],
            height: 1.5,
          ),
        ),
      ],
    );
  }
}
