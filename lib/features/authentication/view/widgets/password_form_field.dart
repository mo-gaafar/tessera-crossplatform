import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tessera/constants/app_colors.dart';
import 'package:tessera/core/widgets/app_scaffold.dart';
import 'package:tessera/features/authentication/cubit/auth_cubit.dart';
import 'package:tessera/core/services/validation/form_validator.dart';
import 'package:tessera/features/authentication/view/widgets/email_button.dart';

class PasswordFormField extends StatefulWidget {
  const PasswordFormField({
    super.key,
    required this.formValidator,
  });
  final FormValidator formValidator;
  @override
  State<PasswordFormField> createState() =>
      _PasswordFormFieldState(formValidator: formValidator);
}

class _PasswordFormFieldState extends State<PasswordFormField> {
  final FormValidator formValidator;
  _PasswordFormFieldState({required this.formValidator});
  bool hidePassword = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        decoration: InputDecoration(
          labelText: "Password",
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          hintText: 'Password',
          suffixIcon: IconButton(
            icon: (hidePassword == true)
                ? Icon(Icons.visibility_off)
                : Icon(Icons.visibility),
            onPressed: () {
              setState(() {
                if (hidePassword == true) {
                  hidePassword = false;
                } else {
                  hidePassword = true;
                }
              });
            },
          ),
        ),
        validator: (value) {
          String password = value!;
          if (value == null){
            return 'Null Password';
          } else {
            context.read<AuthCubit>().currentUser.password = value;
            return formValidator.passowrdValidty(password);
          }
        },
        obscureText: hidePassword);
  }
}
