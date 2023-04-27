import 'package:flutter/material.dart';
import 'package:tessera/constants/app_colors.dart';
import 'package:tessera/features/event_creation/view/Widgets/my_editable_dateAndTime_text.dart';
import 'package:tessera/features/event_creation/view/Widgets/receipt_section.dart';
import 'package:tessera/features/event_creation/view/Widgets/my_editable_text.dart';
import 'package:tessera/features/event_creation/view/Widgets/my_image_picker.dart';
import 'package:tessera/features/event_creation/view/Widgets/popup_menu.dart';
import 'dart:math' as math;

class NewEventReceipt extends StatelessWidget {
  NewEventReceipt({super.key});
  List<String> locationList = <String>[
    'To be announced',
    'Venue',
    'Online Event'
  ];
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
                      title: "Test",
                      textStyle: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    MyEditabelText(
                      title: "un named organizer",
                      textStyle: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                    MyEditabelText(
                      title: "Event description",
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
                              text: 'Thu, 25 may 2023',
                              dateOrTime: 'date',
                              fromOrTo: 'from'),
                          const SizedBox(
                            width: 30,
                          ),
                          MyEditabelDateAndTimeText(
                              text: '07:00 pm',
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
                              text: 'Thu, 25 may 2023',
                              dateOrTime: 'date',
                              fromOrTo: 'to'),
                          const SizedBox(
                            width: 30,
                          ),
                          MyEditabelDateAndTimeText(
                              text: '10:00 pm',
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
                    DropdownButton(
                      value: locationList.first,
                      onChanged: (value) {},
                      items: locationList
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      }).toList(),
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
                            content: PopupMenu(selectEvent: 'Title'),
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
                    DropdownButton(
                      value: ticketList.first,
                      onChanged: (value) {},
                      items: ticketList
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                          ),
                        );
                      }).toList(),
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
                    DropdownButton(
                      value: privacyList.first,
                      onChanged: (value) {},
                      items: privacyList
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                          ),
                        );
                      }).toList(),
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
