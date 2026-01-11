import 'package:flutter/material.dart';
import '../../../design/app_colors.dart';
import '../../../design/app_dimensions.dart';

class CourtOwnerCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final Color? borderColor;
  final double? width;
  final double? height;
  final double opacity;
  final Color? sideColor;

  const CourtOwnerCard({
    super.key,
    required this.child,
    this.padding,
    this.borderColor,
    this.width,
    this.height,
    this.opacity = 1.0,
    this.sideColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Opacity(
      opacity: opacity,
      child: Container(
        width: width,
        height: height,
        padding: padding ?? const EdgeInsets.all(AppDimensions.paddingMD),
        decoration: BoxDecoration(
          color: isDark ? AppColors.surfaceDark : AppColors.white,
          borderRadius: BorderRadius.circular(AppDimensions.radiusLG),
          border: Border.all(
            color:
                borderColor ??
                (isDark ? AppColors.borderDark : Colors.grey.shade100),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            if (sideColor != null)
              Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                child: Container(
                  width: 6,
                  decoration: BoxDecoration(
                    color: sideColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(AppDimensions.radiusLG),
                      bottomLeft: Radius.circular(AppDimensions.radiusLG),
                    ),
                  ),
                ),
              ),
            Padding(
              padding: sideColor != null
                  ? const EdgeInsets.only(left: AppDimensions.paddingSM)
                  : EdgeInsets.zero,
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}
