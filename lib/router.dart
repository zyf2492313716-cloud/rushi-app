import 'package:flutter/material.dart';
import 'features/home/home_page.dart';
import 'features/sound/sound_page.dart';
import 'features/crisis/crisis_page.dart';
import 'features/map/map_page.dart';
import 'features/exposure/exposure_page.dart';
import 'features/exposure/exercise_page.dart';
import 'features/settings/settings_page.dart';

class AppRoutes {
  static const String home = '/';
  static const String sound = '/sound';
  static const String crisis = '/crisis';
  static const String map = '/map';
  static const String exposure = '/exposure';
  static const String exercise = '/exposure/exercise';
  static const String settings = '/settings';

  static Route<dynamic> generateRoute(RouteSettings rs) {
    switch (rs.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case sound:
        return MaterialPageRoute(builder: (_) => const SoundPage());
      case crisis:
        return MaterialPageRoute(builder: (_) => const CrisisPage());
      case map:
        return MaterialPageRoute(builder: (_) => const ToiletMapPage());
      case exposure:
        return MaterialPageRoute(builder: (_) => const ExposurePage());
      case exercise:
        final args = rs.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => ExercisePage(levelId: args?['levelId'] as String?),
        );
      case settings:
        return MaterialPageRoute(builder: (_) => const SettingsPage());
      default:
        return MaterialPageRoute(builder: (_) => const HomePage());
    }
  }
}
