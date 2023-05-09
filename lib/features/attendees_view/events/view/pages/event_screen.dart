import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tessera/constants/app_colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tessera/features/attendees_view/events/cubit/event_book_cubit.dart';
import 'package:tessera/features/attendees_view/events/view/widgets/email_button.dart';
import 'package:tessera/features/attendees_view/events/data/event_data.dart';
import 'package:tessera/features/attendees_view/events/view/pages/see_more.dart';
import 'package:tessera/features/attendees_view/events/data/booking_data.dart';
import 'package:tessera/features/attendees_view/events/data/ticketing_data.dart';

///  A Screen that is directed to from landing page to show the details of the event

String getTheSmallestPrice(List tiers) {
  List prices = [];

  for (var i = 0; i < tiers.length; i++) {
    if (tiers[i]['price'] == 'Free') {
      return 'Free';
    }
    prices.add(double.parse(tiers[i]['price']));
  }
  double price = prices.reduce((curr, next) => curr < next ? curr : next);
  return price.toString();
}

List splitting(String data) {
  DateTime now = DateTime.parse(data);
  var formatter = DateFormat('EEEE, MMM d, yyyy');
  var formatted = formatter.format(now);
  var formatter1 = DateFormat.jm();
  var formatted1 = formatter1.format(now);

  return [formatted, formatted1];
}

List<String> teirsSplitting(String data) {
  int idx = data.indexOf(":");
  return [data.substring(0, idx).trim(), data.substring(idx + 1).trim()];
}

List<Map> ticketModels(List tiers, List capacity) {
  List<Map> data = [];
  for (var i = 0; i < tiers.length; i++) {
    data.add(TicketModel(
            capacityFull: capacity[i]['isCapacityFull'],
            nameAndPrice: tiers[i]['tierName'] + ':' + tiers[i]['price'])
        .toMap());
  }
  return data;
}

