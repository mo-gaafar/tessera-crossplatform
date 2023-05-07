import 'package:flutter/material.dart';

class DashboardItem extends StatelessWidget {
  const DashboardItem(
      {super.key, this.height = 100, this.padding = 20, required this.child});

  final Widget child;

  final double? height;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding),
      // alignment: Alignment.center,
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color:
            Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.3),
      ),
      child: child,
    );
  }
}
