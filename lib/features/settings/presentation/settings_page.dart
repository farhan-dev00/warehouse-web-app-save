import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../shared/widgets/app_card.dart';
import '../../../shared/widgets/section_title.dart';
import 'widgets/company_tab.dart';
import 'widgets/notification_tab.dart';
import 'widgets/profile_tab.dart';
import 'widgets/security_tab.dart';

/// Settings page with 4 tabs: Profile / Company / Notification / Security.
class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSizes.spaceLg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(title: 'Settings', subtitle: 'Manage your account and workspace'),
          const SizedBox(height: AppSizes.spaceLg),
          AppCard(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                TabBar(
                  controller: _tabController,
                  labelColor: AppColors.primary,
                  unselectedLabelColor: AppColors.textSecondary,
                  indicatorColor: AppColors.primary,
                  tabs: const [
                    Tab(text: 'Profile'),
                    Tab(text: 'Company'),
                    Tab(text: 'Notification'),
                    Tab(text: 'Security'),
                  ],
                ),
                const Divider(height: 1),
                Padding(
                  padding: const EdgeInsets.all(AppSizes.spaceLg),
                  child: SizedBox(
                    height: 460,
                    child: TabBarView(
                      controller: _tabController,
                      children: const [
                        SingleChildScrollView(child: ProfileTab()),
                        SingleChildScrollView(child: CompanyTab()),
                        SingleChildScrollView(child: NotificationTab()),
                        SingleChildScrollView(child: SecurityTab()),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
