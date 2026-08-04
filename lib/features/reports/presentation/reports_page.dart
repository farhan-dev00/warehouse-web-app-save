import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/utils/responsive.dart';
import '../../../shared/dialogs/action_dialog.dart';
import '../../../shared/widgets/app_card.dart';
import '../../../shared/widgets/section_title.dart';
import '../../../shared/widgets/summary_card.dart';

/// Reports page: headline stats + a bar chart (headcount by dept) and a
/// pie chart (payroll distribution), plus a "Download Report" action.
class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final columns = Responsive.gridColumns(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSizes.spaceLg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionTitle(
            title: 'Reports',
            subtitle: 'Company-wide statistics · August 2026',
            trailing: ElevatedButton.icon(
              onPressed: () => showActionDialog(context, action: 'Download Report'),
              icon: const Icon(Icons.download_outlined, size: 18),
              label: const Text('Download Report'),
            ),
          ),
          const SizedBox(height: AppSizes.spaceLg),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: columns,
            mainAxisSpacing: AppSizes.spaceMd,
            crossAxisSpacing: AppSizes.spaceMd,
            childAspectRatio: 1.6,
            children: const [
              SummaryCard(label: 'Headcount Growth', value: '+8.4%', icon: Icons.trending_up, color: AppColors.success, trend: '8.4%'),
              SummaryCard(label: 'Turnover Rate', value: '3.1%', icon: Icons.trending_down, color: AppColors.danger, trend: '0.6%', trendIsPositive: false),
              SummaryCard(label: 'Avg. Attendance', value: '96.2%', icon: Icons.fact_check_outlined, color: AppColors.primary, trend: '1.2%'),
              SummaryCard(label: 'Payroll Cost', value: 'RM 412K', icon: Icons.account_balance_wallet_outlined, color: AppColors.secondary, trend: '2.9%'),
            ],
          ),
          const SizedBox(height: AppSizes.spaceLg),
          isDesktop
              ? IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(flex: 3, child: _headcountBarChart()),
                      const SizedBox(width: AppSizes.spaceLg),
                      Expanded(flex: 2, child: _payrollPieChart()),
                    ],
                  ),
                )
              : Column(
                  children: [
                    _headcountBarChart(),
                    const SizedBox(height: AppSizes.spaceLg),
                    _payrollPieChart(),
                  ],
                ),
        ],
      ),
    );
  }

  Widget _headcountBarChart() {
    const depts = ['Eng', 'Mktg', 'Sales', 'HR', 'Fin', 'Ops'];
    const values = [42.0, 18.0, 26.0, 9.0, 12.0, 21.0];

    return AppCard(
      child: SizedBox(
        height: 320,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Headcount by Department', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
            const SizedBox(height: AppSizes.spaceLg),
            Expanded(
              child: BarChart(
                BarChartData(
                  gridData: const FlGridData(show: false),
                  borderData: FlBorderData(show: false),
                  titlesData: FlTitlesData(
                    leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) => Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(depts[value.toInt() % depts.length],
                              style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                        ),
                      ),
                    ),
                  ),
                  barGroups: List.generate(
                    values.length,
                    (i) => BarChartGroupData(x: i, barRods: [
                      BarChartRodData(
                        toY: values[i],
                        color: AppColors.chartPalette[i % AppColors.chartPalette.length],
                        width: 22,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ]),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _payrollPieChart() {
    final data = {
      'Engineering': 38.0,
      'Sales': 22.0,
      'Marketing': 14.0,
      'Operations': 16.0,
      'Others': 10.0,
    };

    return AppCard(
      child: SizedBox(
        height: 320,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Payroll Distribution', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
            const SizedBox(height: AppSizes.spaceLg),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: PieChart(
                      PieChartData(
                        sectionsSpace: 2,
                        centerSpaceRadius: 36,
                        sections: List.generate(data.length, (i) {
                          final entry = data.entries.elementAt(i);
                          return PieChartSectionData(
                            value: entry.value,
                            color: AppColors.chartPalette[i % AppColors.chartPalette.length],
                            title: '${entry.value.toInt()}%',
                            radius: 46,
                            titleStyle: const TextStyle(
                                fontSize: 11, fontWeight: FontWeight.w700, color: Colors.white),
                          );
                        }),
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSizes.spaceMd),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(data.length, (i) {
                      final entry = data.entries.elementAt(i);
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 3),
                        child: Row(
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: AppColors.chartPalette[i % AppColors.chartPalette.length],
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(entry.key, style: const TextStyle(fontSize: 11)),
                          ],
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
