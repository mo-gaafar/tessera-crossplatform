import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tessera/constants/constants.dart';
import 'package:tessera/constants/enums.dart';
import 'package:tessera/features/authentication/cubit/email_auth_cubit.dart';
import 'package:tessera/constants/app_colors.dart';
import 'package:tessera/core/services/validation/form_validator.dart';

// ignore: camel_case_types
class typeNewPassword extends StatelessWidget {
  typeNewPassword({super.key});
  final formkey = GlobalKey<FormState>();
  String _newPassword = '';
    FormValidator formValidator=FormValidator();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Update your password",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.close,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
        body: Container(
          padding: EdgeInsets.all(kPagePadding),
          child: Form(
            key: formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: "New Password",
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      hintText: 'Passowrd',
                      helperText: 'Password must have at least 8 characters.'),
                  validator: (value) {
                    _newPassword = value!;
                    return formValidator.passowrdValidty(_newPassword);
                  },
                ),
                Container(
                  padding: EdgeInsets.all(kPagePadding),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (formkey.currentState!.validate()) {
                        if (await context.read<EmailAuthCubit>().resetPassword(
                                context
                                    .read<EmailAuthCubit>()
                                    .state
                                    .userData
                                    .email,
                                _newPassword) ==
                            true) {
                          Navigator.pushNamed(context, '/third');
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  'Something went wrong! try another password'),
                              duration: Duration(milliseconds: 300)));
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          AppColors.buttonColor, // Background Color),
                    ),
                    child: const Text(
                      "Update password",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
