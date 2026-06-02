import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimens.dart';
import '../../core/constants/app_strings.dart';
import '../../core/models/toilet_marker.dart';
import '../../core/widgets/safety_rating.dart';

class ToiletMapPage extends StatefulWidget {
  const ToiletMapPage({super.key});

  @override
  State<ToiletMapPage> createState() => _ToiletMapPageState();
}

class _ToiletMapPageState extends State<ToiletMapPage> {
  final List<ToiletMarker> _toilets = [
    const ToiletMarker(
      id: '1',
      name: '商场三楼卫生间',
      address: 'XX商场三楼东侧',
      latitude: 39.9042,
      longitude: 116.4074,
      safetyRating: 4,
      comment: '很干净，有独立马桶间',
    ),
    const ToiletMarker(
      id: '2',
      name: '地铁站卫生间',
      address: 'XX地铁站A口',
      latitude: 39.9050,
      longitude: 116.4080,
      safetyRating: 2,
      comment: '人比较多，小便池无隔板',
    ),
    const ToiletMarker(
      id: '3',
      name: '咖啡店厕所',
      address: 'XX咖啡店内',
      latitude: 39.9035,
      longitude: 116.4065,
      safetyRating: 5,
      comment: '单间，有门锁，非常安静',
    ),
  ];

  int _nextId = 4;

  @override
  Widget build(BuildContext context) {
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
            child: _toilets.isEmpty
                ? Center(
                    child: Text(
                      '还没有收藏的厕所',
                      style: TextStyle(color: Colors.grey[400]),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: AppDimens.md),
                    itemCount: _toilets.length,
                    itemBuilder: (context, index) {
                      final toilet = _toilets[index];
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
                        setState(() {
                          _toilets.add(ToiletMarker(
                            id: '${_nextId++}',
                            name: name,
                            address: addressCtrl.text.trim(),
                            latitude: 0,
                            longitude: 0,
                            safetyRating: rating,
                            comment: commentCtrl.text.trim(),
                          ));
                        });
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
