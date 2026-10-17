import 'package:flutter/material.dart';

import '../../../core/widgets/empty_state.dart';
import '../../state/app_controller.dart';
import 'widgets/activity_tile.dart';
import 'widgets/balance_card.dart';
import 'widgets/home_header.dart';
import 'widgets/shortcut_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    required this.controller,
    required this.onNavigate,
    required this.onPay,
  });
  final AppController controller;
  final ValueChanged<int> onNavigate;
  final VoidCallback onPay;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    final profile = controller.profile!;
    final recent = controller.activities.take(5).toList();
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        HomeHeader(name: profile.name, contract: profile.contract),
        const SizedBox(height: 16),
        BalanceCard(balance: controller.balance, onPay: onPay),
        const SizedBox(height: 28),
        Text('¿Qué desea hacer?', style: t.titleMedium),
        const SizedBox(height: 12),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 1.15,
          children: [
            ShortcutCard(Icons.credit_card, 'Pagar servicio', onPay),
            ShortcutCard(Icons.description_outlined, 'Solicitar toma',
                () => onNavigate(2)),
            ShortcutCard(Icons.warning_amber_rounded, 'Reportar fuga',
                () => onNavigate(3)),
            ShortcutCard(Icons.show_chart, 'Ver consumo', () => onNavigate(1)),
          ],
        ),
        const SizedBox(height: 28),
        Text('Últimos movimientos', style: t.titleMedium),
        const SizedBox(height: 12),
        if (recent.isEmpty)
          const EmptyState(
            icon: Icons.inbox_outlined,
            title: 'Aún no hay movimientos',
            message: 'Aquí aparecerán sus pagos y solicitudes.',
          )
        else
          for (final a in recent) ...[
            ActivityTile(activity: a),
            const SizedBox(height: 10),
          ],
      ],
    );
  }
}
