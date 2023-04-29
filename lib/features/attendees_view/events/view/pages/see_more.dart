import 'package:tessera/constants/app_colors.dart';
import 'package:flutter/material.dart';

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
        // ignore: sort_child_properties_last
        appBar: PreferredSize(child: AppBar(
          centerTitle: true,
          flexibleSpace: ClipRRect(borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(30),bottomRight: Radius.circular(30)),
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
      ), preferredSize: const Size.fromHeight(200)),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title, //APP BAR EVENT NAME
                  style: const TextStyle(
                      fontFamily: 'NeuePlak',
                      color: AppColors.textOnLight,
                      fontSize: 25),
                ),
                const SizedBox(height: 20,),
                Text(
                  // ignore: prefer_interpolation_to_compose_strings
                  'Date: '+date ,
                  style: const TextStyle(
                      fontFamily: 'NeuePlak',
                      color: AppColors.textOnLight,
                      fontSize: 20),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  // ignore: prefer_interpolation_to_compose_strings
                  'Time: '+ time,
                  style: const TextStyle(
                      fontFamily: 'NeuePlak',
                      color: AppColors.textOnLight,
                      fontSize: 20),
                ),
                const SizedBox(
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
