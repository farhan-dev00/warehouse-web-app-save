import 'package:flutter/material.dart';

/// Centralized color palette for the whole app.
/// Change values here to re-theme the entire portal.
class AppColors {
  AppColors._();

  static const Color primary = Color(0xFF2F5DFF);
  static const Color primaryDark = Color(0xFF1E3FCB);
  static const Color primaryLight = Color(0xFFE8EDFF);

  static const Color secondary = Color(0xFF00C2A8);

  /// Brand accent — used for input field backgrounds, highlights, etc.
  static const Color accent = Color(0xFFFDB553);
  /// accent, blended 50% toward white — softer background use.
  static const Color accentLight = Color(0xFFFEDAA9);
  /// Text color used on top of the accent button background.
  static const Color accentText = Color(0xFF896C45);

  static const Color background = Color(0xFFF5F7FB);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color sidebarBackground = Color(0xFF6670B6);
  static const Color sidebarSelected = Color(0xFF24318F);

  static const Color textPrimary = Color(0xFF1B1F3B);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textOnDark = Color(0xFFFFFFFF);

  static const Color success = Color(0xFF22C55E);
  static const Color warning = Color(0xFFF59E0B);
  static const Color danger = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);

  static const Color border = Color(0xFFE5E7EB);
  static const Color shadow = Color(0x1A000000);

  /// Chart palette used across dashboard/reports.
  static const List<Color> chartPalette = [
    primary,
    secondary,
    warning,
    danger,
    Color(0xFF8B5CF6),
  ];
}
