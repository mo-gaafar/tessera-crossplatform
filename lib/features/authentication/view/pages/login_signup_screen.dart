// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math';
import 'package:tessera/constants/constants.dart';
import 'package:tessera/constants/app_colors.dart';
import 'package:email_validator/email_validator.dart';
import 'package:tessera/constants/enums.dart';
import 'package:tessera/core/widgets/app_scaffold.dart';
import 'package:tessera/features/authentication/cubit/auth_cubit.dart';
import 'package:tessera/features/authentication/view/widgets/email_button.dart';

/// Screen redirecting to login or signup depending on the user's input email.
class LoginSignup extends StatelessWidget {
  final formkey = GlobalKey<FormState>();
  String inputEmail = '';

  LoginSignup({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AppScaffold(
        appBar: AppBar(
          title: const Text(
            "Log In or Sign Up",
          ),
        ),
        body: Form(
          key: formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(kPagePadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Email',
                      style: TextStyle(fontSize: 20),
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        enabledBorder: UnderlineInputBorder(),
                        hintText: 'Enter email address',
                      ),
                      validator: (value) {
                        inputEmail = value!;
                        if (inputEmail.trim().isEmpty) {
                          return 'Email is required.';
                        }
                        if (!EmailValidator.validate(inputEmail)) {
                          return 'This is not a valid email.';
                        }
                      },
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Container(
                padding: EdgeInsets.all(kPagePadding),
                // ignore: prefer_const_constructors
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: CircleAvatar(
                            backgroundColor: Colors.grey.shade300,
                            child: Transform.rotate(
                              angle: 90 * pi / 180,
                              child: const Icon(
                                Icons.confirmation_num_outlined,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        const Expanded(
                          child: Text(
                              "Sign in with the same email addrerss you used to get your tickets."),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    EmailButton(
                      buttonText: 'Next',
                      colourBackground: AppColors.primary,
                      colourText: Colors.white,
                      onTap: () async {
                        if (formkey.currentState!.validate()) {
                          final userStatus = await context
                              .read<AuthCubit>()
                              .checkIfUserExists(inputEmail);
                          if (userStatus == UserState.login) {
                            Navigator.pushNamed(context, '/login');
                          } else if (userStatus == UserState.signup) {
                            Navigator.pushNamed(context, '/signup');
                          }
                        }
                      },
                    ),
                  ],
                ),
              ),
              //
            ],
          ),
        ),
      ),
    );
  }
}
