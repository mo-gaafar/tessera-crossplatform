// ignore_for_file: unnecessary_import

import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:tessera/constants/app_colors.dart';

class RoundedButton extends StatelessWidget {
  final Function()? onTap;
  final String buttonText;
  const RoundedButton({
    Key? key,
    required this.buttonText,
    this.onTap,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        //debugPrint('tags Clicked');
      },
      // ignore: sort_child_properties_last
      child: Text(
        buttonText,
        style:  const TextStyle(
            fontFamily: 'NeuePlak', color: AppColors.secondary, fontSize: 13),
      ),
      style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(), backgroundColor: Colors.white),
    )
    ;

  }
}
