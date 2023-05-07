import 'package:flutter/material.dart';
import 'package:tessera/constants/app_colors.dart';

class ExpandableDashboardItem extends StatelessWidget {
  const ExpandableDashboardItem(
      {super.key,
      required this.title,
      required this.children,
      this.height = 90,
      this.padding = 20});

  final Widget title;
  final List<Widget> children;
  final double height;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      tilePadding: EdgeInsets.only(right: 15),
      // trailing: const Icon(Icons.arrow_drop_down),
      backgroundColor: AppColors.secondary.withOpacity(0.3),
      collapsedBackgroundColor: Theme.of(context).colorScheme.inversePrimary,
      textColor: Theme.of(context).textTheme.bodyLarge!.color,
      iconColor: Theme.of(context).textTheme.bodyLarge!.color,
      collapsedTextColor: Theme.of(context).textTheme.bodyLarge!.color,
      collapsedIconColor: Theme.of(context).textTheme.bodyLarge!.color,
      collapsedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Container(
        padding: EdgeInsets.all(padding),
        height: height,
        child: title,
      ),
      children: children,
    );
  }
}
