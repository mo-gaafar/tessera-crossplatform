import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:tessera/features/authentication/view/widgets/email_button.dart';
import 'package:tessera/constants/app_colors.dart';

class AtendeeAddedSuccessfully extends StatefulWidget {
  const AtendeeAddedSuccessfully({super.key});

  @override
  State<AtendeeAddedSuccessfully> createState() => _AtendeeAddedSuccessfullyState();
}

class _AtendeeAddedSuccessfullyState extends State<AtendeeAddedSuccessfully> {
  bool? checkBox = false;
  final formkey = GlobalKey<FormState>();
  String inputEmail = '';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Tickets added Successfully'),
              Icon(
                Icons.done_all,
                size: 100,
                color: Colors.green,
              ),
              const Spacer(),
              Container(
                child: EmailButton(
                  buttonText: 'New Sale',
                  colourBackground: AppColors.primary,
                  colourText: Colors.white,
                  onTap: () {
                    Navigator.pushNamed(
                        context, '/atendeemanagementhomescreen');
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
