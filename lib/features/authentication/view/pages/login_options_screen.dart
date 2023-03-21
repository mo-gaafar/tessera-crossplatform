import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tessera/constants/app_colors.dart';
import 'package:tessera/features/authentication/view/widgets/reusable_button.dart';
import 'package:tessera/features/authentication/view/widgets/email_button.dart';

import '../../cubit/auth_cubit.dart';

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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // const SizedBox(
              //   height: 70,
              // ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Let\'s get started',
                    style: TextStyle(
                        color: AppColors.textOnLight,
                        fontSize: 40.0,
                        fontFamily: 'NeuePlak'),
                  ),
                  Text(
                    'Sign up or log in to see what\'s happening near you',
                    style: TextStyle(
                        color: AppColors.secondaryTextOnLight,
                        fontSize: 20.0,
                        fontFamily: 'NeuePlak'),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
              // const SizedBox(
              //   height: 150.0,
              // ),
              Column(
                children: [
                  const EmailButton(
                    colourBackground: AppColors.primary,
                    buttonText: 'Continue with Email Address',
                    colourText: Colors.white,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const ContinueButton(
                      image: 'assets/images/facebook.png',
                      buttonText: 'Continue with Facebook'),
                  const SizedBox(
                    height: 15.0,
                  ),
                  ContinueButton(
                    image: 'assets/images/Google.png',
                    buttonText: 'Continue with Google',
                    onTap: () async {
                      await context.read<AuthCubit>().signInGoogle();
                    },
                  ),
                ],
              ),
              // const SizedBox(
              //   height: 15.0,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
