import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'app.dart';
import 'providers/app_settings_provider.dart';
import 'providers/exposure_provider.dart';
import 'providers/toilet_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final settings = AppSettingsProvider();
  final exposure = ExposureProvider();
  final toilets = ToiletProvider();

  await Future.wait([
    settings.load(),
    exposure.load(),
    toilets.load(),
  ]);

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: settings),
        ChangeNotifierProvider.value(value: exposure),
        ChangeNotifierProvider.value(value: toilets),
      ],
      child: const RushiaApp(),
    ),
  );
}
