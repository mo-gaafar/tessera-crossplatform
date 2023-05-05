import 'package:flutter/material.dart';
import 'package:numpad/numpad.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tessera/constants/app_colors.dart';
import 'package:tessera/features/event_creation/cubit/createEvent_cubit.dart';
import 'package:tessera/features/event_creation/view/Widgets/atendeeManagement_evnetslist.dart';

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
                    decoration: BoxDecoration(
                        border: Border.all(style: BorderStyle.solid)),
                    child: TextButton(
                      onPressed: () {Navigator.pushNamed(context, '/sendemailtoatendeescreen');},
                      child: Text('Email'),
                    ),
                    width: 240,
                  ),
                  Container(
                    padding: EdgeInsets.all(12),
                    child: TextButton(
                      onPressed: () {},
                      child: Text('Check in all'),
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
                    padding: EdgeInsets.all(16),
                    child: TextButton(
                      onPressed: () {},
                      child: Text('New Sale'),
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
