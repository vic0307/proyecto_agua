import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

/// Fila etiqueta–valor del comprobante.
class ReceiptRow extends StatelessWidget {
  const ReceiptRow(this.label, this.value, {super.key, this.big = false});
  final String label;
  final String value;
  final bool big;

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Expanded(
              child: Text(label, style: Theme.of(context).textTheme.bodyMedium)),
          Flexible(
            child: Text(value,
                textAlign: TextAlign.end,
                style: TextStyle(
                    fontSize: big ? 28 : 18,
                    fontWeight: FontWeight.w800,
                    color: big ? AppColors.primary : AppColors.text)),
          ),
        ],
      );
}
