import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimens.dart';
import '../../core/constants/app_strings.dart';
import '../../core/models/exposure_level.dart';
import '../../providers/exposure_provider.dart';
import '../../router.dart';

String _difficultyLabel(Difficulty d) {
  switch (d) {
    case Difficulty.easy:
      return '简单';
    case Difficulty.medium:
      return '中等';
    case Difficulty.hard:
      return '困难';
  }
}

Color _difficultyColor(Difficulty d) {
  switch (d) {
    case Difficulty.easy:
      return AppColors.success;
    case Difficulty.medium:
      return AppColors.safetyYellow;
    case Difficulty.hard:
      return AppColors.error;
  }
}

class ExposurePage extends StatelessWidget {
  const ExposurePage({super.key});

  @override
  Widget build(BuildContext context) {
    final levels = context.watch<ExposureProvider>().levels;

    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.exposureTrain)),
      body: ListView.builder(
        padding: const EdgeInsets.all(AppDimens.md),
        itemCount: levels.length,
        itemBuilder: (context, index) {
          final level = levels[index];
          final isUnlocked = index == 0 || levels[index - 1].isCompleted;

          final card = Card(
            margin: const EdgeInsets.only(bottom: AppDimens.sm),
            child: InkWell(
              borderRadius: BorderRadius.circular(AppDimens.cardRadius),
              onTap: isUnlocked
                  ? () async {
                      final result = await Navigator.pushNamed(
                        context,
                        AppRoutes.exercise,
                        arguments: {'levelId': level.id},
                      );
                      if (result == true && context.mounted) {
                        context.read<ExposureProvider>().markCompleted(level.id);
                      }
                    }
                  : null,
              child: Padding(
                padding: const EdgeInsets.all(AppDimens.md),
                child: Row(
                  children: [
                    _buildLevelBadge(level),
                    const SizedBox(width: AppDimens.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            level.title,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            level.description,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: AppDimens.sm),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: _difficultyColor(level.difficulty)
                            .withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        _difficultyLabel(level.difficulty),
                        style: TextStyle(
                          fontSize: 12,
                          color: _difficultyColor(level.difficulty),
                        ),
                      ),
                    ),
                    if (level.isCompleted)
                      const Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Icon(
                          Icons.check_circle,
                          color: AppColors.success,
                          size: 20,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );

          if (!isUnlocked) {
            return Opacity(opacity: 0.5, child: card);
          }
          return card;
        },
      ),
    );
  }

  Widget _buildLevelBadge(ExposureLevel level) {
    final number = int.tryParse(level.id) ?? 0;
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: level.isCompleted
            ? AppColors.success
            : AppColors.primary.withValues(alpha: 0.1),
      ),
      child: Center(
        child: Text(
          '$number',
          style: TextStyle(
            color: level.isCompleted ? Colors.white : AppColors.primary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
