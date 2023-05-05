import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tessera/features/event_creation/cubit/createEvent_cubit.dart';
import 'package:tessera/features/event_creation/data/creator_reposiory.dart';
import 'package:tessera/features/event_creation/data/organiser_model.dart';
import 'package:tessera/features/event_creation/view/Widgets/no_event_template.dart';
import 'package:tessera/features/event_creation/view/Pages/my_customized_numpad.dart';

class AtendeeEventsList extends StatefulWidget {
  AtendeeEventsList({super.key});
  List allEventsByuser = [
    ['Hi', '5', '1.60', '£'],['bye', '10', '1.90', '£']
  ];
  //EventName,AvailableTickets,price,currency
  @override
  State<AtendeeEventsList> createState() => _AtendeeEventsListState();
}

class _AtendeeEventsListState extends State<AtendeeEventsList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      child: ListView.builder(
        itemCount: widget.allEventsByuser.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, index) {
          return ListTile(
            leading: const Icon(Icons.add),
            title: Text(widget.allEventsByuser[index][0].toString()),
            subtitle: Text(
                'Maximum of ${widget.allEventsByuser[index][1].toString()} per order'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => MyCustomizedNumpad(),
                ),
              );
              var typedInTickets =
                  context.read<CreateEventCubit>().currentEvent.tickets;
              if (typedInTickets != null) {
                if (int.parse(typedInTickets) >
                    int.parse(widget.allEventsByuser[index][1])) {
                  context.read<CreateEventCubit>().currentEvent.tickets =
                      widget.allEventsByuser[index][1].toString();
                  widget.allEventsByuser[index][1] = '0';
                } else {
                  widget.allEventsByuser[index][1] =
                      (int.parse(widget.allEventsByuser[index][1]) -
                              int.parse(typedInTickets))
                          .toString();
                }
              }
              setState(() {});
            },
            trailing: Text(
                '${widget.allEventsByuser[index][3].toString()}${widget.allEventsByuser[index][2].toString()}'),
          );
        },
      ),
    );
  }
}
