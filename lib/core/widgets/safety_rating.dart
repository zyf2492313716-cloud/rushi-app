import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class SafetyRating extends StatelessWidget {
  final int rating;
  final double size;
  final bool interactive;

  const SafetyRating({
    super.key,
    this.rating = 0,
    this.size = 28,
    this.interactive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        final filled = index < rating;
        return Padding(
          padding: const EdgeInsets.only(right: 2),
          child: Icon(
            filled ? Icons.shield : Icons.shield_outlined,
            size: size,
            color: filled ? _getColor(index) : Colors.grey[300],
          ),
        );
      }),
    );
  }

  Color _getColor(int index) {
    if (index <= 1) return AppColors.safetyRed;
    if (index <= 3) return AppColors.safetyYellow;
    return AppColors.safetyGreen;
  }
}
