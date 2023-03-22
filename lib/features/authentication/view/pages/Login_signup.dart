import 'package:flutter/material.dart';
import 'dart:math';
import 'package:provider/provider.dart';
import 'package:tessera/constants/constants.dart';
import 'package:tessera/constants/app_colors.dart';
import 'package:email_validator/email_validator.dart';
import 'package:tessera/features/authentication/data/user_model.dart';
import 'package:tessera/core/services/authentication/email_authentication.dart';

class Login_signup extends StatelessWidget {
  final formkey = GlobalKey<FormState>();
  String inputEmail='';
  EmailAuthService user=EmailAuthService();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Log in or Sign up",
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
        body: Form(
          key: formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(kPagePadding),
                // ignore: prefer_const_constructors
                child: Column(
                  // ignore: prefer_const_literals_to_create_immutables
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const Text(
                      'Email',
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        enabledBorder: UnderlineInputBorder(),
                        hintText: 'Enter email address',
                      ),
                      validator: (value) {
                        inputEmail=value!;
                        if (inputEmail.trim().isEmpty) {
                          return 'email is required';
                        }
                        if (!EmailValidator.validate(inputEmail)) {
                          return 'this is not a valid email';
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
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: CircleAvatar(
                            backgroundColor: Colors.grey.shade300,
                            child: Transform.rotate(
                              angle: 90 * pi / 180,
                              child: const Icon(
                                Icons.confirmation_num_outlined,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        const Expanded(
                          child: Text(
                              "Sign in with the same email addrerss you used to get your tickets."),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 10),
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (formkey.currentState!.validate()) {
                            if (user.setEmail(inputEmail))
                            {
                             Navigator.pushNamed(context, '/login');
                            }
                            else{
                              Navigator.pushNamed(context, '/signup');
                            }

                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              AppColors.buttonColor, // Background Color),
                        ),
                        child: const Text(
                          "Next",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Container(
              //   padding: const EdgeInsets.all(20.0),
              //   // ignore: prefer_const_constructors
              //   child: Column(
              //     // ignore: prefer_const_literals_to_create_immutables
              //     crossAxisAlignment: CrossAxisAlignment.end,
              //     // ignore: prefer_const_literals_to_create_immutables
              //     children: [
              //       MaterialButton(
              //         onPressed: () => {},
              //         child: const Text('register'),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

// class Log_in_sign_up extends StatefulWidget {
//   const Log_in_sign_up({super.key});

//   @override
//   State<Log_in_sign_up> createState() => _Log_in_sign_upState();
// }

// class _Log_in_sign_upState extends State<Log_in_sign_up> {
//   double kPagePadding = 20;
//   login_signup_validation validationObj = login_signup_validation();
//   bool emailValidFlag = false;
//   String userEmail='';

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text(
//             "Log in or Sign up",
//             style: TextStyle(fontWeight: FontWeight.bold),
//           ),
//           actions: [
//             IconButton(
//               icon: const Icon(
//                 Icons.close,
//                 color: Colors.black,
//               ),
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//             )
//           ],
//         ),
//         body: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Container(
//               padding: EdgeInsets.all(kPagePadding),
//               // ignore: prefer_const_constructors
//               child: Column(
//                 // ignore: prefer_const_literals_to_create_immutables
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 // ignore: prefer_const_literals_to_create_immutables
//                 children: [
//                   const Text(
//                     'Email',
//                     style: TextStyle(color: Colors.cyan),
//                   ),
//                   TextField(
//                     decoration: const InputDecoration(
//                       enabledBorder: UnderlineInputBorder(
//                         borderSide: BorderSide(color: Colors.cyan),
//                       ),
//                       hintText: 'Enter email address',
//                     ),
//                     onChanged: (value) {
//                       setState(() {
//                         userEmail=value;
//                         emailValidFlag = validationObj.checkEmail(userEmail);
//                       });
//                     },
//                   ),
//                 ],
//               ),
//             ),
//             const Spacer(),
//             Container(
//               padding: EdgeInsets.all(kPagePadding),
//               // ignore: prefer_const_constructors
//               child: Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(right: 10),
//                         child: CircleAvatar(
//                           backgroundColor: Colors.grey.shade300,
//                           child: Transform.rotate(
//                             angle: 90 * pi / 180,
//                             child: const Icon(
//                               Icons.confirmation_num_outlined,
//                               color: Colors.black,
//                             ),
//                           ),
//                         ),
//                       ),
//                       const Text("add same email as signed up"),
//                     ],
//                   ),
//                   Container(
//                     padding: const EdgeInsets.only(top: 10),
//                     width: double.infinity,
//                     child: ElevatedButton(
//                       onPressed: emailValidFlag
//                           ? () {
//                               Navigator.pushNamed(context, '/signUp');
//                             }
//                           : null,
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.orange, // Background Color),
//                       ),
//                       child: const Text(
//                         "Next",
//                         style: TextStyle(color: Colors.black),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             // Container(
//             //   padding: const EdgeInsets.all(20.0),
//             //   // ignore: prefer_const_constructors
//             //   child: Column(
//             //     // ignore: prefer_const_literals_to_create_immutables
//             //     crossAxisAlignment: CrossAxisAlignment.end,
//             //     // ignore: prefer_const_literals_to_create_immutables
//             //     children: [
//             //       MaterialButton(
//             //         onPressed: () => {},
//             //         child: const Text('register'),
//             //       ),
//             //     ],
//             //   ),
//             // ),
//           ],
//         ),
//       ),
//     );
//   }
// }
