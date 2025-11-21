import 'package:flutter/material.dart';

class AppColors {
  static const Color background = Color(0xFF000000);
  static const Color surface = Color(0xFF0A0A0A);
  static const Color primary = Color(0xFFFFFFFF);
  static const Color secondary = Color(0xFF808080);
  static const Color accent = Color(0xFF1A1A1A);
  static const Color cardBackground = Color(0xFF0F0F0F);
  static const Color borderColor = Color(0xFF2A2A2A);
}

class AppTextStyles {
  static const TextStyle heroTitle = TextStyle(
    fontSize: 72,
    fontWeight: FontWeight.bold,
    color: AppColors.primary,
    height: 1.2,
  );

  static const TextStyle heroTitleMobile = TextStyle(
    fontSize: 40,
    fontWeight: FontWeight.bold,
    color: AppColors.primary,
    height: 1.2,
  );

  static const TextStyle heroSubtitle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w300,
    color: AppColors.secondary,
    letterSpacing: 2,
  );

  static const TextStyle heroSubtitleMobile = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w300,
    color: AppColors.secondary,
    letterSpacing: 1,
  );

  static const TextStyle sectionTitle = TextStyle(
    fontSize: 48,
    fontWeight: FontWeight.bold,
    color: AppColors.primary,
  );

  static const TextStyle sectionTitleMobile = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.primary,
  );

  static const TextStyle cardTitle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.primary,
  );

  static const TextStyle cardDescription = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.secondary,
    height: 1.6,
  );

  static const TextStyle body = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.secondary,
    height: 1.8,
  );
}

class AppConstants {
  static const double maxWidth = 1200;
  static const double horizontalPadding = 80;
  static const double horizontalPaddingMobile = 24;
  static const double sectionSpacing = 120;
  static const double sectionSpacingMobile = 80;
}

