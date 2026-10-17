import 'package:flutter/material.dart';

import '../../../../domain/entities/request_type.dart';

/// Icono de cada tipo (se mantiene fuera del dominio).
extension RequestTypeIcon on RequestType {
  IconData get icon => switch (this) {
        RequestType.pipa => Icons.local_shipping_outlined,
        RequestType.toma => Icons.water_drop_outlined,
      };
}
