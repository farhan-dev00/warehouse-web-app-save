import 'package:flutter/material.dart';
import '../constants/app_sizes.dart';

/// Simple responsive breakpoint helper used across the app.
/// Widgets call `Responsive.isMobile(context)` etc. instead of
/// hard-coding MediaQuery checks everywhere.
class Responsive {
  Responsive._();

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < AppSizes.breakpointMobile;

  static bool isTablet(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return w >= AppSizes.breakpointMobile && w < AppSizes.breakpointTablet;
  }

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= AppSizes.breakpointTablet;

  /// Returns how many columns a responsive grid should use.
  static int gridColumns(BuildContext context) {
    if (isMobile(context)) return 1;
    if (isTablet(context)) return 2;
    return 4;
  }
}
