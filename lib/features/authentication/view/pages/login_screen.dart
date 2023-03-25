// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tessera/constants/app_colors.dart';
import 'package:tessera/constants/constants.dart';
import 'package:tessera/constants/enums.dart';
import 'package:tessera/core/services/authentication/email_authentication.dart';
import 'package:tessera/features/authentication/cubit/auth_cubit.dart';
import 'package:tessera/features/authentication/cubit/email_auth_cubit.dart';
import 'package:tessera/core/services/validation/form_validator.dart';
import 'package:tessera/features/authentication/data/auth_repository.dart';
import 'package:tessera/features/authentication/data/user_model.dart';

/// Login page requesting the user's password.
class LogIn extends StatelessWidget {
  LogIn({super.key});

  final formkey = GlobalKey<FormState>();
  String password = '';
  final FormValidator formValidator = FormValidator();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Log In",
            style: TextStyle(fontSize: 25),
          ),
        ),
        body: Center(
          child: Form(
            key: formkey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: CircleAvatar(
                    backgroundColor: Colors.grey.shade300,
                    radius: 30,
                    child: const Icon(
                      Icons.account_circle_outlined,
                      color: Colors.grey,
                      size: 50,
                    ),
                  ),
                ),
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: kPagePadding),
                      child: Text(context.read<AuthCubit>().user.email),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: GestureDetector(
                        child: const Text(
                          'Change',
                          style: TextStyle(color: Colors.blue),
                        ),
                        onTap: () => Navigator.pop(context),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: kPagePadding),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.cyan),
                          ),
                          labelText: 'Password*',
                          hintText: 'Enter password',
                        ),
                        validator: (value) {
                          password = value!;
                          return formValidator.passowrdValidty(password);
                        },
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                          horizontal: kPagePadding, vertical: kPagePadding),
                      child: ElevatedButton(
                        onPressed: () async {
                          if (formkey.currentState!.validate()) {
                            await context.read<AuthCubit>().signIn(
                                  EmailAuthService(
                                    UserModel(
                                        email: context
                                            .read<AuthCubit>()
                                            .user
                                            .email,
                                        password: password),
                                  ),
                                );

                            if (context.read<AuthCubit>().state is SignedIn) {
                              Navigator.of(context)
                                  .pushReplacementNamed('/third');
                            }
                            // UserState userState = await context
                            //     .read<EmailAuthCubit>()
                            //     .login(
                            //         context
                            //             .read<EmailAuthCubit>()
                            //             .state
                            //             .userData
                            //             .email,
                            //         password);
                            // if (userState == UserState.validLogin) {
                            //   Navigator.pushNamed(context, '/third');
                            // } else if (userState == UserState.inValidLogin) {
                            //   ScaffoldMessenger.of(context).showSnackBar(
                            //       const SnackBar(
                            //           content:
                            //               Text('Invalid Email or Password'),
                            //           duration: Duration(milliseconds: 300)));
                            // } else {
                            //   ScaffoldMessenger.of(context).showSnackBar(
                            //       const SnackBar(
                            //           content: Text('Unverified Email'),
                            //           duration: Duration(milliseconds: 300)));
                            // }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              AppColors.buttonColor, // Background Color),
                        ),
                        child: const Text(
                          "Log in",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                    GestureDetector(
                        child: const Text(
                          'I forgot my password',
                          style: TextStyle(color: Colors.blue),
                        ),
                        // ignore: avoid_print
                        onTap: () async {
                          final response =
                              await AuthRepository.sendForgotPasswordEmail(
                                  context.read<AuthCubit>().user.email);

                          if (response['success'] == true) {
                            Navigator.pushNamed(context, '/updatePassword');
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(response['message']),
                              ),
                            );
                          }
                          // if (await context
                          //     .read<EmailAuthCubit>()
                          //     .forgetPassword(context
                          //         .read<EmailAuthCubit>()
                          //         .state
                          //         .userData
                          //         .email)) {
                          //   Navigator.pushNamed(context, '/updatePassword');
                          // }
                        }),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
