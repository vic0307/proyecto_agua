import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import 'app_card.dart';

/// Mensaje cuando aún no hay información.
class EmptyState extends StatelessWidget {
  const EmptyState(
      {super.key,
      required this.icon,
      required this.title,
      required this.message});
  final IconData icon;
  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return AppCard(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Icon(icon, size: 40, color: AppColors.muted),
            const SizedBox(height: 10),
            Text(title, textAlign: TextAlign.center, style: t.titleMedium),
            const SizedBox(height: 6),
            Text(message, textAlign: TextAlign.center, style: t.bodyMedium),
          ],
        ),
      ),
    );
  }
}
