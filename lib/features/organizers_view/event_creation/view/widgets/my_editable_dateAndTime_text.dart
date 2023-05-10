import 'package:flutter/material.dart';
import 'package:tessera/constants/app_colors.dart';
import 'package:tessera/features/organizers_view/event_creation/data/get_selected_date_time.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tessera/features/organizers_view/event_creation/cubit/createEvent_cubit.dart';

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
          GetSelectedDateAndTime getSelectedDateAndTime =
              GetSelectedDateAndTime();
          tempText = await getSelectedDateAndTime.selectDate(context);
          context.read<CreateEventCubit>().currentEvent.startDate = tempText;
          context.read<CreateEventCubit>().currentEvent.timeZoneName =
              getSelectedDateAndTime.getTimeZoneName();
        } else if (fromOrTo == 'from' && dateOrTime == 'time') {
          tempText = await GetSelectedDateAndTime().selectTime(context);
          context.read<CreateEventCubit>().currentEvent.startTime = tempText;
        } else if (fromOrTo == 'to' && dateOrTime == 'date') {
          GetSelectedDateAndTime getSelectedDateAndTime =
              GetSelectedDateAndTime();
          tempText = await getSelectedDateAndTime.selectDate(context);
          context.read<CreateEventCubit>().currentEvent.endDate = tempText;
          context.read<CreateEventCubit>().currentEvent.timeZoneName =
              getSelectedDateAndTime.getTimeZoneName();
        } else if (fromOrTo == 'to' && dateOrTime == 'time') {
          tempText = await GetSelectedDateAndTime().selectTime(context);
          context.read<CreateEventCubit>().currentEvent.endTime = tempText;
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
