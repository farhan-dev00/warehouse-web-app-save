import 'package:flutter/material.dart';

/// Represents a single entry in the sidebar navigation.
/// If [children] is not empty, the item renders as an expandable group.
class NavItem {
  final String label;
  final IconData icon;
  final String? route;
  final List<NavItem> children;

  const NavItem({
    required this.label,
    required this.icon,
    this.route,
    this.children = const [],
  });

  bool get isGroup => children.isNotEmpty;
}
