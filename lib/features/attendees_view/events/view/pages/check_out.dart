// ignore_for_file: must_be_immutable, prefer_interpolation_to_compose_strings, duplicate_ignore
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tessera/features/attendees_view/events/cubit/event_book_cubit.dart';
import 'package:tessera/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:tessera/features/attendees_view/events/view/widgets/email_button.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:email_validator/email_validator.dart';
import 'package:tessera/core/services/validation/form_validator.dart';
import 'package:tessera/features/attendees_view/events/data/booking_data.dart';
import 'package:tessera/features/attendees_view/events/data/event_data.dart';

/// A screen in which the user entres the data to check out

class CheckOut extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final int _duration = 60; //1800;
  final List ticketTier;
  final String id;
  final bool charge; // does the event have all free tiers
  late String feesText; //money or free
  String inputEmailCheckOut = '';
  FormValidator formValidator = FormValidator();
  String firstCheckOut = '';
  String lastCheckOut = '';
  final EventModel data;
  final String promocode;
  late BookingModel book;

  CheckOut(
      {Key? key,
      required this.charge,
      required this.ticketTier,
      required this.data,
      required this.id,
      required this.promocode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                '/makeSure',
                arguments: [data,id], //GIVING THE PRICE AS Int
              );
            },
            icon: const Icon(Icons.close)),
        elevation: 0,
        backgroundColor: AppColors.lightBackground,
        title: const Text(
          'Check Out Information',
          textAlign: TextAlign.left,
          style: TextStyle(
              fontFamily: 'NeuePlak',
              color: AppColors.textOnLight,
              fontSize: 25),
        ),
        //backgroundColor: AppColors.primary,
      ),
      bottomNavigationBar: BottomAppBar(
          color: AppColors.lightBackground,
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
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
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

                          if (promocode == '') {
                            book = BookingModel(
                                contactInformation: info.toMap(),
                                ticketTierSelected: ticketTier);
                          } else {
                            book = BookingModel(
                                contactInformation: info.toMap(),
                                promocode: promocode,
                                ticketTierSelected: ticketTier);
                          }
                          // ignore: avoid_print
                          print(jsonEncode(book.toMap()));
                          bool output = await context
                              .read<EventBookCubit>()
                              .postBookingData(book.toMap(), id);
                          if (output == true) {
                            Navigator.pushNamed(context, '/third');
                            print('done');
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              duration: Duration(seconds: 2),
                              content: Text('Successfully booked'),
                              shape: StadiumBorder(),
                              behavior: SnackBarBehavior.floating,
                            ));
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
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
      backgroundColor: AppColors.lightBackground,
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Your tickets',
                    style: TextStyle(
                        fontFamily: 'NeuePlak',
                        color: AppColors.textOnLight,
                        fontSize: 30),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  for (int i = 0; i < ticketTier.length; i++)
                    Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            border:
                                Border.all(color: AppColors.primary, width: 2),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            children: [
                              Column(
                                children: [
                                  Text(
                                    'Tier: ' +
                                        ticketTier[i]['tierName'].toString(),
                                    style: TextStyle(
                                        fontFamily: 'NeuePlak',
                                        color: AppColors.lightBackground,
                                        fontSize: 30),
                                  ),
                                  Text(
                                    // ignore: prefer_interpolation_to_compose_strings
                                    'Number of Ticket: ' +
                                        ticketTier[i]['quantity'].toString(),
                                    style: TextStyle(
                                        fontFamily: 'NeuePlak',
                                        color: AppColors.lightBackground,
                                        fontSize: 30),
                                  ),
                                  Text(
                                    'Price: ' +
                                        ticketTier[i]['price'].toString(),
                                    style: TextStyle(
                                        fontFamily: 'NeuePlak',
                                        color: AppColors.lightBackground,
                                        fontSize: 30),
                                  ),
                                  const Divider(
                                    color: AppColors.primary,
                                    height: 5,
                                    thickness: 1.5,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Billing Basic Information', //APP BAR EVENT NAME
                    style: TextStyle(
                        fontFamily: 'NeuePlak',
                        color: AppColors.textOnLight,
                        fontSize: 29),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Enter your first name',
                              helperText: 'Required'),
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
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: TextFormField(
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Enter your last name',
                              helperText: 'Required'),
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
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter your Email address',
                        helperText: 'Required'),
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
                  const SizedBox(
                    height: 20,
                  ),
                  Visibility(
                    visible: !charge,
                    child: Column(
                      children: [
                        const Text(
                          'pay with',
                          style: TextStyle(
                              fontFamily: 'NeuePlak',
                              color: AppColors.textOnLight,
                              fontSize: 20),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
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
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                decoration: const InputDecoration(
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
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: TextFormField(
                                decoration: const InputDecoration(
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
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
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
