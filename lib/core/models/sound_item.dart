import 'package:flutter/material.dart';

class SoundItem {
  final String id;
  final String name;
  final String assetPath;
  final IconData icon;

  const SoundItem({
    required this.id,
    required this.name,
    required this.assetPath,
    required this.icon,
  });
}
