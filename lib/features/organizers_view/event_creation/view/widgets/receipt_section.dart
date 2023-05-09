import 'package:flutter/material.dart';
import 'package:tessera/constants/app_colors.dart';

class ReceiptSection extends StatefulWidget {
  Widget sectionIcon;
  Widget sectionChild;
  ReceiptSection({required this.sectionChild, required this.sectionIcon});
  @override
  State<ReceiptSection> createState() => _ReceiptSectionState(
      sectionChild: sectionChild, sectionIcon: sectionIcon);
}

class _ReceiptSectionState extends State<ReceiptSection> {
  Widget sectionIcon;
  Widget sectionChild;
  _ReceiptSectionState({required this.sectionChild, required this.sectionIcon});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          Expanded(flex: 1, child: sectionIcon),
          Expanded(flex: 4, child: sectionChild),
        ],
      ),
    );
  }
}
