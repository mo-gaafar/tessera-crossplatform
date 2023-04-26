// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tessera/constants/app_colors.dart';
import 'package:tessera/core/services/location/location_service.dart';
import 'package:tessera/core/widgets/app_scaffold.dart';
import 'package:tessera/features/authentication/view/widgets/reusable_button.dart';
import 'package:tessera/features/authentication/view/widgets/email_button.dart';
import '../../../../core/services/authentication/facebook_authentication.dart';
import '../../../../core/services/authentication/google_authentication.dart';
import '../../cubit/auth_cubit.dart';

/// Screen that allows the user to choose between logging in / signing up with email, Google, or Facebook.
class LoginOptionsScreen extends StatelessWidget {
  const LoginOptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Hero(
                      tag: 'logo',
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(5, 20, 5, 40),
                        child: Image.asset(
                          'assets/images/LogoFullTextLarge.png',
                          // height: 120,
                        ),
                      ),
                    ),
                    // const SizedBox(height: 30),
                    const Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Text(
                        'Let\'s get started!',
                        style: TextStyle(
                            fontSize: 35,
                            fontFamily: 'NeuePlak',
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Text(
                        'Sign up or log in to see what\'s happening near you.',
                        style: TextStyle(
                            color: Theme.of(context)
                                .colorScheme
                                .onSecondaryContainer,
                            fontSize: 18,
                            fontFamily: 'NeuePlak'),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    EmailButton(
                      colourBackground: AppColors.primary,
                      buttonText: 'Continue with Email Address',
                      colourText: Colors.white,
                      onTap: () =>
                          Navigator.of(context).pushNamed('/login_signup'),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ContinueButton(
                        image: 'assets/images/facebook.png',
                        buttonText: 'Continue with Facebook',
                        onTap: () async {
                          await context
                              .read<AuthCubit>()
                              .signIn(FacebookAuthService(), LocationService());

                          if (context.read<AuthCubit>().state is SignedIn) {
                            Navigator.of(context)
                                .pushReplacementNamed('/landingPage');
                          }
                        }),
                    const SizedBox(
                      height: 15.0,
                    ),
                    BlocListener<AuthCubit, AuthState>(
                      listenWhen: (previous, current) => current is SignedIn,
                      listener: (context, state) {
                        Navigator.of(context)
                            .pushReplacementNamed('/landingPage');
                      },
                      child: ContinueButton(
                        image: 'assets/images/Google.png',
                        buttonText: 'Continue with Google',
                        onTap: () async {
                          await context
                              .read<AuthCubit>()
                              .signIn(GoogleAuthService(), LocationService());
                        },
                      ),
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
    );
  }
}
