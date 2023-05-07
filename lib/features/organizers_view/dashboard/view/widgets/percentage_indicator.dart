import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class PercentageIndicator extends StatefulWidget {
  const PercentageIndicator({super.key});

  // final DashboardSuccess state;

  @override
  State<PercentageIndicator> createState() => _PercentageIndicatorState();
}

class _PercentageIndicatorState extends State<PercentageIndicator>
    with SingleTickerProviderStateMixin {
  // late AnimationController _animationController;
  // late Animation animation;

  // @override
  // void initState() {
  //   super.initState();

  //   _animationController = AnimationController(
  //       vsync: this, duration: const Duration(milliseconds: 500));
  //   // animation =
  //   //     IntTween(begin: 0, end: widget.state.dashboardModel.percentAttended!)
  //   //         .animate(_animationController);

  //   Future.delayed(const Duration(milliseconds: 800), () {
  //     _animationController.forward();
  //   });

  //   _animationController.addListener(() {
  //     setState(() {});
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return CircularStepProgressIndicator(
      totalSteps: 100,
      currentStep: 30,
      // selectedColor: AppColors.saffron,
      // unselectedColor: AppColors.saffron.withOpacity(0.1),
      padding: 0,
      width: 100,
      height: 100,
      // selectedStepSize: 10,
      // unselectedStepSize: 10,
      roundedCap: (_, __) => true,
      child: Center(
        child: Text(
          ' %',
          style: const TextStyle(fontSize: 32),
        ),
      ),
    );
  }

  // @override
  // void dispose() {
  //   _animationController.dispose();
  //   super.dispose();
  // }
}
