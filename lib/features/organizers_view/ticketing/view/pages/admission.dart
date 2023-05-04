import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tessera/constants/app_colors.dart';
import 'package:tessera/features/organizers_view/ticketing/view/pages/edit_tickets.dart';
import '../../cubit/event_tickets_cubit.dart';
import '../../cubit/tickets_store.dart';
import '../../cubit/tickets_store_cubit.dart';
import '../widgets/card.dart';

String scheduling(Map data) {
  String startDate = data['startDate'];
  //String endDate=data['endDate'];
  String startTime = data['startTime'];
  //String endTime=data['endTime'];
  DateTime date = DateTime.now();
  DateTime dt =
      DateFormat('yyyy-MM-dd hh:mm a').parse(startDate + ' ' + startTime);
  if (dt.isAfter(date)) {
    return 'Scheduled';
  } else {
    return 'OnSale';
  }
}

class Admission extends StatelessWidget {
  const Admission({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
        bottomNavigationBar: BottomAppBar(
          child: TextButton(
            onPressed: () {
              //to  publishing
              Navigator.pushNamed(context, '/publishPage');
            },
            child: Text(
              'Next',
              style: TextStyle(
                  fontFamily: 'NeuePlak',
                  color: AppColors.secondaryTextOnLight,
                  fontSize: 25),
            ),
          ),
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            children: [
              BlocBuilder<MyCubit, MyCubitState>(
                builder: (context, state) {
                  List tickets = state.myDataList;
                  print(tickets);
                  return Column(
                    children: [
                      for (int i = 0; i < tickets.length; i++)
                        TicketCard(
                            tierName: tickets[i]['name'],
                            saleSchedule: scheduling(tickets[i]),
                            tierPrice: tickets[i]['price'],
                            availableQuantity: tickets[i]['quantity'],
                            numberOfCard: i,
                            onTap: () {
                              //to  edit
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) =>   EditTickets(
                                  ticketName: tickets[i]['name'],
                                  quantity: tickets[i]['quantity'],
                                  price: tickets[i]['price'],
                                  datestart: tickets[i]['startDate'],
                                  timestart: tickets[i]['startTime'],
                                  dateend: tickets[i]['endDate'],
                                  timeend: tickets[i]['endTime'], index: i,)),
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
                  Navigator.pushNamed(context, '/addtickets');
                },
                child: Text(
                  'Add Tickets',
                  style: TextStyle(
                      fontFamily: 'NeuePlak',
                      color: AppColors.secondaryTextOnLight,
                      fontSize: 25),
                ),
              )
            ],
          ),
        )));
  }
}
