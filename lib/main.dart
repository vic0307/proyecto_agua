import 'package:flutter/material.dart';

import 'app.dart';
import 'data/repositories/in_memory_water_repository.dart';
import 'presentation/state/app_controller.dart';

void main() {
  final controller = AppController(InMemoryWaterRepository())..load();
  runApp(AguaApp(controller: controller));
}
