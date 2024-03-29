import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tessera/constants/app_colors.dart';
import 'package:tessera/features/organizers_view/ticketing/view/pages/edit_tickets.dart';
import '../../cubit/event_tickets_cubit.dart';

import '../widgets/card.dart';

String scheduling(Map data) {
  String startDateTime = data['startSelling'];
  DateTime dateTime = DateTime.parse(startDateTime);
  DateTime currentTime = DateTime.now().toUtc();
  if (dateTime.isAfter(currentTime)) {
    return 'Scheduled';
  } else {
    return 'OnSale';
  }
}

class Admission extends StatelessWidget {
  const Admission({super.key, required this.ticketTiersList,required this.id});
  final List ticketTiersList;
  final String id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomAppBar(
          child: TextButton(
            onPressed: () {
              //to  publishing
              Navigator.pushNamed(
                              context,
                              '/publishPage',
                              arguments: id as String, //GIVING THE PRICE AS Int
                            );
            },
            child: Text(
              'Next',
              style: TextStyle(
                  fontFamily: 'NeuePlak',
                  color: Theme.of(context).textTheme.bodyLarge!.color,
                  fontSize: 25),
            ),
          ),
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            children: [
              BlocBuilder<EventTicketsCubit, EventTicketsState>(
                builder: (context, state) {
                  return Column(
                    children: [
                      for (int i = 0; i < ticketTiersList.length; i++)
                        TicketCard(
                            tierName: ticketTiersList[i]['tierName'],
                            saleSchedule: scheduling(ticketTiersList[i]),
                            tierPrice: ticketTiersList[i]['price'],
                            availableQuantity: ticketTiersList[i]
                                ['maxCapacity'],
                            onTap: () {
                              //to  edit
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditTickets(
                                        ticketName: ticketTiersList[i]
                                            ['tierName'],
                                        quantity: ticketTiersList[i]
                                            ['maxCapacity'],
                                        price: ticketTiersList[i]['price'],
                                        datetimestart: ticketTiersList[i]
                                            ['startSelling'],
                                        datetimeend: ticketTiersList[i]
                                            ['endSelling'], id: id,)),
                              );
                            }),
                    ],
                  );
                },
              ),
              SizedBox(
                height: 30,
              ),
              TextButton(
                onPressed: () {
                  context.read<EventTicketsCubit>().eventPricingdefault();
                  Navigator.pushNamed(
                              context,
                              '/addtickets',
                              arguments: id as String, //GIVING THE PRICE AS Int
                            );
                },
                child: Text(
                  'Add Tickets',
                  style: TextStyle(
                      fontFamily: 'NeuePlak',
                      color: Theme.of(context).colorScheme.onTertiaryContainer,
                      fontSize: 25),
                ),
              )
            ],
          ),
        )));
  }
}
