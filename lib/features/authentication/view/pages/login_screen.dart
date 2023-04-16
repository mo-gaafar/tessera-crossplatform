// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tessera/constants/app_colors.dart';
import 'package:tessera/constants/constants.dart';
import 'package:tessera/core/services/authentication/email_authentication.dart';
import 'package:tessera/core/services/location/location_service.dart';
import 'package:tessera/core/widgets/app_scaffold.dart';
import 'package:tessera/features/authentication/cubit/auth_cubit.dart';
import 'package:tessera/core/services/validation/form_validator.dart';
import 'package:tessera/features/authentication/view/widgets/email_button.dart';

/// Login page requesting the user's password.
class LogIn extends StatelessWidget {
  LogIn({super.key});

  final formkey = GlobalKey<FormState>();
  String password = '';
  final FormValidator formValidator = FormValidator();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AppScaffold(
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
                      child: Text(
                        context.read<AuthCubit>().currentUser.email,
                        style: const TextStyle(fontSize: 18),
                      ),
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
                          labelStyle: TextStyle(fontSize: 18),
                          hintText: 'Enter password',
                        ),
                        onChanged: (value) => password = value,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                          horizontal: kPagePadding, vertical: kPagePadding),
                      child: EmailButton(
                        buttonText: 'Log in',
                        colourBackground: AppColors.primary,
                        colourText: Colors.white,
                        onTap: () async {
                          if (formkey.currentState!.validate()) {
                            //* Attempt email sign in
                            await context.read<AuthCubit>().signIn(
                                  EmailAuthService.withData(
                                      email: context
                                          .read<AuthCubit>()
                                          .currentUser
                                          .email,
                                      password: password),
                                  LocationService(),
                                );

                            if (context.read<AuthCubit>().state is SignedIn) {
                              Navigator.of(context)
                                  .pushReplacementNamed('/third');
                            }
                          }
                        },
                      ),
                    ),
                    GestureDetector(
                      child: const Text(
                        'I forgot my password',
                        style: TextStyle(color: Colors.blue),
                      ),
                      onTap: () async {
                        await context.read<AuthCubit>().forgotPassword();

                        if (context.read<AuthCubit>().state
                            is OperationSuccess) {
                          Navigator.pushNamed(context, '/updatePassword');
                        }
                      },
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
