import 'package:flutter/material.dart';
import 'package:tessera/features/event_creation/view/Widgets/my_drop_down_menu.dart';

// ignore: must_be_immutable
class NewEventLocation extends StatefulWidget {

  NewEventLocation({super.key});

  @override
  State<NewEventLocation> createState() => _NewEventLocationState();
}

class _NewEventLocationState extends State<NewEventLocation> {
  List<String> locationList = <String>[
    'Venue',
    'Online Event',
    'To be announced'
  ];

  bool visabilty=true;

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
                endIndent: 100,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Row(
                  children: [
                    const Icon(Icons.pin_drop_outlined),
                    const Spacer(
                      flex: 1,
                    ),
                    MyDropDownMenu(myList: locationList),
                    const Spacer(
                      flex: 20,
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: visabilty,
                child: Container(
                  padding: const EdgeInsets.only(top: 10, bottom: 20),
                  child: const TextField(
                    decoration: InputDecoration(
                      hintText: "Search for a location",
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: visabilty,
                child: GestureDetector(
                  child: Container(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.grey)),
                    child: Row(
                      children: [
                        const Icon(Icons.add),
                        const Spacer(
                          flex: 1,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text('Can\'t find what you\'re looking for?'),
                            Text('Add a new venue or address.'),
                          ],
                        ),
                        const Spacer(
                          flex: 20,
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    print('open choose from map screen');
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/neweventreceipt');
        },
        backgroundColor: Colors.orange,
        child: const Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}
