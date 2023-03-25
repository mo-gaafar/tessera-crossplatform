import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tessera/constants/app_colors.dart';
import 'package:tessera/features/authentication/view/widgets/reusable_button.dart';
import 'package:tessera/features/authentication/view/widgets/email_button.dart';
import '../../../../core/services/authentication/facebook_authentication.dart';
import '../../../../core/services/authentication/google_authentication.dart';
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
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
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
                  Column(
                    children: [
                      EmailButton(
                        colourBackground: AppColors.primary,
                        buttonText: 'Continue with Email Address',
                        colourText: Colors.white,
                        onTap: () => Navigator.of(context).pushReplacementNamed('/login_signup')
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      ContinueButton(
                          image: 'assets/images/facebook.png',
                          buttonText: 'Continue with Facebook',
                          onTap: () async {


                          await context.read<AuthCubit>().signIn(FacebookAuthService());

                          if (context.read<AuthCubit>().state is SignedIn) {
                            Navigator.of(context).pushReplacementNamed('/third');
                          }
                          
                        }),
                      const SizedBox(
                        height: 15.0,
                      ),
                      ContinueButton(
                        image: 'assets/images/Google.png',
                        buttonText: 'Continue with Google',
                        onTap: () async {
                          await context
                              .read<AuthCubit>()
                              .signIn(GoogleAuthService());

                          if (context.read<AuthCubit>().state is SignedIn) {
                            Navigator.of(context)
                                .pushReplacementNamed('/third');
                          } else if (context.read<AuthCubit>().state is Error) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                duration: Duration(seconds: 2),
                                content: Text(
                                    'Error retrieving data. Please try again.'),
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
              if (context.watch<AuthCubit>().state is Loading)
                const CircularProgressIndicator.adaptive(),
            ],
          ),
        ),
      ),
    );
  }
}
