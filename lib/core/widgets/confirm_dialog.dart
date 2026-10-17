import 'package:flutter/material.dart';

import 'big_button.dart';

/// Diálogo de confirmación con botones grandes. Devuelve true si acepta.
Future<bool> showConfirmDialog(
  BuildContext context, {
  required String title,
  required String message,
  String confirmLabel = 'Aceptar',
  String cancelLabel = 'Cancelar',
}) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text(title,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
      content: Text(message, style: const TextStyle(fontSize: 18)),
      actions: [
        SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              BigButton(
                  label: confirmLabel,
                  onPressed: () => Navigator.pop(ctx, true)),
              const SizedBox(height: 8),
              BigButton(
                  label: cancelLabel,
                  outlined: true,
                  onPressed: () => Navigator.pop(ctx, false)),
            ],
          ),
        ),
      ],
    ),
  );
  return result == true;
}
