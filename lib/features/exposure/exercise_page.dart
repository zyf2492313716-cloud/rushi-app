import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimens.dart';
import '../../core/constants/app_strings.dart';

class ExercisePage extends StatefulWidget {
  final String? levelId;

  const ExercisePage({super.key, this.levelId});

  @override
  State<ExercisePage> createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage>
    with SingleTickerProviderStateMixin {
  bool _isExercising = false;
  bool _isCompleted = false;
  bool _isSuccess = false;
  int _seconds = 0;
  Timer? _timer;
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pulseController.dispose();
    super.dispose();
  }

  void _startExercise() {
    setState(() {
      _isExercising = true;
      _isCompleted = false;
      _seconds = 0;
    });
    _pulseController.repeat(reverse: true);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() => _seconds++);
    });
  }

  void _completeExercise(bool success) {
    _timer?.cancel();
    _pulseController.stop();
    _pulseController.reset();
    HapticFeedback.mediumImpact();
    setState(() {
      _isExercising = false;
      _isCompleted = true;
      _isSuccess = success;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('第 ${widget.levelId ?? "?"} 关'),
        automaticallyImplyLeading: !_isExercising,
      ),
      body: SafeArea(
        child: Center(
          child: _buildBody(),
        ),
      ),
    );
  }

  Widget _buildBody() {
    if (_isExercising) return _buildExerciseView();
    if (_isCompleted) return _buildResultView();
    return _buildPrepareView();
  }

  Widget _buildPrepareView() {
    return Padding(
      padding: const EdgeInsets.all(AppDimens.xl),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primary.withValues(alpha: 0.1),
            ),
            child: const Icon(
              Icons.psychology_outlined,
              size: 48,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: AppDimens.xl),
          Text(
            '准备好了吗？',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: AppDimens.sm),
          Text(
            '找一个安静的环境，点击开始',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: AppDimens.xxl),
          SizedBox(
            width: 200,
            height: 56,
            child: ElevatedButton(
              onPressed: _startExercise,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
                elevation: 0,
              ),
              child: const Text(
                AppStrings.startExercise,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExerciseView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedBuilder(
          animation: _pulseController,
          builder: (context, child) {
            return Container(
              width: 160 + _pulseController.value * 40,
              height: 160 + _pulseController.value * 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary.withValues(
                  alpha: 0.1 + _pulseController.value * 0.1,
                ),
              ),
              child: Center(
                child: Text(
                  '${_seconds ~/ 60}:${(_seconds % 60).toString().padLeft(2, '0')}',
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        color: AppColors.primary,
                      ),
                ),
              ),
            );
          },
        ),
        const SizedBox(height: AppDimens.xxl),
        Text(
          '尝试放松，不要有压力',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        Text(
          '准备好了可以结束本次练习',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: AppDimens.xxl),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton(
              onPressed: () => _completeExercise(false),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.error,
                side: const BorderSide(color: AppColors.error),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24, vertical: 14,
                ),
              ),
              child: const Text('未成功'),
            ),
            const SizedBox(width: AppDimens.md),
            ElevatedButton(
              onPressed: () => _completeExercise(true),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.success,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24, vertical: 14,
                ),
                elevation: 0,
              ),
              child: const Text('成功了！'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildResultView() {
    return Padding(
      padding: const EdgeInsets.all(AppDimens.xl),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            _isSuccess
                ? Icons.celebration_outlined
                : Icons.refresh,
            size: 72,
            color: _isSuccess ? AppColors.success : AppColors.error,
          ),
          const SizedBox(height: AppDimens.xl),
          Text(
            _isSuccess ? '练习完成' : '未成功',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: _isSuccess ? null : AppColors.error,
            ),
          ),
          const SizedBox(height: AppDimens.sm),
          Text(
            '用时 ${_seconds ~/ 60} 分 ${_seconds % 60} 秒',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: AppDimens.xxl),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton(
                onPressed: () {
                  setState(() {
                    _isCompleted = false;
                    _isSuccess = false;
                  });
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.primary,
                  side: const BorderSide(color: AppColors.primary),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24, vertical: 14,
                  ),
                ),
                child: const Text(AppStrings.retry),
              ),
              const SizedBox(width: AppDimens.md),
              ElevatedButton(
                onPressed: () => Navigator.pop(context, _isSuccess),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.success,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24, vertical: 14,
                  ),
                  elevation: 0,
                ),
                child: const Text('返回'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
