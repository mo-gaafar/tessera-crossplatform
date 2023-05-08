import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:tessera/constants/app_colors.dart';
import 'package:tessera/features/organizers_view/dashboard/cubit/dashboard_cubit.dart';

class PercentageIndicator extends StatefulWidget {
  const PercentageIndicator(
      {super.key,
      required this.percentage,
      this.fontSize = 32,
      this.size = 120,
      this.stepSize = 7});

  final int percentage;
  final double fontSize;
  final double size;
  final double stepSize;

  @override
  State<PercentageIndicator> createState() => _PercentageIndicatorState();
}

class _PercentageIndicatorState extends State<PercentageIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation animation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    animation = IntTween(begin: 0, end: widget.percentage)
        .animate(_animationController);

    Future.delayed(const Duration(milliseconds: 800), () {
      _animationController.forward();
    });

    _animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return CircularStepProgressIndicator(
      totalSteps: 100,
      currentStep: animation.value,
      selectedColor: AppColors.secondary,
      unselectedColor: AppColors.secondary.withOpacity(0.1),
      padding: 0,
      width: widget.size,
      height: widget.size,
      selectedStepSize: widget.stepSize,
      unselectedStepSize: widget.stepSize,
      roundedCap: (_, __) => true,
      child: Center(
        child: Text(
          '${widget.percentage} %',
          style: TextStyle(fontSize: widget.fontSize),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
