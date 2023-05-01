import 'package:flutter/material.dart';
import 'package:tessera/constants/app_colors.dart';
import 'package:tessera/features/event_creation/data/get_selected_date_time.dart';

class MyEditabelDateAndTimeText extends StatefulWidget {
  String text;
  String dateOrTime;
  String fromOrTo = '';
  MyEditabelDateAndTimeText(
      {required this.text, required this.dateOrTime, required this.fromOrTo});
  @override
  State<MyEditabelDateAndTimeText> createState() =>
      _MyEditabelDateAndTimeTextState(
          text: text, dateOrTime: dateOrTime, fromOrTo: fromOrTo);
}

class _MyEditabelDateAndTimeTextState extends State<MyEditabelDateAndTimeText> {
  String text;
  String dateOrTime;
  String fromOrTo = '';
  _MyEditabelDateAndTimeTextState(
      {required this.text, required this.dateOrTime, required this.fromOrTo});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 18,
        ),
      ),
      onTap: () async {
        late var tempText;
        if (fromOrTo == 'from' && dateOrTime == 'date') {
          tempText = await GetSelectedDateAndTime().selectDate(context);
        } else if (fromOrTo == 'from' && dateOrTime == 'time') {
          tempText = await GetSelectedDateAndTime().selectTime(context);
        } else if (fromOrTo == 'to' && dateOrTime == 'date') {
          tempText = await GetSelectedDateAndTime().selectDate(context);
        } else if (fromOrTo == 'to' && dateOrTime == 'time') {
          tempText = await GetSelectedDateAndTime().selectTime(context);
        }
        setState(
          () {
            text = tempText.toString();
          },
        );
      },
    );
  }
}