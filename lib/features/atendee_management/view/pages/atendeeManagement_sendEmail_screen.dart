import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

class SendEmailToAtendee extends StatefulWidget {
  const SendEmailToAtendee({super.key});

  @override
  State<SendEmailToAtendee> createState() => _SendEmailToAtendeeState();
}

class _SendEmailToAtendeeState extends State<SendEmailToAtendee> {
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
              Text('Email'),
              Form(
                key: formkey,
                child: TextFormField(
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(Icons.send),
                      onPressed: () {
                        setState(() {});
                        if (formkey.currentState!.validate()) {
                          print(inputEmail);
                          print(checkBox);
                        }
                      },
                    ),
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
              ),
              CheckboxListTile(
                //checkbox positioned at left
                value: checkBox,
                controlAffinity: ListTileControlAffinity.platform,
                onChanged: (bool? value) {
                  setState(() {
                    checkBox = value;
                  });
                },
                title: Text("include tickts"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
