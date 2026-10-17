import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/validators.dart';
import '../../../core/widgets/big_button.dart';
import '../../../core/widgets/field_decoration.dart';
import '../../../domain/entities/user_profile.dart';
import '../../state/app_controller.dart';

/// Primer paso: el usuario captura sus datos.
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key, required this.controller});
  final AppController controller;

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _contract = TextEditingController();
  final _address = TextEditingController();
  final _phone = TextEditingController();
  final _amount = TextEditingController();
  bool _saving = false;

  @override
  void dispose() {
    for (final c in [_name, _contract, _address, _phone, _amount]) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    await widget.controller.register(
      UserProfile(
        name: _name.text.trim(),
        contract: _contract.text.trim().toUpperCase(),
        address: _address.text.trim(),
        phone: _phone.text,
      ),
      double.parse(_amount.text.replaceAll(',', '')),
    );
    // Al registrarse, la raíz cambia a la app y esta pantalla se cierra.
  }

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(20),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            children: [
              const SizedBox(height: 8),
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(16)),
                child: const Icon(Icons.water_drop,
                    color: Colors.white, size: 36),
              ),
              const SizedBox(height: 20),
              Text('Bienvenido(a)', style: t.headlineSmall),
              const SizedBox(height: 6),
              Text('Para comenzar, escriba sus datos. Los encontrará en su recibo de agua.',
                  style: t.bodyMedium),
              const SizedBox(height: 24),
              TextFormField(
                controller: _name,
                style: t.bodyLarge,
                textInputAction: TextInputAction.next,
                textCapitalization: TextCapitalization.words,
                decoration: fieldDecoration('Nombre o familia',
                    hint: 'Ej. Familia Pérez'),
                validator: validateName,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _contract,
                style: t.bodyLarge,
                textInputAction: TextInputAction.next,
                textCapitalization: TextCapitalization.characters,
                decoration: fieldDecoration('Número de contrato'),
                validator: validateContract,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _address,
                style: t.bodyLarge,
                textInputAction: TextInputAction.next,
                textCapitalization: TextCapitalization.words,
                decoration: fieldDecoration('Dirección',
                    hint: 'Calle, número y colonia'),
                validator: validateAddress,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _phone,
                style: t.bodyLarge,
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.next,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10),
                ],
                decoration: fieldDecoration('Teléfono', hint: '10 números'),
                validator: validatePhone,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _amount,
                style: t.bodyLarge,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                ],
                decoration: fieldDecoration('Total de su recibo', prefix: '\$ '),
                validator: validateAmount,
              ),
              const SizedBox(height: 28),
              BigButton(
                label: _saving ? 'Guardando…' : 'Continuar',
                icon: Icons.arrow_forward,
                onPressed: _saving ? () {} : _submit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
