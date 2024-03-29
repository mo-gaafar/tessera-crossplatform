// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tessera/constants/app_colors.dart';
import 'package:tessera/core/widgets/app_scaffold.dart';
import 'package:tessera/features/authentication/cubit/auth_cubit.dart';
import 'package:tessera/core/services/validation/form_validator.dart';
import 'package:tessera/features/authentication/view/widgets/email_button.dart';
import 'package:tessera/features/authentication/view/widgets/password_form_field.dart';

/// Sign up page requesting the user's first name, last name, and password.
class SignUp extends StatelessWidget {
  final formkey = GlobalKey<FormState>();
  String _firstName = '';
  String _lastName = '';
  FormValidator formValidator = FormValidator();

  SignUp({super.key});
  @override
  Widget build(BuildContext context) {
    double kPagePadding = 20;
    return AppScaffold(
      appBar: AppBar(
        title: const Text(
          "Sign up",
          style: TextStyle(
              fontFamily: 'NeuePlak',
              fontSize: 25,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(kPagePadding),
        child: Form(
          key: formkey,
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Email',
                        style: TextStyle(color: Colors.grey, fontSize: 20),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Text(
                        context.read<AuthCubit>().currentUser.email,
                        style: const TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      const Divider(
                        color: Colors.grey,
                        height: 2,
                        thickness: 1,
                      ),
                    ],
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: "Confirm Email",
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      hintText: 'Confirm Email',
                    ),
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return 'Please re enter your email to confirm it';
                      }
                      if (value !=
                          context.read<AuthCubit>().currentUser.email) {
                        return 'Email must be the same';
                      }
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: TextFormField(
                          decoration: const InputDecoration(
                            labelText: "First Name",
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            hintText: 'Enter First Name',
                          ),
                          validator: (value) {
                            _firstName = value!;
                            if (_firstName.trim().isEmpty) {
                              return 'First name is required';
                            }
                          },
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: TextFormField(
                          decoration: const InputDecoration(
                            labelText: "Surname",
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            hintText: 'Enter Surname',
                          ),
                          validator: (value) {
                            _lastName = value!;
                            if (_lastName.trim().isEmpty) {
                              return 'Surname is required';
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  PasswordFormField(formValidator: formValidator),
                ],
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.only(top: 10),
                width: double.infinity,
                child: EmailButton(
                  buttonText: 'Sign Up',
                  colourBackground: AppColors.primary,
                  colourText: Colors.white,
                  onTap: () async {
                    if (formkey.currentState!.validate()) {
                      // Attempt email sign up
                      String tempVarPassword =
                          context.read<AuthCubit>().currentUser.password!;
                      await context
                          .read<AuthCubit>()
                          .emailSignUp(_firstName, _lastName, tempVarPassword);

                      if (context.read<AuthCubit>().state is EmailSignedUp) {
                        Navigator.pushNamed(context, '/verification');
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
