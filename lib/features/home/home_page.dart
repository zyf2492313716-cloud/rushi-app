import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimens.dart';
import '../../core/constants/app_strings.dart';
import '../../core/widgets/feature_card.dart';
import '../../router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppDimens.lg, AppDimens.xl, AppDimens.lg, AppDimens.md,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.appName,
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        AppStrings.appTagline,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.settings_outlined),
                    onPressed: () =>
                        Navigator.pushNamed(context, AppRoutes.settings),
                    color: AppColors.textSecondary,
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.only(bottom: AppDimens.lg),
                children: [
                  FeatureCard(
                    title: AppStrings.crisisMode,
                    description: AppStrings.crisisModeDesc,
                    icon: Icons.spa_outlined,
                    color: AppColors.secondary,
                    onTap: () =>
                        Navigator.pushNamed(context, AppRoutes.crisis),
                  ),
                  FeatureCard(
                    title: AppStrings.soundAssist,
                    description: AppStrings.soundAssistDesc,
                    icon: Icons.music_note_outlined,
                    color: AppColors.primary,
                    onTap: () =>
                        Navigator.pushNamed(context, AppRoutes.sound),
                  ),
                  FeatureCard(
                    title: AppStrings.toiletMap,
                    description: AppStrings.toiletMapDesc,
                    icon: Icons.map_outlined,
                    color: AppColors.accent,
                    onTap: () =>
                        Navigator.pushNamed(context, AppRoutes.map),
                  ),
                  FeatureCard(
                    title: AppStrings.exposureTrain,
                    description: AppStrings.exposureTrainDesc,
                    icon: Icons.trending_up,
                    color: AppColors.success,
                    onTap: () =>
                        Navigator.pushNamed(context, AppRoutes.exposure),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
