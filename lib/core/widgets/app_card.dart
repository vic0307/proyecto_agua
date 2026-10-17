import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Tarjeta blanca con borde fino; tocable si recibe [onTap].
class AppCard extends StatelessWidget {
  const AppCard({super.key, required this.child, this.onTap});
  final Widget child;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => Material(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: const BorderSide(color: AppColors.border),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onTap,
          child: Padding(padding: const EdgeInsets.all(18), child: child),
        ),
      );
}
