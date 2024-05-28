import 'package:e_commerce/app/pages/auth/login/login_page.dart';
import 'package:e_commerce/app/provider/dark_mode_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../config/flavor_config.dart';
import '../routes/routes.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DarkModeProvider()..getDarkMode(),
      child: Consumer<DarkModeProvider>(
        builder: (context, darkMode, child) {
          return MaterialApp(
            title: FlavorConfig.instance.flavorValues.roleConfig.appName(),
            theme: FlavorConfig.instance.flavorValues.roleConfig.theme(),
            darkTheme: FlavorConfig.instance.flavorValues.roleConfig.darkTheme(),
            themeMode: darkMode.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            routes: routes,
            debugShowCheckedModeBanner: false,
            home: const LoginPage(),
          );
        },
      ),
    );
  }
}
