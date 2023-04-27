import 'package:flutter/material.dart';
import 'package:tessera/constants/app_colors.dart';

class MyEditabelText extends StatelessWidget {
  String title;
  TextStyle textStyle;
  MyEditabelText({
    required this.title,
    required this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: EditableText(
          controller: TextEditingController(text: title),
          focusNode: FocusNode(),
          style: textStyle,
          cursorColor: Colors.blue,
          backgroundCursorColor: AppColors.lightBackground),
    );
  }
}
