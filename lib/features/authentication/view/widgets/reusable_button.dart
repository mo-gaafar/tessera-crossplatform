import 'package:flutter/material.dart';
import 'package:tessera/constants/app_colors.dart';

class ContinueButton extends StatelessWidget {
  const ContinueButton({
    Key? key,
    required this.image,
    required this.buttonText,
    this.onTap,
  }) : super(key: key);
  final String image;
  final String buttonText;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
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
      onPressed: onTap,
      child: SizedBox(
        height: 50.0,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(image),
              radius: 15,
              backgroundColor: Colors.transparent,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              buttonText,
              style: TextStyle(
                  fontFamily: 'NeuePlak',
                  color: Theme.of(context).textTheme.bodyLarge!.color,
                  fontSize: 17),
            )
          ],
        ),
      ),
    );
  }
}
