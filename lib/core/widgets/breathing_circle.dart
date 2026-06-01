import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class BreathingCircle extends StatefulWidget {
  final double size;
  final Color color;
  final int durationSeconds;

  const BreathingCircle({
    super.key,
    this.size = 280,
    this.color = AppColors.secondary,
    this.durationSeconds = 8,
  });

  @override
  State<BreathingCircle> createState() => _BreathingCircleState();
}

class _BreathingCircleState extends State<BreathingCircle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnim;
  late Animation<double> _opacityAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.durationSeconds),
    );

    _scaleAnim = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _opacityAnim = Tween<double>(begin: 0.3, end: 0.8).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          size: Size(widget.size, widget.size),
          painter: _BreathingPainter(
            scale: _scaleAnim.value,
            opacity: _opacityAnim.value,
            color: widget.color,
          ),
        );
      },
    );
  }
}

class _BreathingPainter extends CustomPainter {
  final double scale;
  final double opacity;
  final Color color;

  _BreathingPainter({
    required this.scale,
    required this.opacity,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 * scale;

    final paint = Paint()
      ..color = color.withValues(alpha: opacity)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 30);

    canvas.drawCircle(center, radius, paint);

    final innerPaint = Paint()
      ..color = color.withValues(alpha: opacity * 0.5)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 50);

    canvas.drawCircle(center, radius * 0.5, innerPaint);
  }

  @override
  bool shouldRepaint(covariant _BreathingPainter old) {
    return old.scale != scale || old.opacity != opacity;
  }
}
