import 'package:flutter/material.dart';
import 'package:warehouse_web_app/core/constants/app_images.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/constants/app_strings.dart';
import '../models/nav_item.dart';

/// Sidebar navigation menu.
///
/// Supports flat items (Dashboard) and expandable groups (Access Control ->
/// Employees / Departments / ...). Highlights whichever route matches
/// [currentRoute]. Used both as a fixed sidebar (desktop) and inside a
/// Drawer (mobile) — see AppScaffold.
class AppSidebar extends StatelessWidget {
  final String currentRoute;
  final ValueChanged<String> onNavigate;

  const AppSidebar({super.key, required this.currentRoute, required this.onNavigate});

  static final List<NavItem> navItems = [
    const NavItem(label: 'Dashboard', icon: Icons.dashboard_outlined, route: '/dashboard'),
    const NavItem(
      label: 'Access Control',
      icon: Icons.groups_outlined,
      children: [
        NavItem(label: 'User Management', icon: Icons.badge_outlined, route: '/user_management'),
        NavItem(label: 'Role Management', icon: Icons.apartment_outlined, route: '/role_management'),
        NavItem(label: 'Permission Management', icon: Icons.fact_check_outlined, route: '/permission_management'),
      ],
    ),
    const NavItem(
      label: 'Transactions',
      icon: Icons.compare_arrows,
      children: [
        NavItem(label: 'Good Receive', icon: Icons.diamond, route: '/good_receive'),
        NavItem(label: 'Transfer & Putaway', icon: Icons.warehouse, route: '/transfer_putaway'),
        NavItem(label: 'Pick & Pack', icon: Icons.trolley, route: '/pick_pack'),
        NavItem(label: 'Outgoing', icon: Icons.local_shipping, route: '/outgoing'),
      ],
    ),
    const NavItem(label: 'Settings', icon: Icons.settings_outlined, route: '/settings'),
  ];

  bool _groupContainsCurrent(NavItem item) =>
      item.children.any((c) => c.route == currentRoute);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSizes.sidebarWidth,
      color: AppColors.sidebarBackground,
      child: Column(
        children: [
          _buildHeader(),
          const Divider(color: Colors.white12, height: 1),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: AppSizes.spaceSm),
              children: navItems.map(_buildNavEntry).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: AppSizes.topBarHeight,
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.spaceMd),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            clipBehavior: Clip.antiAlias, // clips the image to the rounded box
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(AppSizes.radiusSm),
            ),
            child: Image.asset(
              AppImages.dashboardLogo,
              fit: BoxFit.cover, // fills the 36x36 box, no fixed width needed
              errorBuilder: (context, error, stackTrace) => const Icon(
                Icons.hive_rounded,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
          const SizedBox(width: AppSizes.spaceSm),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                AppStrings.appName,
                style: TextStyle(
                  color: AppColors.textOnDark,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
              Text(
                AppStrings.appTagline,
                style: TextStyle(color: Colors.white54, fontSize: 11),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNavEntry(NavItem item) {
    if (item.isGroup) {
      return Theme(
        data: ThemeData(dividerColor: Colors.transparent),
        child: ExpansionTile(
          initiallyExpanded: _groupContainsCurrent(item),
          leading: Icon(item.icon, color: Colors.white70, size: 20),
          title: Text(
            item.label,
            style: const TextStyle(color: AppColors.textOnDark, fontSize: 14),
          ),
          iconColor: Colors.white70,
          collapsedIconColor: Colors.white70,
          childrenPadding: EdgeInsets.zero,
          children: item.children.map(_buildChildTile).toList(),
        ),
      );
    }
    return _buildTile(item.icon, item.label, item.route!);
  }

  Widget _buildChildTile(NavItem item) {
    final selected = item.route == currentRoute;
    return Padding(
      padding: const EdgeInsets.only(left: AppSizes.spaceLg),
      child: _buildTile(item.icon, item.label, item.route!, dense: true, selected: selected),
    );
  }

  Widget _buildTile(IconData icon, String label, String route,
      {bool dense = false, bool? selected}) {
    final isSelected = selected ?? (route == currentRoute);
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => onNavigate(route),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: AppSizes.spaceSm, vertical: 2),
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.spaceMd,
            vertical: dense ? 10 : 12,
          ),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.sidebarSelected : Colors.transparent,
            borderRadius: BorderRadius.circular(AppSizes.radiusSm),
          ),
          child: Row(
            children: [
              Icon(icon, size: 20, color: isSelected ? Colors.white : Colors.white70),
              const SizedBox(width: AppSizes.spaceSm),
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? Colors.white : AppColors.textOnDark,
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
