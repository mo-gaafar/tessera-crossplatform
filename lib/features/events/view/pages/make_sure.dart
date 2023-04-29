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


//TODO: initiate OnTap for the Buttons
//TODO:Connet with chechout page and event page

class MakeSure extends StatelessWidget {
  const MakeSure({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading:false,
        elevation: 0,
        backgroundColor: AppColors.lightBackground,
        title: Text(
          'Are you sure?',
          textAlign: TextAlign.left,
          style: TextStyle(
              fontFamily: 'NeuePlak',
              color: AppColors.textOnLight,
              fontSize: 25),
        ),
        
      ),
      backgroundColor: AppColors.lightBackground,
      body:Padding(
        padding: const EdgeInsets.all(15.0),
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Text(
        'Leaving check out?',
        textAlign: TextAlign.left,
        style: TextStyle(
            fontFamily: 'NeuePlak',
            color: AppColors.secondaryTextOnLight,
            fontSize: 25),
          ),
        Text(
        'Are you sure you want to go back to the Event Page?, the items you selected might not be available later.',
        textAlign: TextAlign.left,
        style: TextStyle(
            fontFamily: 'NeuePlak',
            color: AppColors.secondaryTextOnLight,
            fontSize: 25),
          ),
          Row(children: [
        Expanded(
          child: EmailButton(buttonText: 'Yes'
          , colourBackground: AppColors.secondary, colourText: AppColors.lightBackground,onTap: (){}),
        ),SizedBox(width: 10,)
        ,Expanded(child: EmailButton(buttonText: 'No', colourBackground: AppColors.primary, colourText: AppColors.lightBackground,onTap: (){}))
          ],)
        ],)
          ),
    );
  }
}
