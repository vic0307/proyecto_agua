import 'package:flutter/material.dart';

import '../../core/utils/formatters.dart';
import '../../core/widgets/app_snack.dart';
import '../../core/widgets/confirm_dialog.dart';
import '../screens/home/home_screen.dart';
import '../screens/payment_success/payment_success_screen.dart';
import '../screens/placeholder_screen.dart';
import '../screens/profile/profile_screen.dart';
import '../screens/requests/requests_screen.dart';
import '../state/app_controller.dart';

/// Contenedor con barra de navegación inferior.
class MainShell extends StatefulWidget {
  const MainShell({super.key, required this.controller});
  final AppController controller;

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _index = 0;

  void _goTo(int i) => setState(() => _index = i);

  Future<void> _pay() async {
    final c = widget.controller;
    if (c.balance <= 0) {
      showAppSnack(context, 'No tiene pagos pendientes.');
      return;
    }
    final ok = await showConfirmDialog(
      context,
      title: '¿Desea pagar ahora?',
      message: 'Se pagará ${formatMoney(c.balance)} de su recibo.',
      confirmLabel: 'Sí, pagar',
    );
    if (!ok || !mounted) return;
    final payment = await c.pay();
    if (!mounted) return;
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => PaymentSuccessScreen(payment: payment),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.controller,
      builder: (context, _) {
        final pages = [
          HomeScreen(
              controller: widget.controller, onNavigate: _goTo, onPay: _pay),
          const PlaceholderScreen(title: 'Pagos'),
          RequestsScreen(controller: widget.controller),
          const PlaceholderScreen(title: 'Reportes'),
          ProfileScreen(controller: widget.controller),
        ];
        return Scaffold(
          body: SafeArea(child: IndexedStack(index: _index, children: pages)),
          bottomNavigationBar: NavigationBar(
            selectedIndex: _index,
            onDestinationSelected: _goTo,
            destinations: const [
              NavigationDestination(
                  icon: Icon(Icons.home_outlined, size: 28),
                  selectedIcon: Icon(Icons.home, size: 28),
                  label: 'Inicio'),
              NavigationDestination(
                  icon: Icon(Icons.payments_outlined, size: 28),
                  selectedIcon: Icon(Icons.payments, size: 28),
                  label: 'Pagos'),
              NavigationDestination(
                  icon: Icon(Icons.description_outlined, size: 28),
                  selectedIcon: Icon(Icons.description, size: 28),
                  label: 'Solicitudes'),
              NavigationDestination(
                  icon: Icon(Icons.warning_amber_rounded, size: 28),
                  selectedIcon: Icon(Icons.warning_rounded, size: 28),
                  label: 'Reportes'),
              NavigationDestination(
                  icon: Icon(Icons.person_outline, size: 28),
                  selectedIcon: Icon(Icons.person, size: 28),
                  label: 'Perfil'),
            ],
          ),
        );
      },
    );
  }
}
