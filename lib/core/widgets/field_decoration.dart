import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Estilo común para campos de texto.
InputDecoration fieldDecoration(String label, {String? hint, String? prefix}) {
  OutlineInputBorder border(Color c, double w) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: c, width: w),
      );
  return InputDecoration(
    labelText: label,
    hintText: hint,
    prefixText: prefix,
    labelStyle: const TextStyle(fontSize: 18, color: AppColors.muted),
    hintStyle: const TextStyle(fontSize: 16),
    errorStyle: const TextStyle(fontSize: 15),
    filled: true,
    fillColor: Colors.white,
    contentPadding: const EdgeInsets.all(18),
    border: border(AppColors.border, 1.5),
    enabledBorder: border(AppColors.border, 1.5),
    focusedBorder: border(AppColors.primary, 2.5),
  );
}
