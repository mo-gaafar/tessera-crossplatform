import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tessera/features/authentication/cubit/auth_cubit.dart';
import 'package:tessera/features/organizers_view/dashboard/cubit/dashboard_cubit.dart';
import 'package:tessera/features/organizers_view/event_creation/cubit/createEvent_cubit.dart';
import 'package:tessera/features/organizers_view/event_creation/data/creator_reposiory.dart';
import 'package:tessera/features/organizers_view/event_creation/data/organiser_model.dart';
import 'package:tessera/features/organizers_view/event_creation/view/Widgets/no_event_template.dart';
import 'package:tessera/features/organizers_view/ticketing/cubit/event_tickets_cubit.dart';

class CreatorEventList extends StatefulWidget {
  OrganiserModel organiserModel;
  late String filterType;
  late List filteredEvents;
  late List gross;
  List<double> eventSoldTicketsPercentage = [];
  List<String> eventSoldTicketsPercentageToString = [];
  CreatorEventList({required this.filterType, required this.organiserModel});

  @override
  State<CreatorEventList> createState() => _CreatorEventListState();
}

class _CreatorEventListState extends State<CreatorEventList> {
  Future<dynamic> jsonBodyToCreatorEventList(String token) async {
    late final response;
    try {
      response = await CreatorRepository.getAllEvents(widget.filterType, token);
      print(response);
      widget.filteredEvents = response['filteredEvents'];
      widget.gross = response['gross'];

      if (widget.filteredEvents == null || widget.filteredEvents.length == 0) {
        return 'No Events';
      } else {
        for (int i = 0; i < widget.filteredEvents.length; i++) {
          if (response['maxCapacity'][i] == 0) {
            if (widget.filterType == 'draft') {
              widget.eventSoldTicketsPercentage.add(0.0);
              widget.eventSoldTicketsPercentageToString.add(
                  '${response['eventsoldtickets'][i]}/${response['maxCapacity'][i]}');
            } else {
              return 'Max Capacity equal 0?!!';
            }
          } else {
            widget.eventSoldTicketsPercentage.add(
                response['eventsoldtickets'][i] / response['maxCapacity'][i]);
            widget.eventSoldTicketsPercentageToString.add(
                '${response['eventsoldtickets'][i]}/${response['maxCapacity'][i]}');
          }
        }
        return widget.filteredEvents;
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
      child: FutureBuilder(
        future: jsonBodyToCreatorEventList(
            context.select((AuthCubit auth) => auth.currentUser.accessToken!)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: const CircularProgressIndicator());
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
                child: Align(
                  alignment: Alignment.topCenter,
                  child: ListView.builder(
                    itemCount: widget.filteredEvents.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, index) {
                      return ListTile(
                        leading: CircularProgressIndicator(
                          value: (widget.eventSoldTicketsPercentage[index]),
                          backgroundColor: Colors.grey,
                          color: Colors.green,
                        ), //value in percentage
                        title: Text(widget.filteredEvents[index]["basicInfo"]
                                ['eventName']
                            .toString()),
                        subtitle: Text(
                            '${widget.filteredEvents[index]["basicInfo"]['startDateTime'].toString()} \n ${widget.eventSoldTicketsPercentageToString[index]}'),
                        isThreeLine: true,
                        onTap: () async {
                          if (widget.filterType != 'draft') {
                            context.read<DashboardCubit>().eventId =
                                widget.filteredEvents[index]['eventId'];
                            Navigator.pushNamed(context, '/dashboard');
                          } else {
                            var resp = await context
                                .read<EventTicketsCubit>()
                                .getTicketsData(
                                    widget.filteredEvents[index]['eventId']);
                            if (resp['success'] == true) {
                              Navigator.pushNamed(
                                context,
                                '/ticketspage',
                                arguments: resp['ticketTiers']
                                    as List, //GIVING THE PRICE AS Int
                              );
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                duration: Duration(seconds: 3),
                                // ignore: prefer_interpolation_to_compose_strings
                                content: Text(resp['message'] as String),
                                shape: StadiumBorder(),
                                behavior: SnackBarBehavior.floating,
                              ));
                            }
                          }
                        },
                        trailing: Text("£${widget.gross[index].toString()}"),
                      );
                    },
                  ),
                ),
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
