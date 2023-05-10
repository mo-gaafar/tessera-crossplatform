import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tessera/core/widgets/app_scaffold.dart';
import 'package:tessera/constants/constants.dart';
import 'package:email_validator/email_validator.dart';
import 'package:tessera/features/organizers_view/atendee_management/cubit/atendeeManagement_cubit.dart';
import 'package:tessera/features/authentication/view/widgets/email_button.dart';
import 'package:tessera/constants/app_colors.dart';

class AddAtendeeDetails extends StatelessWidget {
  final formkey = GlobalKey<FormState>();
  String inputEmail = '';
  String _firstName = '';
  String _lastName = '';

  AddAtendeeDetails({super.key});
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        title: const Text(
          "Add Atendee Details",
          style: TextStyle(
              fontFamily: 'NeuePlak',
              fontSize: 25,
              fontWeight: FontWeight.bold),
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
                  const SizedBox(height: 30),
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
              child: EmailButton(
                buttonText: 'Register',
                colourBackground: AppColors.primary,
                colourText: Colors.white,
                onTap: () async {
                  if (formkey.currentState!.validate()) {
                    context
                        .read<AtendeeManagementCubit>()
                        .atendeeModel
                        .atendeeFirstName = _firstName;
                    context
                        .read<AtendeeManagementCubit>()
                        .atendeeModel
                        .atendeeLastName = _lastName;
                    context
                        .read<AtendeeManagementCubit>()
                        .atendeeModel
                        .atendeeEmail = inputEmail;
                    Navigator.pushNamed(
                        context, '/atendeemanagementprocessingscreen');
                  }
                },
              ),
            ),
            //
          ],
        ),
      ),
    );
  }
}
