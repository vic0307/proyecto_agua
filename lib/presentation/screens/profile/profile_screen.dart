import 'package:flutter/material.dart';

import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/big_button.dart';
import '../../../core/widgets/confirm_dialog.dart';
import '../../state/app_controller.dart';
import 'widgets/info_row.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key, required this.controller});
  final AppController controller;

  Future<void> _signOut(BuildContext context) async {
    final ok = await showConfirmDialog(
      context,
      title: '¿Cerrar sesión?',
      message: 'Se borrarán los datos capturados en este dispositivo.',
      confirmLabel: 'Sí, cerrar sesión',
    );
    if (ok) await controller.signOut();
  }

  @override
  Widget build(BuildContext context) {
    final p = controller.profile!;
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text('Mi perfil', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 20),
        AppCard(
          child: Column(children: [
            InfoRow('Nombre', p.name),
            const Divider(height: 28),
            InfoRow('Contrato', p.contract),
            const Divider(height: 28),
            InfoRow('Dirección', p.address),
            const Divider(height: 28),
            InfoRow('Teléfono', p.phone),
          ]),
        ),
        const SizedBox(height: 24),
        BigButton(
          label: 'Cerrar sesión',
          icon: Icons.logout,
          outlined: true,
          onPressed: () => _signOut(context),
        ),
      ],
    );
  }
}
