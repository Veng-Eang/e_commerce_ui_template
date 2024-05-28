import '/app/app.dart';
import '/config/admin_config.dart';
import '/config/flavor_config.dart';
import 'package:flutter/material.dart';

// flutter run --flavor admin -t .\lib\main_admin.dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  FlavorConfig(
    flavor: Flavor.admin,
    flavorValues: FlavorValues(
      roleConfig: AdminConfig(),
    ),
  );

  runApp(
    const App(),
  );
}
