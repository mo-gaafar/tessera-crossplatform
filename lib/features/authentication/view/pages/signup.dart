import 'package:flutter/material.dart';
import 'package:tessera/constants/app_colors.dart';
import 'package:tessera/core/services/authentication/email_authentication.dart';

class SignUp extends StatelessWidget {
  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double kPagePadding = 20;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Sign up",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(kPagePadding),
          //       // ignore: prefer_const_constructors
          child: Form(
            key: formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Email',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 2,),
                    Text(
                      'Provider.of<userData>(context, listen: true).email',
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 4,),
                    const Divider(
                      color: Colors.grey,
                      height: 2,
                      thickness: 1,
                    ),
                  ],
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Confirm Email",
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    hintText: 'Confirm Email',
                  ),
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return 'please re enter your email to confirm it';
                    }
                    if (value !=
                        'Provider.of<userData>(context, listen: false).email') {
                      return 'email must be the same';
                    }
                  },
                ),
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
                          if (value!.trim().isEmpty) {
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
                          if (value!.trim().isEmpty) {
                            return 'surname is required';
                          }
                        },
                      ),
                    ),
                  ],
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: "Password",
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      hintText: 'Passowrd',
                      helperText: 'Password must have at least 8 characters.'),
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return 'password is required';
                    }
                    if (value.length < 8) {
                      return 'password must be 8 char at least';
                    }
                  },
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.only(top: 10),
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (formkey.currentState!.validate()) {
                        Navigator.pushNamed(context, '/logIn');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.buttonColor, // Background Color),
                    ),
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


        // body: Column(
        //   children: [
        //     Container(
        //       padding: EdgeInsets.all(kPagePadding),
        //       // ignore: prefer_const_constructors
        //       child: Column(
        //         // ignore: prefer_const_literals_to_create_immutables
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         // ignore: prefer_const_literals_to_create_immutables
        //         children: [
        //           const Text(
        //             'Email',
        //             style: TextStyle(color: Colors.cyan),
        //           ),
        //           const TextField(
        //             decoration: InputDecoration(
        //               enabledBorder: UnderlineInputBorder(
        //                 borderSide: BorderSide(color: Colors.cyan),
        //               ),
        //               hintText: 'omaressam@gmail.com',

        //             ),
        //             onChanged: null,
        //             enabled: false,
        //           ),
        //         ],
        //       ),
        //     ),
        //   ],
        // ),