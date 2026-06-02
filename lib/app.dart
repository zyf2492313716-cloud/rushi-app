import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/app_settings_provider.dart';
import 'theme.dart';
import 'router.dart';

class RushiaApp extends StatelessWidget {
  const RushiaApp({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<AppSettingsProvider>();

    return MaterialApp(
      title: '如释',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: settings.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      initialRoute: AppRoutes.home,
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}
