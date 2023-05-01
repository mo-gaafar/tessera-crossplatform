import 'package:flutter/material.dart';
import 'package:tessera/constants/app_colors.dart';
import 'package:tessera/features/event_creation/view/Widgets/my_drop_down_menu.dart';
import 'package:tessera/features/event_creation/view/Widgets/my_editable_dateAndTime_text.dart';
import 'package:tessera/features/event_creation/view/Widgets/receipt_section.dart';
import 'package:tessera/features/event_creation/view/Widgets/my_editable_text.dart';
import 'package:tessera/features/event_creation/view/Widgets/my_image_picker.dart';
import 'package:tessera/features/event_creation/view/Widgets/popup_menu.dart';
import 'dart:math' as math;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tessera/features/event_creation/cubit/createEvent_cubit.dart';

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
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.textOnLight,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.visibility),
              tooltip: 'Show',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('This is a visibilty icon snackbar')));
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.done,
                color: Colors.grey,
              ),
              tooltip: 'Show',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('This is a done icon snackbar')));
              },
            ),
            IconButton(
              icon: const Icon(Icons.publish_outlined),
              tooltip: 'Show',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('This is a publish icon snackbar')));
              },
            ),
            IconButton(
              icon: const Icon(Icons.more_vert),
              tooltip: 'Show',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('This is a more icon snackbar')));
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              MyImagePicker(),
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
                      textStyle: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    MyEditabelText(
                      title: "by Unnamed organizer",
                      textStyle: TextStyle(fontSize: 18, color: Colors.black),
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
                    MyDropDownMenu(
                      myList: locationList,
                      type: 'location',
                    ),
                  ],
                ),
              ),
              ReceiptSection(
                sectionIcon: const Icon(Icons.sell_outlined),
                sectionChild: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Event type'),
                    GestureDetector(
                      child: const Text(
                        'Select type',
                        style: TextStyle(color: Colors.grey),
                      ),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('Select Event Type'),
                            content: PopupMenu(selectEvent: 'Type'),
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text('Event category'),
                    GestureDetector(
                      child: const Text(
                        'Select category',
                        style: TextStyle(color: Colors.grey),
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
              ReceiptSection(
                sectionIcon: Transform.rotate(
                    angle: 90 * math.pi / 180,
                    child: const Icon(Icons.confirmation_number_outlined)),
                sectionChild: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Ticket'),
                    GestureDetector(
                      child: const Text(
                        'Add ticket',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    MyDropDownMenu(
                      myList: ticketList,
                    ),
                  ],
                ),
              ),
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
            ],
          ),
        ),
      ),
    );
  }
}
