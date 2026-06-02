import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimens.dart';
import '../../core/constants/app_strings.dart';
import '../../core/models/toilet_marker.dart';
import '../../core/widgets/safety_rating.dart';
import '../../providers/toilet_provider.dart';

class ToiletMapPage extends StatelessWidget {
  const ToiletMapPage({super.key});

  @override
  Widget build(BuildContext context) {
    final toilets = context.watch<ToiletProvider>().toilets;

    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.mapTitle)),
      body: Column(
        children: [
          Container(
            height: 200,
            width: double.infinity,
            color: AppColors.surfaceLight,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.map, size: 48, color: Colors.grey[400]),
                  const SizedBox(height: AppDimens.sm),
                  Text(
                    '地图视图（需高德 SDK 接入）',
                    style: TextStyle(color: Colors.grey[500]),
                  ),
                  Text(
                    '预计在后续版本上线',
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppDimens.md),
            child: Row(
              children: [
                Text(
                  AppStrings.myToilets,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const Spacer(),
                TextButton.icon(
                  onPressed: () => _showAddToiletDialog(context),
                  icon: const Icon(Icons.add, size: 18),
                  label: const Text(AppStrings.addToilet),
                ),
              ],
            ),
          ),
          Expanded(
            child: toilets.isEmpty
                ? Center(
                    child: Text(
                      '还没有收藏的厕所',
                      style: TextStyle(color: Colors.grey[400]),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: AppDimens.md),
                    itemCount: toilets.length,
                    itemBuilder: (context, index) {
                      final toilet = toilets[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: AppDimens.sm),
                        child: Padding(
                          padding: const EdgeInsets.all(AppDimens.md),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      toilet.name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                    if (toilet.address != null) ...[
                                      const SizedBox(height: 4),
                                      Text(
                                        toilet.address!,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                    ],
                                    const SizedBox(height: AppDimens.sm),
                                    SafetyRating(rating: toilet.safetyRating),
                                  ],
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.navigation,
                                    color: AppColors.secondary),
                                onPressed: () {},
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete_outline,
                                    color: AppColors.error),
                                onPressed: () => context
                                    .read<ToiletProvider>()
                                    .remove(toilet.id),
                              ),
                            ],
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

  void _showAddToiletDialog(BuildContext context) {
    final nameCtrl = TextEditingController();
    final addressCtrl = TextEditingController();
    final commentCtrl = TextEditingController();
    int rating = 3;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return StatefulBuilder(
          builder: (ctx, setDialogState) {
            return Padding(
              padding: EdgeInsets.only(
                left: AppDimens.lg,
                right: AppDimens.lg,
                top: AppDimens.lg,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + AppDimens.lg,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.addToilet,
                    style: Theme.of(ctx).textTheme.titleLarge,
                  ),
                  const SizedBox(height: AppDimens.md),
                  TextField(
                    controller: nameCtrl,
                    decoration: const InputDecoration(
                      labelText: AppStrings.toiletName,
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: AppDimens.sm),
                  TextField(
                    controller: addressCtrl,
                    decoration: const InputDecoration(
                      labelText: AppStrings.toiletAddress,
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: AppDimens.md),
                  Text(AppStrings.safetyRating),
                  const SizedBox(height: AppDimens.sm),
                  SafetyRating(
                    rating: rating,
                    size: 32,
                    interactive: true,
                    onChanged: (v) => setDialogState(() => rating = v),
                  ),
                  const SizedBox(height: AppDimens.md),
                  TextField(
                    controller: commentCtrl,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      labelText: AppStrings.addComment,
                      border: OutlineInputBorder(),
                      alignLabelWithHint: true,
                    ),
                  ),
                  const SizedBox(height: AppDimens.lg),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        final name = nameCtrl.text.trim();
                        if (name.isEmpty) return;
                        context.read<ToiletProvider>().add(ToiletMarker(
                          id: DateTime.now().millisecondsSinceEpoch.toString(),
                          name: name,
                          address: addressCtrl.text.trim(),
                          latitude: 0,
                          longitude: 0,
                          safetyRating: rating,
                          comment: commentCtrl.text.trim(),
                        ));
                        Navigator.pop(ctx);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(AppStrings.save),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
