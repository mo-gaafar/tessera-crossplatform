import 'package:flutter/material.dart';
import 'package:tessera/features/authentication/cubit/auth_cubit.dart';
import 'package:tessera/features/organizers_view/event_creation/data/creator_reposiory.dart';
import 'package:tessera/features/organizers_view/event_creation/view/Widgets/my_drop_down_menu.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tessera/features/organizers_view/event_creation/cubit/createEvent_cubit.dart';

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
  late String selectedValue = locationList.first;
  bool visabilty = true;
  late String value = '';
  late List predictions;

  Future<dynamic> jsonBodyToAllPlacesList(String value, String token) async {
    late final response;
    try {
      response = await CreatorRepository.getAllPlaces(value, token);
      print(response);
      if (response == null ||
          response['predictions'] == [] ||
          response['predictions'] == null) {
        return 'No Places';
      } else {
        predictions = response['predictions'];
      }
      return predictions;
    } catch (e) {
      return 'Network Error'; //if netwrok is connected so the porblem will be in request [404 status] check with back end or try removing tr{}catch
    }
  }

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
                    DropdownButton(
                      value: selectedValue,
                      onChanged: (value) {
                        setState(() {
                          selectedValue = value.toString();
                          context
                              .read<CreateEventCubit>()
                              .currentEvent
                              .eventStatus = value;
                          if (selectedValue == 'Online Event') {
                            context
                                .read<CreateEventCubit>()
                                .currentEvent
                                .isOnline = true;
                          } else {
                            context
                                .read<CreateEventCubit>()
                                .currentEvent
                                .isOnline = false;
                          }
                          if (selectedValue == 'Venue') {
                            visabilty = true;
                          } else {
                            visabilty = false;
                          }
                        });
                      },
                      items: locationList
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                          ),
                        );
                      }).toList(),
                    ),
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
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search for a location",
                    ),
                    onChanged: (val) async {
                      setState(() {
                        value = val;
                      });
                    },
                  ),
                ),
              ),
              Visibility(
                visible: visabilty,
                child: FutureBuilder(
                  future: jsonBodyToAllPlacesList(
                      value,
                      context.select(
                          (AuthCubit auth) => auth.currentUser.accessToken!)),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }
                    if (snapshot.hasData) {
                      if (snapshot.data == 'Network Error') {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Network Error'),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {});
                              },
                              child: Text('Refresh'),
                            ),
                          ],
                        );
                      } else if (snapshot.data == 'No Places') {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Cannot find what you are looking for? '),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {});
                              },
                              child: Text('Refresh'),
                            ),
                          ],
                        );
                      } else {
                        if (predictions != null || predictions.length != 0) {
                          return Expanded(
                            child: ListView.builder(
                              itemCount: predictions.length,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, index) {
                                return ListTile(
                                  subtitle:
                                      Text(predictions[index]["description"]),
                                  dense: true,
                                  onTap: () async {
                                    final eventGeoLocation =
                                        await CreatorRepository
                                            .getAddressGeoLocation(
                                                predictions[index]
                                                    ["description"]);
                                    context
                                        .read<CreateEventCubit>()
                                        .currentEvent
                                        .eventGeoLocation = eventGeoLocation;
                                    context
                                            .read<CreateEventCubit>()
                                            .currentEvent
                                            .eventLocationName =
                                        predictions[index]["description"];
                                    Navigator.pushNamed(
                                        context, '/neweventreceipt');
                                  },
                                );
                              },
                            ),
                          );
                        } else {
                          return Text('Error!');
                        }
                      }
                    } else {
                      return Text('Error!');
                    }
                  },
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
          if (visabilty == true) {
            if (context
                    .read<CreateEventCubit>()
                    .currentEvent
                    .eventLocationName !=
                null) {
              Navigator.pushNamed(context, '/neweventreceipt');
            } else {
              context.read<CreateEventCubit>().displayError(
                  errormessage: 'Search for the place and choose one please.');
            }
          } else {
            Navigator.pushNamed(context, '/neweventreceipt');
          }
        },
        backgroundColor: Colors.orange,
        child: const Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}
