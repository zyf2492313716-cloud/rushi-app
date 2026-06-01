import 'package:flutter/material.dart';
import 'theme.dart';
import 'router.dart';

class RushiaApp extends StatelessWidget {
  const RushiaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '如释',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      initialRoute: AppRoutes.home,
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}
