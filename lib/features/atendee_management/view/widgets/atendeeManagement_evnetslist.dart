import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tessera/features/atendee_management/cubit/atendeeManagement_cubit.dart';
import 'package:tessera/features/event_creation/cubit/createEvent_cubit.dart';
import 'package:tessera/features/event_creation/data/creator_reposiory.dart';
import 'package:tessera/features/event_creation/data/organiser_model.dart';
import 'package:tessera/features/event_creation/view/Widgets/no_event_template.dart';
import 'package:tessera/features/atendee_management/view/widgets/my_customized_numpad.dart';
import 'package:tessera/features/atendee_management/data/atendeeManagement_repository.dart';

class AtendeeEventsList extends StatefulWidget {
  AtendeeEventsList({super.key});
  List allEventsTicketTierByuser = [];
  // ['Hi', '5', '1.60', '£'],
  //EventName,AvailableTickets,price,currency
  @override
  State<AtendeeEventsList> createState() => _AtendeeEventsListState();
}

class _AtendeeEventsListState extends State<AtendeeEventsList> {
  Future<dynamic> jsonBodyToEventTicketTierList() async {
    late final response;
    try {
      response = await AtendeeManagementRepository().getGetApiResponse();

      if (response == null || response['ticketTiers'].length == 0) {
        return 'No Events';
      } else {
        if (response['success'] == true) {
          for (int i = 0; i < response['ticketTiers'].length; i++) {
            String? currency = response['ticketTiers'][i]['price'].substring(0,1);
            String? price = response['ticketTiers'][i]['price']
                .substring(1, response['ticketTiers'][i]['price'].length);
            print(price);
            widget.allEventsTicketTierByuser.add([
              response['ticketTiers'][i]['tierName'],
              response['ticketTiers'][i]['maxCapacity'],
              price,
              currency
            ]);
          }
        }
        return response;
      }
    } catch (e) {
      return 'Network Error';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      child: FutureBuilder(
        future: jsonBodyToEventTicketTierList(),
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
                      child: Text('Refresh'))
                ],
              );
            } else if (snapshot.data == 'No Events') {
              return NoEvenTemplate('you haven\'t created any events yet');
            } else {
              return ListView.builder(
                itemCount: widget.allEventsTicketTierByuser.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, index) {
                  return ListTile(
                    leading: Icon(Icons.add),
                    title: Text(
                        widget.allEventsTicketTierByuser[index][0].toString()),
                    subtitle: Text(
                        'Maximum of ${widget.allEventsTicketTierByuser[index][1].toString()} per order'),
                    onTap: () {
                      print(widget
                                .allEventsTicketTierByuser[index][3]
                                .toString());
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => MyCustomizedNumpad(
                            priceOfTheTicketSelected: widget
                                .allEventsTicketTierByuser[index][2]
                                .toString(),
                          ),
                        ),
                      );
                    },
                    trailing: Text(
                        '${widget.allEventsTicketTierByuser[index][3].toString()}${widget.allEventsTicketTierByuser[index][2].toString()}'),
                  );
                },
              );
            }
          } else {
            return Text(
                'Error!'); //flutter gives me that the body will continue with null error so i added this
          }
        },
      ),
    );
  }
}
