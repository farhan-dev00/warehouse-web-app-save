import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';
import '../models/notification_model.dart';

/// Top app bar shown above the page content.
/// Contains: (optional) menu button for mobile drawer, page title,
/// notification bell with popup, and a user menu with logout.
class AppTopBar extends StatelessWidget {
  final String title;
  final VoidCallback? onMenuTap;
  final VoidCallback onLogout;

  const AppTopBar({
    super.key,
    required this.title,
    this.onMenuTap,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSizes.topBarHeight,
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.spaceLg),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        children: [
          if (onMenuTap != null)
            IconButton(icon: const Icon(Icons.menu), onPressed: onMenuTap),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          _NotificationButton(),
          const SizedBox(width: AppSizes.spaceMd),
          _UserMenu(onLogout: onLogout),
        ],
      ),
    );
  }
}

class _NotificationButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final notifications = AppNotification.dummyList();
    return PopupMenuButton<void>(
      tooltip: 'Notifications',
      offset: const Offset(0, 44),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizes.radiusMd)),
      itemBuilder: (ctx) => [
        PopupMenuItem<void>(
          enabled: false,
          child: SizedBox(
            width: 320,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: Text('Notifications', style: TextStyle(fontWeight: FontWeight.w700)),
                ),
                ...notifications.map((n) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(_iconFor(n.type), size: 18, color: AppColors.primary),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(n.title,
                                    style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                                Text(n.subtitle,
                                    style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                                Text(n.timeAgo,
                                    style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          ),
        ),
      ],
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(AppSizes.radiusSm),
            ),
            child: const Icon(Icons.notifications_none_rounded, size: 22),
          ),
          Positioned(
            right: 4,
            top: 4,
            child: Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(color: AppColors.danger, shape: BoxShape.circle),
            ),
          ),
        ],
      ),
    );
  }

  IconData _iconFor(NotificationType type) {
    switch (type) {
      case NotificationType.leave:
        return Icons.event_busy;
      case NotificationType.payroll:
        return Icons.payments;
      case NotificationType.employee:
        return Icons.person_add_alt;
      case NotificationType.attendance:
        return Icons.fact_check;
    }
  }
}

class _UserMenu extends StatelessWidget {
  final VoidCallback onLogout;
  const _UserMenu({required this.onLogout});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      tooltip: 'Account',
      offset: const Offset(0, 44),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizes.radiusMd)),
      onSelected: (value) {
        if (value == 'logout') onLogout();
      },
      itemBuilder: (ctx) => const [
        PopupMenuItem(value: 'profile', child: Text('My Profile')),
        PopupMenuItem(value: 'settings', child: Text('Settings')),
        PopupMenuDivider(),
        PopupMenuItem(value: 'logout', child: Text('Logout')),
      ],
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircleAvatar(
            radius: 18,
            backgroundColor: AppColors.primaryLight,
            child: Text('A', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w700)),
          ),
          const SizedBox(width: 8),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Admin User', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
              Text('Administrator', style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
            ],
          ),
          const Icon(Icons.keyboard_arrow_down, size: 18),
        ],
      ),
    );
  }
}
