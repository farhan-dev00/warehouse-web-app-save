import 'package:flutter/material.dart';

/// Small quality-of-life extensions on BuildContext used across the app.
extension ContextExtensions on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  Size get screenSize => MediaQuery.of(this).size;
}
