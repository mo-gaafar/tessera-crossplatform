// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tessera/constants/app_colors.dart';
import 'package:tessera/features/authentication/cubit/email_auth_cubit.dart';

/// Screen notifying the user to check their email to verify their account.
class VerificationScreen extends StatelessWidget {
  const VerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
        ),
        body: Column(
          children: [
            const Spacer(
              flex: 1,
            ),
            const CircleAvatar(
              backgroundColor: Colors.white,
              radius: 70,
              child: Icon(
                Icons.check,
                color: Colors.green,
                size: 70,
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                'Check your email to verify your account.',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: AppColors.secondaryTextOnLight,
                    fontSize: 20.0,
                    fontFamily: 'NeuePlak',
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              // ignore: prefer_interpolation_to_compose_strings
              child: Text(
                'We sent a link to ${context.read<EmailAuthCubit>().state.userData.email} to verify your account.',
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: AppColors.secondaryTextOnLight,
                    fontSize: 20.0,
                    fontFamily: 'NeuePlak'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                child: const Text(
                  'Change email',
                  style: TextStyle(color: Colors.blue),
                ),
                // ignore: avoid_print
                onTap: () => Navigator.pushNamed(context, '/login_signup'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                child: const Text('Recieved Email'),
                // ignore: avoid_print
                onPressed: () => Navigator.pushNamed(context, '/login'),
              ),
            ),
            const Spacer(flex: 2),
            Padding(
              padding: const EdgeInsets.all(15),
              child: GestureDetector(
                  child: const Text(
                    'Resend verification email',
                    style: TextStyle(color: Colors.blue),
                  ),
                  // ignore: avoid_print
                  onTap: () async {
                    if (await context.read<EmailAuthCubit>().verifyEmail(
                        context.read<EmailAuthCubit>().state.userData.email)) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Email sent check you mailbox'),
                          duration: Duration(milliseconds: 300)));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text(
                              'Something wrong! This Email is not registerd'),
                          duration: Duration(milliseconds: 300)));
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
