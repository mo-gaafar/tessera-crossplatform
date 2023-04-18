// ignore_for_file: must_be_immutable
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tessera/features/events/cubit/event_book_cubit.dart';
import 'package:tessera/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:tessera/features/events/view/widgets/email_button.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:email_validator/email_validator.dart';
import 'package:tessera/core/services/validation/form_validator.dart';
import 'package:tessera/features/events/data/booking_data.dart';

class CheckOut extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final int _duration = 60; //1800;
  final List ticketTier;
  final bool charge;
  late String feesText; //money or free
  String inputEmailCheckOut = '';
  FormValidator formValidator = FormValidator();
  String firstCheckOut = '';
  String lastCheckOut = '';

  CheckOut({Key? key, required this.charge, required this.ticketTier})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.close)),
        elevation: 0,
        backgroundColor: AppColors.primary,
        title: Text(
          'Check Out Information',
          style: TextStyle(
              fontFamily: 'NeuePlak', color: Colors.white, fontSize: 25),
        ),
        //backgroundColor: AppColors.primary,
      ),
      bottomNavigationBar: BottomAppBar(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: CircularCountDownTimer(
                width: 60,
                height: 60,
                duration: _duration,
                fillColor: AppColors.secondary,
                ringColor: AppColors.primary,
                onComplete: () {
                  //back to event page
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    duration: Duration(seconds: 2),
                    content: Text('TIME OUT'),
                    shape: StadiumBorder(),
                    behavior: SnackBarBehavior.floating,
                  ));
                },
              ),
            ),
            Expanded(
                flex: 3,
                child: EmailButton(
                  buttonText: 'CheckOut',
                  colourBackground: AppColors.primary,
                  colourText: Colors.white,
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      ContactInformation info = ContactInformation(
                          firstName: firstCheckOut,
                          lastName: lastCheckOut,
                          email: inputEmailCheckOut);

                      BookingModel book = BookingModel(
                          contactInformation: info.toMap(),
                          ticketTierSelected: ticketTier);
                      // ignore: avoid_print
                      print(jsonEncode(book.toMap()));
                      bool output = await context
                          .read<EventBookCubit>()
                          .postBookingData(book.toMap());
                      if (output == true) {
                        Navigator.pushNamed(context, '/third');
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          duration: Duration(seconds: 2),
                          content: Text('Successfully booked'),
                          shape: StadiumBorder(),
                          behavior: SnackBarBehavior.floating,
                        ));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          duration: Duration(seconds: 2),
                          content: Text('Error in booking'),
                          shape: StadiumBorder(),
                          behavior: SnackBarBehavior.floating,
                        ));
                      }
                    }
                  },
                )),
          ],
        ),
      )),
      backgroundColor: Colors.white,
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.primary, width: 2),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        textAlign: TextAlign.center,
                        'Your Chosen tickets are' + ticketTier.toString(),
                        style: TextStyle(
                            fontFamily: 'NeuePlak',
                            color: AppColors.textOnLight,
                            fontSize: 30),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
          'Billing Basic Information', //APP BAR EVENT NAME
          style: TextStyle(
              fontFamily: 'NeuePlak', color: AppColors.textOnLight, fontSize: 29),
        ),
        
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter your first name',
                            helperText: 'Required'
                          ),
                          validator: (value) {
                            firstCheckOut = value!;
                            if (firstCheckOut == null ||
                                firstCheckOut.isEmpty) {
                              return 'Please enter your first name';
                            }
                            return formValidator.nameValidty(firstCheckOut);
                          },
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter your last name',
                            helperText: 'Required'
                          ),
                          validator: (value) {
                            lastCheckOut = value!;
                            if (lastCheckOut == null || lastCheckOut.isEmpty) {
                              return 'Please enter your last name';
                            }
                            return formValidator.nameValidty(lastCheckOut);
                          },
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter your Email address',
                      helperText: 'Required'
                    ),
                    validator: (value) {
                      inputEmailCheckOut = value!;
                      if (inputEmailCheckOut == null ||
                          inputEmailCheckOut.trim().isEmpty) {
                        return 'Email is required.';
                      }
                      if (!EmailValidator.validate(inputEmailCheckOut)) {
                        return 'This is not a valid email.';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Visibility(
                    visible: charge,
                    child: Column(
                      children: [
                        Text(
                          'pay with',
                          style: const TextStyle(
                              fontFamily: 'NeuePlak',
                              color: AppColors.textOnLight,
                              fontSize: 20),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter your card number',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your card number';
                            }
                            return formValidator.cardValidty(value);
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Enter your Expiration date',
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your Expiration date';
                                  }
                                  return formValidator.expirationValidty(value);
                                },
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Enter your security code',
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your security code';
                                  }
                                  return formValidator.securityValidty(value);
                                },
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter your zip code',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your zip code';
                            }
                            return formValidator.cardValidty(value);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
