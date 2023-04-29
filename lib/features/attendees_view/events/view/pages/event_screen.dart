import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tessera/constants/app_colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tessera/features/attendees_view/events/view/widgets/email_button.dart';
import 'package:tessera/features/attendees_view/events/data/event_data.dart';
import 'package:tessera/features/attendees_view/events/view/pages/see_more.dart';
import 'package:tessera/features/attendees_view/events/view/pages/check_out.dart';
import 'package:tessera/features/attendees_view/events/data/booking_data.dart';

///  A Screen that is directed to from landing page to show the details of the event

List splitting(String data) {
  DateTime now = DateTime.parse(data);
  var formatter = DateFormat('EEEE, MMM d, yyyy');
  var formatted = formatter.format(now);
  var formatter1 = DateFormat.jm();
  var formatted1 = formatter1.format(now);

  return [formatted, formatted1];
}

List teirsIndeces(int len) {
  List data = [];
  for (var i = 0; i < len; i++) {
    data.add(i);
  }
  return data;
}

List<String> teirsStrings(List map) {
  List<String> data = [];
  for (var i = 0; i < map.length; i++) {
    data.add(map[i]['tierName']);
  }
  return data;
}

List<bool> teirsCapacity(List map) {
  List<bool> data = [];
  for (var i = 0; i < map.length; i++) {
    data.add(map[i]['isCapacityFull']);
  }
  return data;
}

class EventPage extends StatefulWidget {
  const EventPage({super.key, required this.eventData});
  final EventModel eventData;

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  late EventModel _eventData;
  final formKey = GlobalKey<FormState>();
  String tier = '';
  late List tiersToCheck = []; //index for each tier
  String promo = '';

  late List<int> count = List.filled(
      _eventData.filteredEvents[0]['ticketTiers'].length,
      0); //each tier has a count initialized with zero
  late List<String> tiers = teirsStrings(
      _eventData.filteredEvents[0]['ticketTiers']); //list of the tiers
  late Map<String, int> ticketTiersNumber =
      Map.fromIterables(tiers, count); //Map of tiers and the tickets

  late List<bool> tiersCap = teirsCapacity(_eventData.tierCapacityFull);
  late Map<String, bool> ticketTiersCap =
      Map.fromIterables(tiers, tiersCap); //Map of tiers and their capacity

  late List<bool> tiersChosen =
      List.filled(_eventData.filteredEvents[0]['ticketTiers'].length, false);
  late Map<String, bool> ticketTiersChosen = Map.fromIterables(
      tiers, tiersChosen); //Map of tiers and if they are chosen

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
                        for (int i = 0;
                            i <
                                _eventData
                                    .filteredEvents[0]['ticketTiers'].length;
                            i++)
                          Column(
                            children: [
                              Row(
                                children: [
                                  Radio(
                                      value: _eventData.filteredEvents[0]
                                              ['ticketTiers'][i]['tierName']
                                          .toString(),
                                      groupValue: tier,
                                      onChanged: (value) {
                                        setState(() {
                                          if (ticketTiersCap[value] == true) {
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
                                            ticketTiersChosen[tier] = true;
                                            print('this tier not full');
                                            print(ticketTiersChosen);
                                          }
                                        });
                                      }),
                                  Text(_eventData.filteredEvents[0]
                                          ['ticketTiers'][i]['tierName'] +
                                      ' -  Price: ' +
                                      _eventData.filteredEvents[0]
                                          ['ticketTiers'][i]['price']),
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
                                      ticketTiersNumber[tier] =
                                          (ticketTiersNumber[tier]! + 1);
                                      // ignore: avoid_print, prefer_interpolation_to_compose_strings
                                      print(tier+
                                      ' :' + ticketTiersNumber[tier].toString());
                                      
                                    });
                                  },
                                  icon: const Icon(Icons.add)),
                              Text(ticketTiersNumber[tier].toString()),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      if (ticketTiersNumber[tier]! > 0) {
                                        ticketTiersNumber[tier] =
                                            (ticketTiersNumber[tier]! - 1);
                                        // ignore: avoid_print, prefer_interpolation_to_compose_strings
                                        print(tier+
                                      ' :' + ticketTiersNumber[tier].toString());
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
                              if (value == 'spring') {
                                promo = value;
                                return null;
                              } else {
                                return 'Not a valid promocode';
                              }
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
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                    for (int k = 0;
                                        k <
                                            _eventData
                                                .filteredEvents[0]['ticketTiers']
                                                .length;
                                        k++) {
                                      if (_eventData.tierCapacityFull[k]
                                              ['isCapacityFull'] ==
                                          true) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          duration: const Duration(seconds: 2),
                                          // ignore: prefer_interpolation_to_compose_strings
                                          content: Text(_eventData
                                                  .filteredEvents[0]
                                                      ['ticketTiers'][k]
                                                      ['tierName']
                                                  .toString() +
                                              'is Full'),
                                          shape: const StadiumBorder(),
                                          behavior: SnackBarBehavior.floating,
                                        ));
                                      }
                                        }
                                    if (ticketTiersChosen.containsValue(true)) {
                                      // ignore: avoid_print
                                      print('Checked out can happen');
                                      for (int k = 0;
                                          k <
                                              _eventData
                                                  .filteredEvents[0]
                                                      ['ticketTiers']
                                                  .length;
                                          k++) {
                                        if (ticketTiersNumber[tiers[k]]!>0) {
                                          tiersToCheck.add(TicketTierSelected(
                                                  tierName: tiers[k],
                                                  quantity: ticketTiersNumber[
                                                      tiers[k]]!,
                                                  price: 20)
                                              .toMap());
                                        }
                                      }
                                    }
                                      print(tiersToCheck);
                                  if(tiersToCheck.isNotEmpty)
                                  {
                                    print('Check out done');
                                    Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CheckOut(
                                        //charge: _eventData.isEventFree,
                                          charge: true,
                                          ticketTier:
                                              tiersToCheck), //GIVING THE PRICE AS STRING
                                    ),
                                  );
                                    } else {
                                      // ignore: avoid_print
                                      print('No tier was chosen or no tickets were added');
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        duration: Duration(seconds: 2),
                                        content: Text('Choose a tier and atleast one ticket'),
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
                  const Expanded(
                    child: Text(
                      textAlign: TextAlign.center,
                      'price',
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
                      Navigator.pushNamed(context, '/landingPage');
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
