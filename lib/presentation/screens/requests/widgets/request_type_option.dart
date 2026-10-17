import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../domain/entities/request_type.dart';
import 'request_type_icon.dart';

/// Opción grande para elegir el tipo de solicitud.
class RequestTypeOption extends StatelessWidget {
  const RequestTypeOption({
    super.key,
    required this.type,
    required this.selected,
    required this.onTap,
  });
  final RequestType type;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Semantics(
        button: true,
        selected: selected,
        label: type.label,
        child: Material(
          color: selected ? AppColors.primaryLight : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
                color: selected ? AppColors.primary : AppColors.border,
                width: selected ? 3 : 1.5),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 8),
              child: Column(children: [
                Icon(selected ? Icons.check_circle : type.icon,
                    size: 34, color: AppColors.primary),
                const SizedBox(height: 8),
                Text(type.label,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: AppColors.text)),
              ]),
            ),
          ),
        ),
      );
}
