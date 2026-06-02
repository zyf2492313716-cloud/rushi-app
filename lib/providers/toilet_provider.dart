import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/models/toilet_marker.dart';

class ToiletProvider extends ChangeNotifier {
  List<ToiletMarker> _toilets = [];
  bool _loaded = false;

  List<ToiletMarker> get toilets => _toilets;

  Future<void> load() async {
    if (_loaded) return;
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString('toilets');
    if (raw != null) {
      final list = jsonDecode(raw) as List;
      _toilets = list.map((e) => ToiletMarker.fromJson(e)).toList();
    }
    _loaded = true;
    notifyListeners();
  }

  Future<void> add(ToiletMarker toilet) async {
    _toilets.add(toilet);
    notifyListeners();
    await _save();
  }

  Future<void> remove(String id) async {
    _toilets.removeWhere((t) => t.id == id);
    notifyListeners();
    await _save();
  }

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = jsonEncode(_toilets.map((e) => e.toJson()).toList());
    await prefs.setString('toilets', raw);
  }
}