class EventPage extends StatefulWidget {
  const EventPage({super.key, required this.eventData, required this.iD});
  final EventModel eventData;
  final String iD;

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  late double disc = 1.0;
  late EventModel _eventData;
  late String id;
  final formKey = GlobalKey<FormState>();
  String tier = '';
  late List tiersToCheck = []; //index for each tier
  String promo = '';
  late List<Map> ticketsOfEvent = ticketModels(
      _eventData.filteredEvents[0]['ticketTiers'], _eventData.tierCapacityFull);
  late int indexOfSelectedEvent;
  late String smallestPrice =
      getTheSmallestPrice(_eventData.filteredEvents[0]['ticketTiers'])
          .toString();
  //POP UP
  Future<void> showInformationDialog(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          //bool isChecked = false;
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0))),
                content: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        for (int i = 0; i < ticketsOfEvent.length; i++)
                          Column(
                            children: [
                              Row(
                                children: [
                                  Radio(
                                      value: ticketsOfEvent[i]['nameAndPrice']
                                          .toString(),
                                      groupValue: tier,
                                      onChanged: (value) {
                                        setState(() {
                                          indexOfSelectedEvent =
                                              ticketsOfEvent.indexWhere((map) =>
                                                  map['nameAndPrice'] == value);
                                          if (ticketsOfEvent[
                                                      indexOfSelectedEvent]
                                                  ['capacityFull'] ==
                                              true) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                              duration: Duration(seconds: 2),
                                              // ignore: prefer_interpolation_to_compose_strings
                                              content:
                                                  Text('This tier is Full'),
                                              shape: StadiumBorder(),
                                              behavior:
                                                  SnackBarBehavior.floating,
                                            ));
                                          } else {
                                            tier = value.toString();
                                            ticketsOfEvent[indexOfSelectedEvent]
                                                ['ticketTierSelected'] = true;
                                            print('this tier not full');
                                            print(ticketsOfEvent);
                                          }
                                        });
                                      }),
                                  // ignore: prefer_interpolation_to_compose_strings
                                  Text(ticketsOfEvent[i]['nameAndPrice']
                                      .toString()),
                                ],
                              ),
                              //Tickets Addition and Subtraction
                            ],
                          ),
                        if (tier != '') ...[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      ticketsOfEvent[indexOfSelectedEvent]
                                              ['ticketsNumber'] =
                                          (ticketsOfEvent[indexOfSelectedEvent]
                                                  ['ticketsNumber'] +
                                              1);
                                      // ignore: avoid_print, prefer_interpolation_to_compose_strings
                                      print('selected tier: ' +
                                          ticketsOfEvent[indexOfSelectedEvent]
                                                  ['nameAndPrice']
                                              .toString());
                                    });
                                  },
                                  icon: const Icon(Icons.add)),
                              Text(ticketsOfEvent[indexOfSelectedEvent]
                                      ['ticketsNumber']
                                  .toString()),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      if (ticketsOfEvent[indexOfSelectedEvent]
                                              ['ticketsNumber'] >
                                          0) {
                                        ticketsOfEvent[indexOfSelectedEvent]
                                            ['ticketsNumber'] = (ticketsOfEvent[
                                                    indexOfSelectedEvent]
                                                ['ticketsNumber'] -
                                            1);
                                        // ignore: avoid_print, prefer_interpolation_to_compose_strings
                                        print('selected tier: ' +
                                            ticketsOfEvent[indexOfSelectedEvent]
                                                    ['nameAndPrice']
                                                .toString());
                                      }
                                    });
                                  },
                                  icon: const Icon(Icons.remove)),
                            ],
                          ),
                        ],
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Promocode',
                          ),
                          validator: (value) {
                            // ignore: avoid_print
                            print('da5al');
                            if (value == null || value.isEmpty) {
                              return null;
                            } else {
                              promo = value;
                              print(promo);
                            }
                          },
                        ),
                        Row(
                          children: [
                            TextButton(
                              child: const Text("Cancel"),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            TextButton(
                              child: const Text("CheckOut"),
                              onPressed: () async {
                                if (formKey.currentState!.validate()) {
                                  if (promo != '') {
                                    print('da5al promocode');
                                    var response = await context
                                        .read<EventBookCubit>()
                                        .promocodeValidity(promo, id);
                                    print(response);
                                    if (response['success'] == true) {
                                      disc = response['discout'] as double;
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        duration: Duration(seconds: 2),
                                        content: Text(
                                            response['message'].toString()),
                                        shape: StadiumBorder(),
                                        behavior: SnackBarBehavior.floating,
                                      ));
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        duration: Duration(seconds: 2),
                                        content: Text(
                                            response['message'].toString()),
                                        shape: StadiumBorder(),
                                        behavior: SnackBarBehavior.floating,
                                      ));
                                    }
                                  } else {
                                    print('mafesh promocode');
                                  }
                                  for (int k = 0;
                                      k < ticketsOfEvent.length;
                                      k++) {
                                    if (ticketsOfEvent[k]['isCapacityFull'] ==
                                        true) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        duration: const Duration(seconds: 2),
                                        // ignore: prefer_interpolation_to_compose_strings
                                        content: Text(ticketsOfEvent[k]
                                                    ['nameAndPrice']
                                                .toString() +
                                            'is Full'),
                                        shape: const StadiumBorder(),
                                        behavior: SnackBarBehavior.floating,
                                      ));
                                    }
                                  }
                                  print('tiers to be chosen');
                                  print(tiersToCheck.length);
                                  if (ticketsOfEvent
                                      .any((map) => map.containsValue(true))) {
                                    // ignore: avoid_print
                                    print('Checked out can happen');
                                    for (int k = 0;
                                        k < ticketsOfEvent.length;
                                        k++) {
                                      if (ticketsOfEvent[k]['ticketsNumber'] >
                                          0) {
                                       
                                        tiersToCheck.add(TicketTierSelected(
                                                tierName: teirsSplitting(
                                                    ticketsOfEvent[k]
                                                        ['nameAndPrice'])[0],
                                                quantity: ticketsOfEvent[k][
                                                    'ticketsNumber'], //price should be sent as String
                                                //teirsSplitting(ticketsOfEvent[k]['nameAndPrice'])[1].toInt()
                                                price: teirsSplitting(
                                                                ticketsOfEvent[
                                                                        k]
                                                                    [
                                                                    'nameAndPrice'])[
                                                            1])
                                            .toMap());
                                      }
                                    }
                                  }
                                  print('tiers of event');
                                  print(ticketsOfEvent.length);
                                  print('tiers to check out with');
                                  print(tiersToCheck);
                                  if (tiersToCheck.isNotEmpty) {
                                    print('Check out done');
                                    List arg = [
                                      true,
                                      tiersToCheck,
                                      _eventData,
                                      id,
                                      promo
                                    ];
                                    Navigator.pushNamed(
                                      context,
                                      '/checkOut',
                                      arguments: arg, //GIVING THE PRICE AS Int
                                    );
                                  } else {
                                    // ignore: avoid_print
                                    print(
                                        'No tier was chosen or no tickets were added');
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      duration: Duration(seconds: 2),
                                      content: Text(
                                          'Choose a tier and atleast one ticket'),
                                      shape: StadiumBorder(),
                                      behavior: SnackBarBehavior.floating,
                                    ));
                                  }
                                }
                              },
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ));
          });
        });
  }

  @override
  void initState() {
    super.initState();
    _eventData = widget.eventData; // initialize the attribute
    id = widget.iD; // initialize the attribute
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.lightBackground,
        bottomNavigationBar: BottomAppBar(
            //INCLUDES THE TICKET AND PRICE
            color: AppColors.lightBackground,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      textAlign: TextAlign.center,
                      smallestPrice,
                      style: TextStyle(
                          fontFamily: 'NeuePlak',
                          color: AppColors.textOnLight,
                          fontSize: 30),
                    ),
                  ),
                  Expanded(
                      flex: 3,
                      child: EmailButton(
                          buttonText: 'Ticket',
                          colourBackground: AppColors.primary,
                          colourText: AppColors.lightBackground,
                          //ticket
                          onTap: () async {
                            if (context.mounted) {
                              //String ticketTierName = _eventData.filteredEvents[0].ticketTiers[tierIndex].tierName;
                              if (_eventData.isEventCapacityFull == true) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  duration: Duration(seconds: 2),
                                  content: Text(
                                      'Unfourntly The event is fully booked'),
                                  shape: StadiumBorder(),
                                  behavior: SnackBarBehavior.floating,
                                ));
                              } else {
                                //free or charged
                                await showInformationDialog(context);
                              }
                            }
                          })),
                ],
              ),
            )),
        body: Scaffold(
          body: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                backgroundColor: Colors.transparent,
                shape: const ContinuousRectangleBorder(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(70),
                        bottomRight: Radius.circular(70))),
                leading: IconButton(
                    onPressed: () {
                      //back to event page
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close)),
                centerTitle: true,
                pinned: true,
                snap: false,
                floating: false,
                expandedHeight: 200.0,
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.pin,
                  centerTitle: true,
                  background: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30)),
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(_eventData.filteredEvents[0]
                            ['basicInfo']['eventImage']), //EVENT IMAGE
                      ),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Book a ticket to your newest adventure !',
                            style: TextStyle(
                                fontFamily: 'NeuePlak',
                                color: AppColors.lightBackground,
                                fontSize: 20),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        _eventData.filteredEvents[0]['basicInfo']['eventName'],
                        style: const TextStyle(
                            fontFamily: 'NeuePlak',
                            color: AppColors.textOnLight,
                            fontSize: 30),
                      ),
                      const SizedBox(
                        height: 10,
                      ),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.calendar_today,
                            size: 25,
                            color: AppColors.textOnLight,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //date text
                              Text(
                                splitting(_eventData.filteredEvents[0]
                                    ['basicInfo']['startDateTime'])[0],
                                style: const TextStyle(
                                    fontFamily: 'NeuePlak',
                                    color: Color.fromARGB(255, 44, 42, 42),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w100),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              //date text end
                              Text(
                                // ignore: prefer_interpolation_to_compose_strings
                                ' To ' +
                                    splitting(_eventData.filteredEvents[0]
                                        ['basicInfo']['endDateTime'])[0],
                                style: const TextStyle(
                                    fontFamily: 'NeuePlak',
                                    color: Color.fromARGB(255, 44, 42, 42),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w100),
                              ),
                              //time text
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            FontAwesomeIcons.clock,
                            size: 25,
                            color: AppColors.textOnLight,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //date text
                              Text(
                                splitting(_eventData.filteredEvents[0]
                                    ['basicInfo']['startDateTime'])[1],
                                style: const TextStyle(
                                    fontFamily: 'NeuePlak',
                                    color: AppColors.textOnLight,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w100),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              //date text end
                              Text(
                                // ignore: prefer_interpolation_to_compose_strings
                                ' To ' +
                                    splitting(_eventData.filteredEvents[0]
                                        ['basicInfo']['endDateTime'])[1],
                                style: const TextStyle(
                                    fontFamily: 'NeuePlak',
                                    color: AppColors.textOnLight,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w100),
                              ),
                              //time text
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.location_on,
                            size: 25,
                            color: AppColors.textOnLight,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //offline or online
                              if (_eventData.filteredEvents[0]['isOnline'] ==
                                  true) ...[
                                const Text(
                                  'Online',
                                  style: TextStyle(
                                      fontFamily: 'NeuePlak',
                                      color: AppColors.textOnLight,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w100),
                                ),
                                TextButton(
                                    onPressed: () {},
                                    child: const Text(
                                      'Click here to get to your event live ',
                                      style: TextStyle(
                                          fontFamily: 'NeuePlak',
                                          color: AppColors.textOnLight,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w100),
                                    ))
                              ] else ...[
                                const Text(
                                  'Offline',
                                  style: TextStyle(
                                      fontFamily: 'NeuePlak',
                                      color: AppColors.textOnLight,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w100),
                                ),
                                Text(
                                  _eventData.filteredEvents[0]['basicInfo']
                                      ['location']!['city'],
                                  style: const TextStyle(
                                      fontFamily: 'NeuePlak',
                                      color: AppColors.textOnLight,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w100),
                                )
                              ],
                              //location
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            FontAwesomeIcons.dollarSign,
                            size: 25,
                            color: AppColors.textOnLight,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Refund policy',
                                style: TextStyle(
                                    fontFamily: 'NeuePlak',
                                    color: AppColors.textOnLight,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w100),
                              ),
                              Text(
                                'Tessera\'s fee is non-refundabe',
                                style: TextStyle(
                                    fontFamily: 'NeuePlak',
                                    color: AppColors.textOnLight,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w100),
                              )
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),

                      for (int n = 0;
                          n <
                              _eventData
                                  .filteredEvents[0]['ticketTiers'].length;
                          n++)
                        if (_eventData.filteredEvents[0]['ticketTiers'][n]
                                ['price'] ==
                            'Free') ...[
                          Container(
                            decoration: BoxDecoration(
                              color: AppColors.primary.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'this event has a Free tier !',
                                style: TextStyle(
                                    fontFamily: 'NeuePlak',
                                    color: AppColors.lightBackground,
                                    fontSize: 20),
                              ),
                            ),
                          ),
                        ],
                      const Text(
                        'About',
                        style: TextStyle(
                            fontFamily: 'NeuePlak',
                            color: AppColors.textOnLight,
                            fontSize: 20,
                            fontWeight: FontWeight.w100),
                      ),
                      //desciption
                      Text(
                        _eventData.filteredEvents[0]['summary'],
                        style: const TextStyle(
                            fontFamily: 'NeuePlak',
                            color: AppColors.textOnLight,
                            fontSize: 15,
                            fontWeight: FontWeight.w100),
                      ),
                      TextButton(
                        onPressed: () {
                          //Navigator.pushNamed(context, '/third');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SeeMore(
                                title: _eventData.filteredEvents[0]['basicInfo']
                                    ['eventName'],
                                date: splitting(_eventData.filteredEvents[0]
                                    ['basicInfo']['startDateTime'])[0],
                                time: splitting(_eventData.filteredEvents[0]
                                    ['basicInfo']['startDateTime'])[1],
                                details: _eventData.filteredEvents[0]
                                    ['description'],
                                image: _eventData.filteredEvents[0]['basicInfo']
                                    ['eventImage'],
                              ),
                            ),
                          );
                        },
                        // ignore: sort_child_properties_last
                        child: const Text(
                          'see more',
                          style: TextStyle(
                              color: AppColors.secondary, fontSize: 20),
                        ),
                        style: ButtonStyle(
                            overlayColor:
                                MaterialStateProperty.resolveWith<Color?>(
                              (Set<MaterialState> states) {
                                if (states.contains(MaterialState.hovered)) {
                                  return AppColors.textOnLight
                                      .withOpacity(0.04);
                                }
                                if (states.contains(MaterialState.focused) ||
                                    states.contains(MaterialState.pressed)) {
                                  return AppColors.textOnLight
                                      .withOpacity(0.12);
                                }
                                return null; // Defer to the widget's default.
                              },
                            ),
                            padding: MaterialStateProperty.all<EdgeInsets>(
                                const EdgeInsets.all(0))),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      //how many tickets left/ full capacity or not
                      if (_eventData.filteredEvents[0]['creatorId'] ==
                          null) ...[
                        const Text(
                          'NO KNOWN ORGANIZER',
                          style: TextStyle(
                              fontFamily: 'NeuePlak',
                              color: AppColors.textOnLight,
                              fontSize: 20,
                              fontWeight: FontWeight.w100),
                        ),
                      ] else ...[
                        Row(
                          children: [
                            const Icon(
                              FontAwesomeIcons.addressCard,
                              size: 25,
                              color: AppColors.textOnLight,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              // ignore: prefer_interpolation_to_compose_strings
                              'organizers  ' +
                                  _eventData.filteredEvents[0]['creatorId']
                                      ['firstName'] +
                                  _eventData.filteredEvents[0]['creatorId']
                                      ['lastName'],
                              style: const TextStyle(
                                  fontFamily: 'NeuePlak',
                                  color: AppColors.textOnLight,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w100),
                            ),
                          ],
                        ),
                      ],
                      const SizedBox(
                        height: 10,
                      ),
                      if (_eventData.filteredEvents[0]['isEventFree'] ==
                          true) ...[
                        Container(
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: AppColors.primary, width: 2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'this event is Free !',
                              style: TextStyle(
                                  fontFamily: 'NeuePlak',
                                  color: AppColors.textOnLight,
                                  fontSize: 20),
                            ),
                          ),
                        ),
                      ] else ...[
                        Container(
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: AppColors.primary, width: 2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Dont miss and check the available tiers !',
                              style: TextStyle(
                                  fontFamily: 'NeuePlak',
                                  color: AppColors.textOnLight,
                                  fontSize: 20),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
