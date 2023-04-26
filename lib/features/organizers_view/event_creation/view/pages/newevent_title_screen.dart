import 'package:flutter/material.dart';
import 'package:tessera/constants/app_colors.dart';

class NewEventtitle extends StatelessWidget {
  const NewEventtitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              const Text(
                'Give your event a title.',
                style: TextStyle(
                    color: AppColors.textOnLight,
                    fontSize: 40.0,
                    fontFamily: 'NeuePlak'),
              ),
              const TextField(
                decoration: InputDecoration(
                  hintText: "Enter a short distinct name",
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/neweventdescription');
        },
        backgroundColor: Colors.orange,
        child: const Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}
