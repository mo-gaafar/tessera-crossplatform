import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tessera/features/event_creation/cubit/createEvent_cubit.dart';
import 'package:tessera/features/event_creation/data/creator_reposiory.dart';
import 'package:tessera/features/event_creation/data/organiser_model.dart';
import 'package:tessera/features/event_creation/view/Widgets/no_event_template.dart';

class CreatorEventList extends StatefulWidget {
  late List<dynamic> allEventsData;
  OrganiserModel organiserModel;
  late String filterType;
  CreatorEventList({required this.filterType, required this.organiserModel});

  @override
  State<CreatorEventList> createState() => _CreatorEventListState();
}

class _CreatorEventListState extends State<CreatorEventList> {
  Future<dynamic> jsonBodyToCreatorEventList() async {
    late final response;
    try {
      response = await CreatorRepository.getAllEvents(
          widget.filterType, widget.organiserModel);
      List filteredEvents = response['filteredEvents'];
      List maxCapacity = response['maxCapacity'];
      List gross = response['gorss'];
      List eventSoldTickets = response['evetsoldtickets'];
      widget.allEventsData = eventSoldTickets;
      print(widget.allEventsData.runtimeType);
      print('All Events Data: ' + widget.allEventsData.toString());
      if (eventSoldTickets == null || eventSoldTickets.length == 0) {
        return 'No Events';
      } else {
        return eventSoldTickets;
      }
    } catch (e) {
      return 'Network Error'; //if netwrok is connected so the porblem will be in request [404 status] check with back end or try removing tr{}catch
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        setState(() {});
      },
      child: Center(
        child: FutureBuilder(
          future: jsonBodyToCreatorEventList(),
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
                return NoEvenTemplate(
                    'you don\'t have any ${widget.filterType} events');
              } else {
                return Container(
                  width: double.maxFinite,
                  padding: const EdgeInsets.all(10),
                  child: ListView.builder(
                    itemCount: widget.allEventsData.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, index) {
                      return ListTile(
                        leading: CircularProgressIndicator(
                            value: double.parse(
                          widget.allEventsData[index].toString(),
                        )),
                        title: Text(widget.allEventsData[index].toString()),
                        subtitle: Text(
                            '${widget.allEventsData[index].toString()} \n ${widget.allEventsData[index].toString()}'),
                        isThreeLine: true,
                        onTap: () {
                          print('navigator push to dashboard to the ID apge');
                        },
                      );
                    },
                  ),
                );
              }
            } else {
              return Text('Error!');
            }
          },
        ),
      ),
    );
  }
}
