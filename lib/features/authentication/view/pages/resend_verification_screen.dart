import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tessera/constants/constants.dart';
import 'package:tessera/features/authentication/cubit/email_auth_cubit.dart';
import 'package:tessera/constants/app_colors.dart';

// ignore: camel_case_types
class resendVerification extends StatelessWidget {
  resendVerification({super.key});
  final formkey = GlobalKey<FormState>();
  String _newPassword='';

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
                    _newPassword=value!;
                    if (_newPassword.trim().isEmpty) {
                      return 'password is required';
                    }
                    if (_newPassword.length < 8) {
                      return 'password must be 8 char at least';
                    }
                  },
                ),
                Container(
                  padding: EdgeInsets.all(kPagePadding),
                  child: ElevatedButton(
                    onPressed: () {
                      if (formkey.currentState!.validate()) {
                        //context.read<EmailAuthCubit>().signUp('$_firstName $_lastName', _password);
                        Navigator.pushNamed(context, '/third');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.buttonColor, // Background Color),
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
