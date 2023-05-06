import 'package:flutter/material.dart';
import 'package:numpad/numpad.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tessera/features/event_creation/cubit/createEvent_cubit.dart';
import 'package:tessera/features/atendee_management/view/widgets/atendeeManagement_evnetslist.dart';
import 'package:tessera/features/authentication/view/widgets/email_button.dart';
import 'package:tessera/constants/app_colors.dart';

class AtendeeManagementHomePage extends StatelessWidget {
  const AtendeeManagementHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.menu_outlined,
            ),
            onPressed: () {
              //Navigator.pop(context);
            },
          ),
          actions: [
            GestureDetector(
              child: Center(
                  child: Text(
                'Clear',
              )),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Clear every thing!'),
                        content: Text(
                            'All the atendee management data you have made will be deleted is this ok with you?'),
                        actions: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('No'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('Yes'),
                          ),
                        ],
                      );
                    });
              },
            ),
          ],
        ),
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        (context
                                    .read<CreateEventCubit>()
                                    .currentEvent
                                    .tickets ==
                                null)
                            ? '0'
                            : context
                                .read<CreateEventCubit>()
                                .currentEvent
                                .tickets!,
                        style: const TextStyle(
                            fontSize: 48, fontWeight: FontWeight.bold),
                      ),
                      const Text(
                        '£',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                AtendeeEventsList(),
                const Spacer(),
                Container(
                  child: EmailButton(
                    buttonText: 'Add Atendee Detail',
                    colourBackground: AppColors.primary,
                    colourText: Colors.white,
                    onTap: () {
                      Navigator.pushNamed(context, '/addatendeedetails');
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
