import '/app/app.dart';
import '/config/flavor_config.dart';
import '/config/user_config.dart';
import 'package:flutter/material.dart';

// flutter run --flavor user -t .\lib\main_user.dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  FlavorConfig(
    flavor: Flavor.user,
    flavorValues: FlavorValues(
      roleConfig: UserConfig(),
    ),
  );

  runApp(
    const App(),
  );
}
