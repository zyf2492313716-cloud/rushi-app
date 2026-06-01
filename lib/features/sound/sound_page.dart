import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimens.dart';
import '../../core/constants/app_strings.dart';
import '../../core/models/sound_item.dart';

final List<SoundItem> _sounds = [
  SoundItem(
    id: 'stream',
    name: AppStrings.soundStream,
    assetPath: 'audio/stream.mp3',
    icon: Icons.waves,
  ),
  SoundItem(
    id: 'rain',
    name: AppStrings.soundRain,
    assetPath: 'audio/rain.mp3',
    icon: Icons.water_drop,
  ),
  SoundItem(
    id: 'ocean',
    name: AppStrings.soundOcean,
    assetPath: 'audio/ocean.mp3',
    icon: Icons.beach_access,
  ),
  SoundItem(
    id: 'wind',
    name: AppStrings.soundWind,
    assetPath: 'audio/wind.mp3',
    icon: Icons.air,
  ),
  SoundItem(
    id: 'water',
    name: AppStrings.soundWater,
    assetPath: 'audio/water.mp3',
    icon: Icons.plumbing,
  ),
  SoundItem(
    id: 'whitenoise',
    name: AppStrings.soundWhiteNoise,
    assetPath: 'audio/whitenoise.mp3',
    icon: Icons.tune,
  ),
  SoundItem(
    id: 'brownnoise',
    name: AppStrings.soundBrownNoise,
    assetPath: 'audio/brownnoise.mp3',
    icon: Icons.graphic_eq,
  ),
];

class SoundPage extends StatefulWidget {
  const SoundPage({super.key});

  @override
  State<SoundPage> createState() => _SoundPageState();
}

class _SoundPageState extends State<SoundPage> {
  String? _playingId;
  int? _selectedMinutes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.soundAssist)),
      body: Column(
        children: [
          if (_playingId != null) _buildNowPlaying(),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(AppDimens.md),
              itemCount: _sounds.length,
              itemBuilder: (context, index) {
                final sound = _sounds[index];
                final isPlaying = _playingId == sound.id;
                return Card(
                  margin: const EdgeInsets.only(bottom: AppDimens.sm),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(AppDimens.cardRadius),
                    onTap: () {
                      setState(() {
                        _playingId = _playingId == sound.id ? null : sound.id;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(AppDimens.md),
                      child: Row(
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: isPlaying
                                  ? AppColors.secondary.withValues(alpha: 0.15)
                                  : AppColors.primary.withValues(alpha: 0.08),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              sound.icon,
                              color: isPlaying
                                  ? AppColors.secondary
                                  : AppColors.primary,
                            ),
                          ),
                          const SizedBox(width: AppDimens.md),
                          Expanded(
                            child: Text(
                              sound.name,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                          Icon(
                            isPlaying
                                ? Icons.pause_circle_filled
                                : Icons.play_circle_outline,
                            color: isPlaying
                                ? AppColors.secondary
                                : AppColors.primary,
                            size: 32,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNowPlaying() {
    return Container(
      padding: const EdgeInsets.all(AppDimens.md),
      margin: const EdgeInsets.fromLTRB(
        AppDimens.md, 0, AppDimens.md, AppDimens.sm,
      ),
      decoration: BoxDecoration(
        color: AppColors.secondary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppDimens.cardRadius),
      ),
      child: Row(
        children: [
          const Icon(Icons.headphones, color: AppColors.secondary),
          const SizedBox(width: AppDimens.sm),
          Text(
            '${AppStrings.soundPlaying}...',
            style: const TextStyle(color: AppColors.secondary),
          ),
          const Spacer(),
          _buildTimerDropdown(),
        ],
      ),
    );
  }

  Widget _buildTimerDropdown() {
    return DropdownButton<int?>(
      value: _selectedMinutes,
      hint: Text(
        AppStrings.soundTimer,
        style: const TextStyle(fontSize: 12),
      ),
      underline: const SizedBox(),
      items: [null, 5, 10, 15, 30, 60].map((min) {
        return DropdownMenuItem(
          value: min,
          child: Text(
            min == null ? '关闭' : '$min min',
            style: const TextStyle(fontSize: 12),
          ),
        );
      }).toList(),
      onChanged: (v) => setState(() => _selectedMinutes = v),
    );
  }
}
