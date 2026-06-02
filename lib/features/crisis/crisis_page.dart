import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimens.dart';
import '../../core/constants/app_strings.dart';
import '../../core/widgets/breathing_circle.dart';

class CrisisPage extends StatefulWidget {
  const CrisisPage({super.key});

  @override
  State<CrisisPage> createState() => _CrisisPageState();
}

class _CrisisPageState extends State<CrisisPage>
    with SingleTickerProviderStateMixin {
  bool _isActive = false;
  bool _isDone = false;
  int _secondsRemaining = 120;
  Timer? _timer;
  late AnimationController _fadeController;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _fadeController.dispose();
    super.dispose();
  }

  void _startSession() {
    HapticFeedback.heavyImpact();
    setState(() {
      _isActive = true;
      _isDone = false;
      _secondsRemaining = 120;
    });
    _fadeController.reset();
    _fadeController.forward();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining <= 1) {
        timer.cancel();
        _finishSession();
      } else {
        setState(() => _secondsRemaining--);
      }
    });
  }

  void _finishSession() {
    HapticFeedback.mediumImpact();
    setState(() {
      _isActive = false;
      _isDone = true;
    });
  }

  void _reset() {
    setState(() {
      _isDone = false;
      _secondsRemaining = 120;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          _isActive ? AppColors.darkBg : Theme.of(context).scaffoldBackgroundColor,
      appBar: _isActive
          ? null
          : AppBar(title: const Text(AppStrings.crisisMode)),
      body: SafeArea(
        child: Center(
          child: _buildBody(),
        ),
      ),
    );
  }

  Widget _buildBody() {
    if (_isActive) return _buildActiveSession();
    if (_isDone) return _buildDoneView();
    return _buildStartView();
  }

  Widget _buildStartView() {
    return Padding(
      padding: const EdgeInsets.all(AppDimens.xl),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.secondary.withValues(alpha: 0.1),
            ),
            child: const Icon(
              Icons.spa,
              size: 56,
              color: AppColors.secondary,
            ),
          ),
          const SizedBox(height: AppDimens.xl),
          Text(
            '感到紧张吗？',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: AppDimens.sm),
          Text(
            '花 2 分钟跟随引导放松',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: AppDimens.xxl),
          SizedBox(
            width: 200,
            height: 56,
            child: ElevatedButton(
              onPressed: _startSession,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.secondary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
                elevation: 0,
              ),
              child: const Text(
                AppStrings.startCrisis,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActiveSession() {
    final minutes = _secondsRemaining ~/ 60;
    final seconds = _secondsRemaining % 60;

    return FadeTransition(
      opacity: _fadeController,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BreathingCircle(
            size: 280,
            color: AppColors.secondary,
            durationSeconds: 8,
          ),
          const SizedBox(height: AppDimens.xxl),
          Text(
          '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
            style: const TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.w300,
              color: Colors.white,
              letterSpacing: 4,
            ),
          ),
          const SizedBox(height: AppDimens.lg),
          Text(
            AppStrings.crisisHint,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white54,
            ),
          ),
          const SizedBox(height: AppDimens.xxl),
          TextButton(
            onPressed: () {
              _timer?.cancel();
              setState(() => _isActive = false);
            },
            child: const Text(
              '提前结束',
              style: TextStyle(color: Colors.white38),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDoneView() {
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
              color: AppColors.success.withValues(alpha: 0.1),
            ),
            child: const Icon(
              Icons.check_circle_outline,
              size: 56,
              color: AppColors.success,
            ),
          ),
          const SizedBox(height: AppDimens.xl),
          Text(
            AppStrings.crisisDone,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: AppDimens.xxl),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton(
                onPressed: _reset,
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.secondary,
                  side: const BorderSide(color: AppColors.secondary),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24, vertical: 14,
                  ),
                ),
                child: const Text(AppStrings.crisisNeedMore),
              ),
              const SizedBox(width: AppDimens.md),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.secondary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24, vertical: 14,
                  ),
                  elevation: 0,
                ),
                child: const Text(AppStrings.crisisFeelBetter),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
