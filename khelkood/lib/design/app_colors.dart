import 'package:flutter/material.dart';

/// KhelKhood Color Theme
///
/// Primary: #00c753 (Vibrant Green)
/// Background Light: #f5f8f7
/// Background Dark: #0f2317
/// Surface Dark: #1a3b2a

class AppColors {
  AppColors._(); // Private constructor to prevent instantiation

  // Primary/Brand Color
  static const Color primary = Color(0xFF00C753);
  static const Color primaryLight = Color(0xFF33D275);
  static const Color primaryDark = Color(0xFF00A344);

  // Background Colors
  static const Color backgroundLight = Color(0xFFF5F8F7);
  static const Color backgroundDark = Color(0xFF0F2317);
  static const Color surfaceDark = Color(0xFF1A3B2A);

  // Neutral/Neutral
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  // Text Colors
  static const Color textPrimaryLight = Color(0xFF0F2317);
  static const Color textSecondaryLight = Color(0xB30F2317); // 70% opacity
  static const Color textTertiaryLight = Color(0x4D0F2317); // 30% opacity

  static const Color textPrimaryDark = Color(0xFFFFFFFF);
  static const Color textSecondaryDark = Color(0xB3FFFFFF); // 70% opacity
  static const Color textTertiaryDark = Color(0x33FFFFFF); // 20% opacity

  // Status Colors
  static const Color success = Color(0xFF00C753);
  static const Color error = Color(0xFFE53935);
  static const Color warning = Color(0xFFFFA000);
  static const Color info = Color(0xFF1976D2);

  // Border & Divider
  static const Color borderLight = Color(0x1A00C753); // primary/10
  static const Color borderDark = Color(0x3300C753); // primary/20
}
