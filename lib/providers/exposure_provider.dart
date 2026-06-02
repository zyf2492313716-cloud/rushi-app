import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/constants/app_strings.dart';
import '../core/models/exposure_level.dart';

class ExposureProvider extends ChangeNotifier {
  List<ExposureLevel> _levels = [];
  bool _loaded = false;

  List<ExposureLevel> get levels => _levels;

  Future<void> load() async {
    if (_loaded) return;
    _levels = _initLevels();
    final prefs = await SharedPreferences.getInstance();
    for (int i = 0; i < _levels.length; i++) {
      final done = prefs.getBool('exposure_level_${_levels[i].id}') ?? false;
      if (done) {
        _levels[i] = _levels[i].copyWith(isCompleted: true);
      }
    }
    _loaded = true;
    notifyListeners();
  }

  void markCompleted(String levelId) {
    final idx = _levels.indexWhere((l) => l.id == levelId);
    if (idx == -1 || _levels[idx].isCompleted) return;
    _levels[idx] = _levels[idx].copyWith(isCompleted: true);
    notifyListeners();
    SharedPreferences.getInstance().then(
      (prefs) => prefs.setBool('exposure_level_$levelId', true),
    );
  }

  Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    for (final l in _levels) {
      await prefs.remove('exposure_level_${l.id}');
    }
    _levels = _initLevels();
    notifyListeners();
  }
}

List<ExposureLevel> _initLevels() => [
  const ExposureLevel(
    id: '1',
    title: AppStrings.levelHome,
    description: AppStrings.levelHomeDesc,
    difficulty: Difficulty.easy,
  ),
  const ExposureLevel(
    id: '2',
    title: AppStrings.levelDoorClosed,
    description: AppStrings.levelDoorClosedDesc,
    difficulty: Difficulty.easy,
  ),
  const ExposureLevel(
    id: '3',
    title: AppStrings.levelPublicEmpty,
    description: AppStrings.levelPublicEmptyDesc,
    difficulty: Difficulty.medium,
  ),
  const ExposureLevel(
    id: '4',
    title: AppStrings.levelPublicSomeone,
    description: AppStrings.levelPublicSomeoneDesc,
    difficulty: Difficulty.medium,
  ),
  const ExposureLevel(
    id: '5',
    title: AppStrings.levelUrinal,
    description: AppStrings.levelUrinalDesc,
    difficulty: Difficulty.hard,
  ),
  const ExposureLevel(
    id: '6',
    title: AppStrings.levelBusy,
    description: AppStrings.levelBusyDesc,
    difficulty: Difficulty.hard,
  ),
];
