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
      onPressed: () {
        debugPrint('Received click');
      },
      child: SizedBox(
        height: 50.0,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(image),
              radius: 10,
              backgroundColor: Colors.white,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              buttonText,
              style: const TextStyle(
                  fontFamily: 'NeuePlak', color: Colors.blueGrey, fontSize: 15),
            )
          ],
        ),
      ),
    );
  }
}
