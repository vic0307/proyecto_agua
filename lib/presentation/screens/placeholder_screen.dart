import 'package:flutter/material.dart';

import '../../core/widgets/empty_state.dart';

/// Pantalla temporal para secciones aún no implementadas.
class PlaceholderScreen extends StatelessWidget {
  const PlaceholderScreen({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) => ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(title, style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 20),
          const EmptyState(
            icon: Icons.construction_outlined,
            title: 'Sección en preparación',
            message: 'Estará disponible próximamente.',
          ),
        ],
      );
}
