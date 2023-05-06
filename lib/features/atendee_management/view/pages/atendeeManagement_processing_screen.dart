import 'package:flutter/material.dart';
import 'package:numpad/numpad.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tessera/constants/app_colors.dart';
import 'package:tessera/features/event_creation/cubit/createEvent_cubit.dart';
import 'package:tessera/features/atendee_management/view/widgets/atendeeManagement_evnetslist.dart';
import 'package:tessera/features/authentication/view/widgets/email_button.dart';
import 'package:tessera/constants/app_colors.dart';

class AtendeeManagementProcessingPage extends StatelessWidget {
  const AtendeeManagementProcessingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Processing'),
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
                'Add a Note',
              )),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Add your note: '),
                        content: TextField(),
                        actions: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('Cancel'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('Done'),
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
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      padding: EdgeInsets.all(12),
                      child: Icon(
                        Icons.done_all,
                        color: Colors.green,
                        size: 60,
                      )),
                  Container(
                      padding: EdgeInsets.all(12),
                      child: Column(
                        children: [
                          Text(
                              'Total Paid ${context.read<CreateEventCubit>().currentEvent.tickets}'),
                          Text('No change due'),
                        ],
                      )),
                  Container(
                    child: EmailButton(
                      buttonText: 'Check in all tickets for the atendee added.',
                      colourBackground: AppColors.primary,
                      colourText: Colors.white,
                      onTap: () {
                        print('go to confirmation page ');
                      },
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'The Door, At',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(context
                        .read<CreateEventCubit>()
                        .currentEvent
                        .eventName
                        .toString()),
                  ),
                  const Spacer(),
                  Container(
                    child: EmailButton(
                      buttonText: 'New Sale',
                      colourBackground: AppColors.primary,
                      colourText: Colors.white,
                      onTap: () {
                        Navigator.pushNamed(
                            context, '/atendeemanagementhomescreen');
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
