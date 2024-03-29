import 'package:flutter/material.dart';
import 'package:numpad/numpad.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tessera/constants/app_colors.dart';
import 'package:tessera/features/authentication/cubit/auth_cubit.dart';
import 'package:tessera/features/organizers_view/atendee_management/data/atendeeManagement_repository.dart';
import 'package:tessera/features/organizers_view/event_creation/cubit/createEvent_cubit.dart';
import 'package:tessera/features/organizers_view/atendee_management/cubit/atendeeManagement_cubit.dart';
import 'package:tessera/features/authentication/view/widgets/email_button.dart';
import 'package:tessera/constants/app_colors.dart';

class AtendeeManagementProcessingPage extends StatelessWidget {
  const AtendeeManagementProcessingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                            'Total Paid ${(context.read<AtendeeManagementCubit>().atendeeModel.ticketisFree == true) ? '0' : context.read<AtendeeManagementCubit>().atendeeModel.totalTicketsPrice}'),
                        Text('No change due'),
                      ],
                    )),
                Container(
                  child: EmailButton(
                    buttonText:
                        'Check out all the tickets for the atendee added.',
                    colourBackground: AppColors.primary,
                    colourText: Colors.white,
                    onTap: () async {
                      context
                              .read<AtendeeManagementCubit>()
                              .atendeeModel
                              .organiserEmail =
                          context.read<AuthCubit>().currentUser.email; //email
                      print(context.read<AuthCubit>().currentUser.username);
                      String? text =
                          context.read<AuthCubit>().currentUser.username;
                      List<String> words;
                      if (text != null) {
                        words = text.split(' ');
                        context
                            .read<AtendeeManagementCubit>()
                            .atendeeModel
                            .organiserfirstName = words[0];
                        context
                            .read<AtendeeManagementCubit>()
                            .atendeeModel
                            .organiserlasteName = words[1];
                      }

                      final message = await AtendeeManagementRepository()
                          .addAtendee(
                              context
                                  .read<CreateEventCubit>()
                                  .currentEvent
                                  .eventID!,
                              context
                                  .read<AtendeeManagementCubit>()
                                  .atendeeModel
                                  .toJson(),
                              context
                                  .read<AuthCubit>()
                                  .currentUser
                                  .accessToken!);
                      print(message);
                      if (message == 'Attendee Added successfully') {
                        Navigator.pushNamed(
                            context, '/atendeeaddedsuccessfullyscreen');
                      }
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
    );
  }
}
