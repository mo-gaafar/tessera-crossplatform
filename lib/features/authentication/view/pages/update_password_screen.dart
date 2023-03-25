// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tessera/constants/app_colors.dart';
import 'package:tessera/features/authentication/cubit/email_auth_cubit.dart';

// ignore: camel_case_types
class updatePassword extends StatelessWidget {
  const updatePassword({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Update your password",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              color: Colors.yellow,
              width: double.infinity,
              child: const Text(
                '🕒  For your security, this link expires in 2 hours.',
                textAlign: TextAlign.center,
              ),
            ),
            const Spacer(
              flex: 1,
            ),
            CircleAvatar(
              backgroundColor: Colors.grey.shade300,
              radius: 30,
              child: const Icon(
                Icons.lock_outlined,
                color: Colors.grey,
                size: 30,
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                'Check your email to update your password.',
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
                'We sent a link to ${context.read<EmailAuthCubit>().state.userData.email} to update your password.',
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
