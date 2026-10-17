import 'package:flutter/material.dart';

import '../../../core/utils/formatters.dart';
import '../../../core/utils/validators.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_snack.dart';
import '../../../core/widgets/big_button.dart';
import '../../../core/widgets/confirm_dialog.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/field_decoration.dart';
import '../../../domain/entities/request_type.dart';
import '../../state/app_controller.dart';
import 'widgets/request_tracker.dart';
import 'widgets/request_type_option.dart';

class RequestsScreen extends StatefulWidget {
  const RequestsScreen({super.key, required this.controller});
  final AppController controller;

  @override
  State<RequestsScreen> createState() => _RequestsScreenState();
}

class _RequestsScreenState extends State<RequestsScreen> {
  final _formKey = GlobalKey<FormState>();
  late final _address =
      TextEditingController(text: widget.controller.profile?.address ?? '');
  final _notes = TextEditingController();
  RequestType _type = RequestType.pipa;
  bool _sending = false;

  @override
  void dispose() {
    _address.dispose();
    _notes.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    final ok = await showConfirmDialog(
      context,
      title: '¿Enviar solicitud?',
      message: '${_type.label}\n${_address.text.trim()}',
      confirmLabel: 'Sí, enviar',
      cancelLabel: 'Revisar',
    );
    if (!ok || !mounted) return;
    setState(() => _sending = true);
    await widget.controller.sendRequest(
        type: _type, address: _address.text.trim(), notes: _notes.text.trim());
    if (!mounted) return;
    setState(() => _sending = false);
    _notes.clear();
    showAppSnack(context, 'Solicitud enviada. Aquí podrá ver su avance.');
  }

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    final latest = widget.controller.latestRequest;
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(20),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        children: [
          Text('Solicitudes', style: t.headlineSmall),
          const SizedBox(height: 20),
          Text('¿Cómo va su solicitud?', style: t.titleMedium),
          const SizedBox(height: 12),
          if (latest == null)
            const EmptyState(
              icon: Icons.description_outlined,
              title: 'Aún no tiene solicitudes',
              message: 'Cuando envíe una, aquí verá cómo va.',
            )
          else
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${latest.type.label} · ${latest.id}',
                      style: t.bodyLarge
                          ?.copyWith(fontWeight: FontWeight.w700)),
                  Text('Enviada el ${formatDate(latest.createdAt)}',
                      style: t.bodyMedium),
                  const Divider(height: 28),
                  RequestTracker(current: latest.stage),
                ],
              ),
            ),
          const SizedBox(height: 28),
          Text('Hacer una nueva solicitud', style: t.titleMedium),
          const SizedBox(height: 12),
          Row(
            children: [
              for (final type in RequestType.values) ...[
                Expanded(
                  child: RequestTypeOption(
                    type: type,
                    selected: type == _type,
                    onTap: () => setState(() => _type = type),
                  ),
                ),
                if (type != RequestType.values.last) const SizedBox(width: 12),
              ]
            ],
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _address,
            style: t.bodyLarge,
            textInputAction: TextInputAction.next,
            textCapitalization: TextCapitalization.words,
            decoration:
                fieldDecoration('Dirección', hint: 'Calle, número y colonia'),
            validator: validateAddress,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _notes,
            style: t.bodyLarge,
            maxLines: 3,
            textCapitalization: TextCapitalization.sentences,
            decoration: fieldDecoration('Notas (opcional)',
                hint: 'Ej. Casa de portón azul'),
          ),
          const SizedBox(height: 24),
          BigButton(
              label: _sending ? 'Enviando…' : 'Enviar solicitud',
              icon: Icons.send,
              onPressed: _sending ? () {} : _submit),
        ],
      ),
    );
  }
}
