import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tessera/constants/app_colors.dart';
import 'package:tessera/features/attendees_view/events/view/widgets/email_button.dart';
import 'dart:math' as math;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tessera/features/authentication/cubit/auth_cubit.dart';
import 'package:tessera/features/organizers_view/event_creation/cubit/createEvent_cubit.dart';
import 'package:tessera/features/organizers_view/event_creation/cubit/createEvent_state.dart';
import 'package:tessera/features/organizers_view/event_creation/data/creator_reposiory.dart';
import 'package:tessera/features/organizers_view/event_creation/view/Widgets/my_drop_down_menu.dart';
import 'package:tessera/features/organizers_view/event_creation/view/Widgets/my_editable_dateAndTime_text.dart';
import 'package:tessera/features/organizers_view/event_creation/view/Widgets/my_editable_text.dart';
import 'package:tessera/features/organizers_view/event_creation/view/Widgets/my_image_picker.dart';
import 'package:tessera/features/organizers_view/event_creation/view/Widgets/popup_menu.dart';
import 'package:tessera/features/organizers_view/event_creation/view/Widgets/receipt_section.dart';

class NewEventReceipt extends StatelessWidget {
  NewEventReceipt({super.key});
  List<String> locationList = <String>[
    'To be announced',
    'Venue',
    'Online Event'
  ];
  String? LList = 'To be announced';
  List<String> ticketList = <String>['Display options', 'Reserved seating'];
  List<String> privacyList = <String>['Public event', 'Private event'];
  late String id;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.secondary,
          foregroundColor: AppColors.textOnLight,
        ),
        body: ListView(
          children: [
            //MyImagePicker(),
            ReceiptSection(
              sectionIcon: const Icon(Icons.rtt),
              sectionChild: Column(
                children: [
                  MyEditabelText(
                    title: context
                        .read<CreateEventCubit>()
                        .currentEvent
                        .eventName
                        .toString(),
                    textStyle: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).textTheme.bodyLarge!.color),
                  ),
                  MyEditabelText(
                    title: "by Unnamed organizer",
                    textStyle: TextStyle(
                        fontSize: 18,
                        color: Theme.of(context).textTheme.bodyLarge!.color),
                  ),
                  MyEditabelText(
                    title: (context
                                .read<CreateEventCubit>()
                                .currentEvent
                                .description ==
                            null)
                        ? "Event description"
                        : context
                            .read<CreateEventCubit>()
                            .currentEvent
                            .description
                            .toString(),
                    textStyle:
                        TextStyle(fontSize: 18, color: Colors.grey.shade700),
                  ),
                ],
              ),
            ),
            ReceiptSection(
              sectionIcon: const Icon(Icons.calendar_month),
              sectionChild: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Event starts',
                    style: TextStyle(color: Colors.grey),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Row(
                      children: [
                        MyEditabelDateAndTimeText(
                            text: context
                                .read<CreateEventCubit>()
                                .currentEvent
                                .startDate!,
                            dateOrTime: 'date',
                            fromOrTo: 'from'),
                        const SizedBox(
                          width: 30,
                        ),
                        MyEditabelDateAndTimeText(
                            text: context
                                .read<CreateEventCubit>()
                                .currentEvent
                                .startTime!,
                            dateOrTime: 'time',
                            fromOrTo: 'from'),
                      ],
                    ),
                  ),
                  const Text(
                    'Event ends',
                    style: TextStyle(color: Colors.grey),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Row(
                      children: [
                        MyEditabelDateAndTimeText(
                            text: context
                                .read<CreateEventCubit>()
                                .currentEvent
                                .endDate!,
                            dateOrTime: 'date',
                            fromOrTo: 'to'),
                        const SizedBox(
                          width: 30,
                        ),
                        MyEditabelDateAndTimeText(
                            text: context
                                .read<CreateEventCubit>()
                                .currentEvent
                                .endTime!,
                            dateOrTime: 'time',
                            fromOrTo: 'to'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            ReceiptSection(
              sectionIcon: const Icon(
                Icons.pin_drop_outlined,
                color: Colors.grey,
              ),
              sectionChild: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(((context
                                  .read<CreateEventCubit>()
                                  .currentEvent
                                  .eventLocationName ==
                              null)
                          ? context
                              .read<CreateEventCubit>()
                              .currentEvent
                              .eventStatus
                          : context
                              .read<CreateEventCubit>()
                              .currentEvent
                              .eventLocationName)
                      .toString()),
                ],
              ),
            ),
            ReceiptSection(
              sectionIcon: const Icon(Icons.sell_outlined),
              sectionChild: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Event category'),
                  GestureDetector(
                    child: BlocBuilder<CreateEventCubit, CreateEventState>(
                      builder: (context, state) {
                        if (state is CreateEventBasicInfo) {
                          if (state.eventCategory != null) {
                            return Text(
                              state.eventCategory!,
                              style: TextStyle(color: Colors.grey),
                            );
                          } else {
                            return Text(
                              'Select a Category',
                              style: TextStyle(color: Colors.grey),
                            );
                          }
                        } else {
                          return Text(
                            'Select a Category',
                            style: TextStyle(color: Colors.grey),
                          );
                        }
                      },
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Select Event Category'),
                          content: PopupMenu(selectEvent: 'Category'),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            // ReceiptSection(
            //   sectionIcon: Transform.rotate(
            //       angle: 90 * math.pi / 180,
            //       child: const Icon(Icons.confirmation_number_outlined)),
            //   sectionChild: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       const Text('Ticket'),
            //       GestureDetector(
            //         child: const Text(
            //           'Add ticket',
            //           style: TextStyle(color: Colors.grey),
            //         ),
            //       ),
            //       MyDropDownMenu(
            //         myList: ticketList,
            //       ),
            //     ],
            //   ),
            // ),
            ReceiptSection(
              sectionIcon: const Icon(Icons.local_activity_outlined),
              sectionChild: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Privacy',
                    style: TextStyle(color: Colors.grey),
                  ),
                  MyDropDownMenu(
                    myList: privacyList,
                    type: 'Privacy',
                  ),
                ],
              ),
            ),
            ReceiptSection(
              sectionChild: MyImagePicker(),
              sectionIcon: const Icon(Icons.image_outlined),
            ),
            ReceiptSection(
              sectionChild: TextField(
                decoration: InputDecoration(
                  hintText: "Enter a brief summary",
                ),
                onChanged: (value) {
                  context.read<CreateEventCubit>().currentEvent.eventSummary =
                      value;
                },
              ),
              sectionIcon: const Icon(Icons.short_text_rounded),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: EmailButton(
                buttonText: 'Create event and continue to ticketing',
                colourBackground: AppColors.secondary,
                colourText: AppColors.lightBackground,
                onTap: () async {
                  
                  if (context
                          .read<CreateEventCubit>()
                          .currentEvent
                          .eventCategory !=
                      null) {
                    print(context.read<AuthCubit>().currentUser.accessToken!);
                    final response =
                        await CreatorRepository.postCreatedEventBasicInfo(
                            context
                                .read<CreateEventCubit>()
                                .currentEvent
                                .basicInfoToJson(),
                            context.read<AuthCubit>().currentUser.accessToken!);
                    if (context
                            .read<CreateEventCubit>()
                            .currentEvent
                            .eventImage !=
                        null) {
                      await CreatorRepository.updateEventImage(
                          context
                              .read<CreateEventCubit>()
                              .currentEvent
                              .eventImage,
                          context.read<CreateEventCubit>().currentEvent.eventID,
                          context.read<AuthCubit>().currentUser.accessToken);
                    }
                    context.read<CreateEventCubit>().displayError(
                        errormessage: response['message'].toString());
                    if (response['success']) {
                      context.read<CreateEventCubit>().currentEvent.eventID =
                          response['event_Id'];
                          id =  response['event_Id'];
                    print("EVENT ID:");
                    print(response['event_Id']);
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/neweventtickets',
                      arguments: id as String, ModalRoute.withName('/creatorlanding')
                    );
            
                    }
                  } else {
                    context.read<CreateEventCubit>().displayError(
                        errormessage: 'Please add an event category.');
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
