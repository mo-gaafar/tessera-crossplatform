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
  const SeeMore(
      {super.key,
      required this.title,
      required this.date,
      required this.time,
      required this.details,
      required this.image});
  final String title;
  final String date;
  final String time;
  final String details;
  final String image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(child: AppBar(
          centerTitle: true,
          flexibleSpace: ClipRRect(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30),bottomRight: Radius.circular(30)),
          child:Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(image), //EVENT IMAGE
                  ),
                ),
              ),),
        elevation: 0,
        backgroundColor: Colors.transparent,
        
        //backgroundColor: AppColors.primary,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context); //back to landing page
            },
            icon: const Icon(
              Icons.close,
              
            )),
      ), preferredSize: Size.fromHeight(200)),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title, //APP BAR EVENT NAME
                  style: TextStyle(
                      fontFamily: 'NeuePlak',
                      color: AppColors.textOnLight,
                      fontSize: 25),
                ),
                SizedBox(height: 20,),
                Text(
                  'Date: '+date ,
                  style: const TextStyle(
                      fontFamily: 'NeuePlak',
                      color: AppColors.textOnLight,
                      fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Time: '+ time,
                  style: const TextStyle(
                      fontFamily: 'NeuePlak',
                      color: AppColors.textOnLight,
                      fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                //seemore text
                Text(
                  details,
                  style: const TextStyle(
                      fontFamily: 'NeuePlak',
                      color: AppColors.textOnLight,
                      fontSize: 20),
                ),
              ],
            ),
          ),
        ));
  }
}
