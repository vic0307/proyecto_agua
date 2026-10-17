import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

/// Encabezado con nombre y contrato.
class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key, required this.name, required this.contract});
  final String name;
  final String contract;

  @override
  Widget build(BuildContext context) => Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: AppColors.primary, borderRadius: BorderRadius.circular(14)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Bienvenido(a)',
                style: TextStyle(fontSize: 16, color: Colors.white70)),
            const SizedBox(height: 4),
            Text(name,
                style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                    color: Colors.white)),
            const SizedBox(height: 8),
            Text('Contrato: $contract',
                style: const TextStyle(fontSize: 16, color: Colors.white70)),
          ],
        ),
      );
}
