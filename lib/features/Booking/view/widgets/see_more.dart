import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tessera/constants/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:tessera/features/Booking/view/widgets/reuseable_events.dart';
import 'package:tessera/features/Booking/view/widgets/event_page.dart';

class SeeMore extends StatelessWidget {
  final String seemoreText;
  final String dateText;
  final String timeText;

  const SeeMore({Key? key, required this.seemoreText,
  required this.dateText, required this.timeText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        timeText+ ', '+dateText+', ' +seemoreText ,
        style: const TextStyle(
            fontFamily: 'NeuePlak', color: AppColors.textOnLight, fontSize: 20),
      ),
    );
  }
}
