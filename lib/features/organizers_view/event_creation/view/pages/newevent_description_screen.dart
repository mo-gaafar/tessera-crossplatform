import 'package:flutter/material.dart';
import 'package:tessera/constants/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tessera/features/organizers_view/event_creation/cubit/createEvent_cubit.dart';

class NewEventDescription extends StatelessWidget {
  const NewEventDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Divider(
                color: Colors.green,
                thickness: 3,
                endIndent: 300,
              ),
              const Text(
                'Describe your event.',
                style: TextStyle(fontSize: 40.0, fontFamily: 'NeuePlak'),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: const Text(
                  'Enter a brief summary of your event so guests know what to expect',
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 20.0,
                      fontFamily: 'NeuePlak'),
                  textAlign: TextAlign.left,
                ),
              ),
              TextField(
                onChanged: (value) {
                  context.read<CreateEventCubit>().currentEvent.description =
                      value;
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacementNamed(context, '/neweventsetdate');
        },
        backgroundColor: Colors.orange,
        child: const Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}
