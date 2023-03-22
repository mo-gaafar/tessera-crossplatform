import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tessera/constants/constants.dart';

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
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              // ignore: prefer_interpolation_to_compose_strings
              child: Text('We sent a link to ' + 'USER EMAIL'+ ' to update your password.'),
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
                onTap: () => print('resend'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
