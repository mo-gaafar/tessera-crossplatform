
import 'package:tessera/features/events/view/pages/event_screen.dart';
import 'package:tessera/constants/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:tessera/features/events/cubit/event_book_cubit.dart';
import 'package:provider/provider.dart';
import 'package:tessera/features/events/data/event_data.dart';

/// A screen that shows the description of the event


class SeeMore extends StatelessWidget {
  const SeeMore({super.key, required this.title, required this.date, required this.time, required this.details});
  final String title;
  final String date;
  final String time;
  final String details;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
            appBar: AppBar(
              title: Text(
          title, //APP BAR EVENT NAME
          style: TextStyle(
              fontFamily: 'NeuePlak', color: AppColors.lightBackground, fontSize: 25),
        ),
        //backgroundColor: AppColors.primary,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context); //back to landing page
            },
            icon: Icon(Icons.close,color:AppColors.secondaryTextOnLight ,)),
                  elevation: 3,
                  backgroundColor: AppColors.primary,
                ),
            body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              //event name
              
                  //timeText+ ', '+dateText
              Text(
                date+ ', '+time,
                style: const TextStyle(
                    fontFamily: 'NeuePlak', color: AppColors.textOnLight, fontSize: 20),
              ),
              SizedBox(
                    height: 10,
                  ),
                  //seemore text
              Text(
                details ,
                style: const TextStyle(
                    fontFamily: 'NeuePlak', color: AppColors.textOnLight, fontSize: 20),
              ),
            ],
          ),
        ),
    )
    );
  }
}
