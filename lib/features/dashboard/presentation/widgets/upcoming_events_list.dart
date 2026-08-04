import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class _Event {
  final String title;
  final String date;
  final IconData icon;
  const _Event(this.title, this.date, this.icon);
}

/// "Upcoming Events" list on the dashboard (holidays, meetings, reviews).
class UpcomingEventsList extends StatelessWidget {
  const UpcomingEventsList({super.key});

  static const _events = [
    _Event('National Day Holiday', 'Aug 31, 2026', Icons.flag_outlined),
    _Event('Quarterly Performance Review', 'Sep 5, 2026', Icons.assessment_outlined),
    _Event('New Hire Orientation', 'Sep 8, 2026', Icons.group_add_outlined),
    _Event('Company Town Hall', 'Sep 15, 2026', Icons.campaign_outlined),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _events
          .map((e) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.primaryLight,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(e.icon, size: 16, color: AppColors.primary),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(e.title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                    ),
                    Text(e.date, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                  ],
                ),
              ))
          .toList(),
    );
  }
}
