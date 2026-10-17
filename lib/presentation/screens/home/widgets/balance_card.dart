import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/big_button.dart';

/// Total a pagar o aviso de "al corriente".
class BalanceCard extends StatelessWidget {
  const BalanceCard({super.key, required this.balance, required this.onPay});
  final double balance;
  final VoidCallback onPay;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    if (balance <= 0) {
      return AppCard(
        child: Row(children: [
          const Icon(Icons.check_circle, size: 40, color: AppColors.success),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Está al corriente', style: t.titleMedium),
                Text('No tiene pagos pendientes.', style: t.bodyMedium),
              ],
            ),
          ),
        ]),
      );
    }
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Total a pagar', style: t.bodyMedium),
          const SizedBox(height: 6),
          Text(formatMoney(balance),
              style: const TextStyle(
                  fontSize: 38,
                  fontWeight: FontWeight.w800,
                  color: AppColors.primary)),
          const SizedBox(height: 16),
          BigButton(
              label: 'Pagar ahora', icon: Icons.credit_card, onPressed: onPay),
        ],
      ),
    );
  }
}
