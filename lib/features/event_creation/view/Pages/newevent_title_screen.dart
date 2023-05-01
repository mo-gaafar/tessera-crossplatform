import 'package:flutter/material.dart';
import 'package:tessera/constants/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tessera/features/event_creation/cubit/createEvent_cubit.dart';

class NewEventtitle extends StatelessWidget {
  NewEventtitle({super.key});
  String tempEventTitle = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              const Text(
                'Give your event a title.',
                style: TextStyle(
                    color: AppColors.textOnLight,
                    fontSize: 40.0,
                    fontFamily: 'NeuePlak'),
              ),
              TextField(
                decoration: const InputDecoration(
                  hintText: "Enter a short distinct name",
                ),
                onChanged: (value) {
                  tempEventTitle = value;
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (tempEventTitle != '') {
            context.read<CreateEventCubit>().currentEvent.eventName =
                tempEventTitle;
            Navigator.pushNamed(context, '/neweventdescription');
          } else {
            context
                .read<CreateEventCubit>()
                .displayError(errormessage: 'Event must have a title.');
          }
        },
        backgroundColor: Colors.orange,
        child: const Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}
