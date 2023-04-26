import 'package:flutter/material.dart';
import 'package:tessera/constants/app_colors.dart';
import 'package:tessera/features/organizers_view/event_creation/data/get_selected_date_time.dart';

class PickDateAndTime extends StatelessWidget {
  String type = '';
  var fromDate;
  var fromTime;
  var toDate;
  var toTime;
  PickDateAndTime(this.type);
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: IconButton(
            icon: const Icon(
              Icons.calendar_month_outlined,
              color: Colors.grey,
            ),
            onPressed: () async {
              if (type == 'from') {
                fromDate = await GetSelectedDateAndTime().selectDate(context);
              } else {
                toDate = await GetSelectedDateAndTime().selectDate(context);
              }
            },
          ),
        ),
        const Text(
          'Date   |   ',
          style: TextStyle(
              color: AppColors.textOnLight,
              fontSize: 20.0,
              fontFamily: 'NeuePlak'),
          textAlign: TextAlign.left,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: IconButton(
            icon: Icon(
              Icons.timelapse_rounded,
              color: Colors.grey,
            ),
            onPressed: () async {
              if (type == 'from') {
                fromTime = await GetSelectedDateAndTime().selectTime(context);
              } else {
                toTime = await GetSelectedDateAndTime().selectTime(context);
              }
            },
          ),
        ),
        const Text(
          'Day',
          style: TextStyle(
              color: AppColors.textOnLight,
              fontSize: 20.0,
              fontFamily: 'NeuePlak'),
          textAlign: TextAlign.left,
        ),
      ],
    );
  }
}
