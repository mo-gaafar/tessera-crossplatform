import 'package:flutter/material.dart';
import 'package:tessera/constants/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tessera/features/organizers_view/event_creation/cubit/createEvent_cubit.dart';
import 'package:tessera/features/organizers_view/event_creation/view/Widgets/my_editable_dateAndTime_text.dart';

class NewEventSetDate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Divider(
                color: Colors.green,
                thickness: 3,
                endIndent: 200,
              ),
              const Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: Text(
                  'Set the date of your event.',
                  style: TextStyle(fontSize: 40.0, fontFamily: 'NeuePlak'),
                  textAlign: TextAlign.left,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: Text(
                  'From:',
                  style: TextStyle(fontSize: 25.0, fontFamily: 'NeuePlak'),
                  textAlign: TextAlign.left,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Row(
                  children: [
                    const Icon(Icons.calendar_month_outlined),
                    MyEditabelDateAndTimeText(
                        text: 'Date', dateOrTime: 'date', fromOrTo: 'from'),
                    const Text('   |   '),
                    const Icon(Icons.timelapse_rounded),
                    MyEditabelDateAndTimeText(
                        text: 'Time', dateOrTime: 'time', fromOrTo: 'from'),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: Text(
                  'To:',
                  style: TextStyle(fontSize: 25.0, fontFamily: 'NeuePlak'),
                  textAlign: TextAlign.left,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Row(
                  children: [
                    const Icon(Icons.calendar_month_outlined),
                    MyEditabelDateAndTimeText(
                        text: 'Date', dateOrTime: 'date', fromOrTo: 'to'),
                    const Text('   |   '),
                    const Icon(Icons.timelapse_rounded),
                    MyEditabelDateAndTimeText(
                        text: 'Time', dateOrTime: 'time', fromOrTo: 'to'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (context.read<CreateEventCubit>().currentEvent.endTime == null) {
            context
                .read<CreateEventCubit>()
                .displayError(errormessage: 'Please Add all dates and times.');
          } else if (context.read<CreateEventCubit>().currentEvent.endDate ==
              null) {
            context
                .read<CreateEventCubit>()
                .displayError(errormessage: 'Please Add all dates and times.');
          } else if (context.read<CreateEventCubit>().currentEvent.startTime ==
              null) {
            context
                .read<CreateEventCubit>()
                .displayError(errormessage: 'Please Add all dates and times.');
          } else if (context.read<CreateEventCubit>().currentEvent.startDate ==
              null) {
            context
                .read<CreateEventCubit>()
                .displayError(errormessage: 'Please Add all dates and times.');
          } else {
            Navigator.pushNamed(context, '/neweventlocation');
          }
        },
        backgroundColor: Colors.orange,
        child: const Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}
