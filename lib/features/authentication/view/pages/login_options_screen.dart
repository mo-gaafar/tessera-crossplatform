import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tessera/constants/app_colors.dart';
import 'package:tessera/core/theme/cubit/theme_cubit.dart';
import 'package:tessera/features/authentication/view/widgets/reusable_button.dart';
import 'package:tessera/features/authentication/view/widgets/email_button.dart';

class LoginOptionsScreen extends StatelessWidget {
  const LoginOptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              SizedBox(
                height: 70,
              ),
              Text(
                'Let\'s get started',
                style: TextStyle(
                    color: AppColors.textOnLight,
                    fontSize: 40.0,
                    fontFamily: 'NeuePlak'),
              ),
              Text(
                'sign up or log in to see what\'s',
                style: TextStyle(
                    color: AppColors.secondaryTextOnLight,
                    fontSize: 20.0,
                    fontFamily: 'NeuePlak'),
                textAlign: TextAlign.left,
              ),
              Text(
                'happening near you',
                style: TextStyle(
                    color: AppColors.secondaryTextOnLight,
                    fontSize: 20.0,
                    fontFamily: 'NeuePlak'),
                textAlign: TextAlign.left,
              ),
              SizedBox(
                height: 150.0,
              ),
              EmailButton(
                colourBackground: AppColors.primary,
                buttonText: 'Continue with Email Address',
                colourText: Colors.white,
              ),
              SizedBox(
                height: 15,
              ),
              ContinueButton(
                  image: 'assets/images/facebook.png',
                  buttonText: 'Continue with Facebook'),
              SizedBox(
                height: 15.0,
              ),
              ContinueButton(
                  image: 'assets/images/Google.png',
                  buttonText: 'Continue with Google'),
              SizedBox(
                height: 15.0,
              ),
              EmailButton(
                  colourBackground: Colors.white,
                  buttonText:
                      'I bought tickets, but i don\'t have an account. ',
                  colourText: AppColors.secondary),
            ],
          ),
        ),
      ),
    );
  }
}
