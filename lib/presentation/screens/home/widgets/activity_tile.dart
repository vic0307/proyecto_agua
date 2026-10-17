import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../domain/entities/activity.dart';

/// Fila de movimiento reciente.
class ActivityTile extends StatelessWidget {
  const ActivityTile({super.key, required this.activity});
  final Activity activity;

  IconData get _icon => switch (activity.type) {
        ActivityType.payment => Icons.check_circle_outline,
        ActivityType.request => Icons.description_outlined,
      };

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return AppCard(
      child: Row(children: [
        Icon(_icon, size: 28, color: AppColors.primary),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(activity.title, style: t.bodyLarge),
              Text(formatDate(activity.date), style: t.bodyMedium),
            ],
          ),
        ),
      ]),
    );
  }
}
