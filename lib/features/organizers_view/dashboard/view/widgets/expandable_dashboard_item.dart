import 'package:flutter/material.dart';

class ExpandableDashboardItem extends StatelessWidget {
  const ExpandableDashboardItem(
      {super.key, required this.title, required this.children});

  final Widget title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      // tilePadding: EdgeInsets.all(10),
      // trailing: const Icon(Icons.arrow_drop_down),
      backgroundColor:
          Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.3),
      collapsedBackgroundColor:
          Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.3),
      textColor: Theme.of(context).textTheme.bodyLarge!.color,
      iconColor: Theme.of(context).textTheme.bodyLarge!.color,
      collapsedTextColor: Theme.of(context).textTheme.bodyLarge!.color,
      collapsedIconColor: Theme.of(context).textTheme.bodyLarge!.color,
      collapsedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: SizedBox(
        height: 90,
        child: title,
      ),
      children: children,
    );
  }
}
