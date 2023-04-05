import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tessera/constants/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:tessera/features/Booking/view/widgets/event_page.dart';

class SeeMore extends StatelessWidget {
  final String seemoreText;
  final String dateText;
  final String timeText;
  final String titleText;

  const SeeMore({Key? key, required this.seemoreText,
  required this.dateText, required this.timeText,required this.titleText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
            appBar: AppBar(
              leading: IconButton(
              onPressed: () {
                Navigator.pushNamed(context,'/second');
              },
              icon: Icon(Icons.close)),
                  elevation: 3,
                  backgroundColor: AppColors.primary,
                ),
            body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                    titleText,
                    style: TextStyle(
                        fontFamily: 'NeuePlak', color: AppColors.textOnLight, fontSize: 25),
                  ),
                  SizedBox(
                    height: 20,
                  ),
              Text(
                timeText+ ', '+dateText,
                style: const TextStyle(
                    fontFamily: 'NeuePlak', color: AppColors.textOnLight, fontSize: 20),
              ),
              SizedBox(
                    height: 20,
                  ),
              Text(
                seemoreText ,
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
