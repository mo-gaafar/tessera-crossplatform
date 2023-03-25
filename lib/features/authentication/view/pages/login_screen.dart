import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tessera/constants/app_colors.dart';
import 'package:tessera/constants/constants.dart';
import 'package:tessera/constants/enums.dart';
import 'package:tessera/features/authentication/cubit/email_auth_cubit.dart';
import 'package:tessera/core/services/validation/form_validator.dart';

class LogIn extends StatelessWidget {
  LogIn({super.key});

  final formkey = GlobalKey<FormState>();
  String password = '';
  FormValidator formValidator = FormValidator();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Log in",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: Center(
          child: Form(
            key: formkey,
            child: Column(
              // ignore: prefer_const_literals_to_create_immutables
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
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: kPagePadding),
                      child: Text(
                          context.read<EmailAuthCubit>().state.userData.email),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: GestureDetector(
                        child: const Text(
                          'Change',
                          style: TextStyle(color: Colors.blue),
                        ),
                        // ignore: avoid_print
                        onTap: () =>
                            Navigator.pushNamed(context, '/login_signup'),
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
                            UserState userState = await context
                                .read<EmailAuthCubit>()
                                .login(
                                    context
                                        .read<EmailAuthCubit>()
                                        .state
                                        .userData
                                        .email,
                                    password);
                            if (userState == UserState.validLogin) {
                              // ignore: use_build_context_synchronously
                              Navigator.pushNamed(context, '/third');
                            } else if (userState == UserState.inValidLogin) {
                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text('Invalid Email or Password'),
                                      duration: Duration(milliseconds: 300)));
                            } else {
                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Unverified Email'),
                                      duration: Duration(milliseconds: 300)));
                            }
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
                    Container(
                      child: GestureDetector(
                          child: const Text(
                            'I forgot my password',
                            style: TextStyle(color: Colors.blue),
                          ),
                          // ignore: avoid_print
                          onTap: () async {
                            if (await context
                                .read<EmailAuthCubit>()
                                .forgetPassword(context
                                    .read<EmailAuthCubit>()
                                    .state
                                    .userData
                                    .email)) {
                              Navigator.pushNamed(context, '/updatePassword');
                            }
                          }),
                    ),
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


        // body: Container(
        //   padding: EdgeInsets.all(kPagePadding),
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.center,
        //     children: [Container(
        //       padding: EdgeInsets.only(top: 20),
        //       child: Column(
        //         // ignore: prefer_const_literals_to_create_immutables
        //         children: [
        //           CircleAvatar(
        //             backgroundColor: Colors.grey.shade300,
        //             child: const Icon(
        //               Icons.account_circle_outlined,
        //               color: Colors.grey,
        //             ),
        //           ),
        //         ],
        //       ),
        //     )
        //   ]),
        // ),