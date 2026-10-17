import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'presentation/screens/register/register_screen.dart';
import 'presentation/shell/main_shell.dart';
import 'presentation/state/app_controller.dart';

/// Raíz: sin perfil -> registro; con perfil -> app.
class AguaApp extends StatelessWidget {
  const AguaApp({super.key, required this.controller});
  final AppController controller;

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Servicio de Agua',
        theme: AppTheme.light,
        home: ListenableBuilder(
          listenable: controller,
          builder: (_, __) {
            if (controller.loading) {
              return const Scaffold(
                  body: Center(child: CircularProgressIndicator()));
            }
            return controller.profile == null
                ? RegisterScreen(controller: controller)
                : MainShell(controller: controller);
          },
        ),
      );
}
