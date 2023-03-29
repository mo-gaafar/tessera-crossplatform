import 'package:flutter/material.dart';
import 'package:tessera/constants/app_colors.dart';

class EmailButton extends StatelessWidget {
  const EmailButton({
    Key? key,
    required this.buttonText,
    required this.colourBackground,
    required this.colourText,
    this.onTap,
  }) : super(key: key);

  final String buttonText;
  final Color colourBackground;
  final Color colourText;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.0,
      width: double.infinity,
      child: TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(colourBackground),
            overlayColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.hovered)) {
                  return AppColors.textOnLight.withOpacity(0.04);
                }
                if (states.contains(MaterialState.focused) ||
                    states.contains(MaterialState.pressed)) {
                  return AppColors.textOnLight.withOpacity(0.12);
                }
                return null; // Defer to the widget's default.
              },
            ),
          ),
          //style: ButtonStyle(
          //overlayColor: MaterialStateProperty.resolveWith(getColor)),
          onPressed: () {
            debugPrint('Received click');
            onTap;
          },
          child: Text(
            buttonText,
            style: TextStyle(
                fontFamily: 'NeuePlak',
                color: colourText,
                fontSize: 15,
                fontWeight: FontWeight.w100),
          )),
    );
  }
}
