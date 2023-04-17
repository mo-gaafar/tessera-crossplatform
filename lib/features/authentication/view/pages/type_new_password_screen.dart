// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tessera/constants/constants.dart';
import 'package:tessera/core/widgets/app_scaffold.dart';
import 'package:tessera/features/authentication/cubit/auth_cubit.dart';
import 'package:tessera/constants/app_colors.dart';
import 'package:tessera/core/services/validation/form_validator.dart';
import 'package:tessera/features/authentication/view/widgets/email_button.dart';

/// Reset password page requesting the user's new password.
class TypeNewPassword extends StatelessWidget {
  TypeNewPassword({super.key});
  final formkey = GlobalKey<FormState>();
  String _newPassword = '';
  FormValidator formValidator = FormValidator();
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        title: const Text(
          "Update your password",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
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
                child: EmailButton(
                  buttonText: 'Update password',
                  colourBackground: AppColors.primary,
                  colourText: Colors.white,
                  onTap: () async {
                    if (formkey.currentState!.validate()) {
                      await context
                          .read<AuthCubit>()
                          .resetPassword(_newPassword);

                      if (context.read<AuthCubit>().state is OperationSuccess) {
                        Navigator.pushReplacementNamed(
                            context, '/loginOptions');
                      }
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
