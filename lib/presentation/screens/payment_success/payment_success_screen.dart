import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_snack.dart';
import '../../../core/widgets/big_button.dart';
import '../../../domain/entities/payment.dart';
import 'widgets/receipt_row.dart';

class PaymentSuccessScreen extends StatelessWidget {
  const PaymentSuccessScreen({super.key, required this.payment});
  final Payment payment;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const SizedBox(height: 24),
            const Icon(Icons.check_circle, size: 96, color: AppColors.success),
            const SizedBox(height: 16),
            Text('¡Pago realizado!',
                textAlign: TextAlign.center, style: t.headlineSmall),
            const SizedBox(height: 8),
            Text('Su pago se recibió correctamente.',
                textAlign: TextAlign.center, style: t.bodyLarge),
            const SizedBox(height: 28),
            AppCard(
              child: Column(children: [
                ReceiptRow('Folio', payment.folio),
                const Divider(height: 28),
                ReceiptRow('Fecha', formatDate(payment.date)),
                const Divider(height: 28),
                ReceiptRow('Total pagado', formatMoney(payment.total),
                    big: true),
              ]),
            ),
            const SizedBox(height: 12),
            Text('Guarde su folio por si necesita una aclaración.',
                textAlign: TextAlign.center, style: t.bodyMedium),
            const SizedBox(height: 24),
            BigButton(
                label: 'Descargar comprobante',
                icon: Icons.download,
                outlined: true,
                onPressed: () => showAppSnack(context, 'Comprobante guardado')),
            const SizedBox(height: 12),
            BigButton(
                label: 'Compartir',
                icon: Icons.share_outlined,
                outlined: true,
                onPressed: () =>
                    showAppSnack(context, 'Compartiendo comprobante…')),
            const SizedBox(height: 12),
            BigButton(
                label: 'Volver al inicio',
                icon: Icons.home,
                onPressed: () =>
                    Navigator.of(context).popUntil((r) => r.isFirst)),
          ],
        ),
      ),
    );
  }
}
