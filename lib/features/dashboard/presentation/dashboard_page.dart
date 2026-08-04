import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/utils/responsive.dart';
import '../../../shared/widgets/app_card.dart';
import '../../../shared/widgets/section_title.dart';
import '../../../shared/widgets/summary_card.dart';
import 'widgets/dashboard_chart.dart';
import 'widgets/quick_actions.dart';
import 'widgets/recent_activities_table.dart';
import 'widgets/upcoming_events_list.dart';

/// The main Dashboard: summary cards, headcount chart, recent activities,
/// upcoming events, and quick actions. Fully responsive.
class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final columns = Responsive.gridColumns(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSizes.spaceLg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(title: 'Welcome back, Admin', subtitle: "Here's what's happening today."),
          const SizedBox(height: AppSizes.spaceLg),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: columns,
            mainAxisSpacing: AppSizes.spaceMd,
            crossAxisSpacing: AppSizes.spaceMd,
            childAspectRatio: 1.6,
            children: const [
              SummaryCard(
                label: 'Total Employees',
                value: '128',
                icon: Icons.groups_outlined,
                color: AppColors.primary,
                trend: '4.2%',
              ),
              SummaryCard(
                label: 'Active Employees',
                value: '119',
                icon: Icons.check_circle_outline,
                color: AppColors.success,
                trend: '2.1%',
              ),
              SummaryCard(
                label: 'Pending Leave',
                value: '7',
                icon: Icons.event_busy_outlined,
                color: AppColors.warning,
                trend: '1.3%',
                trendIsPositive: false,
              ),
              SummaryCard(
                label: 'Monthly Payroll',
                value: 'RM 412K',
                icon: Icons.account_balance_wallet_outlined,
                color: AppColors.secondary,
                trend: '2.9%',
              ),
            ],
          ),
          const SizedBox(height: AppSizes.spaceLg),
          isDesktop
              ? IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(flex: 3, child: _chartCard()),
                      const SizedBox(width: AppSizes.spaceLg),
                      Expanded(flex: 2, child: _eventsCard()),
                    ],
                  ),
                )
              : Column(
                  children: [
                    _chartCard(),
                    const SizedBox(height: AppSizes.spaceLg),
                    _eventsCard(),
                  ],
                ),
          const SizedBox(height: AppSizes.spaceLg),
          isDesktop
              ? IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(flex: 3, child: _activitiesCard()),
                      const SizedBox(width: AppSizes.spaceLg),
                      Expanded(flex: 2, child: _quickActionsCard()),
                    ],
                  ),
                )
              : Column(
                  children: [
                    _activitiesCard(),
                    const SizedBox(height: AppSizes.spaceLg),
                    _quickActionsCard(),
                  ],
                ),
        ],
      ),
    );
  }

  Widget _chartCard() {
    return AppCard(
      child: SizedBox(
        height: 320,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Headcount Trend', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
            const SizedBox(height: AppSizes.spaceLg),
            const Expanded(child: DashboardChart()),
          ],
        ),
      ),
    );
  }

  Widget _eventsCard() {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('Upcoming Events', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
          SizedBox(height: AppSizes.spaceMd),
          UpcomingEventsList(),
        ],
      ),
    );
  }

  Widget _activitiesCard() {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('Recent Activities', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
          SizedBox(height: AppSizes.spaceMd),
          RecentActivitiesTable(),
        ],
      ),
    );
  }

  Widget _quickActionsCard() {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('Quick Actions', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
          SizedBox(height: AppSizes.spaceMd),
          QuickActions(),
        ],
      ),
    );
  }
}
