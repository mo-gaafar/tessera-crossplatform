import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tessera/constants/app_colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tessera/features/events/view/widgets/email_button.dart';
import 'package:tessera/features/events/data/event_data.dart';
import 'package:tessera/features/events/view/pages/see_more.dart';
import 'package:tessera/features/events/view/pages/check_out.dart';
import 'package:tessera/features/events/data/booking_data.dart';

///  A Screen that is directed to from landing page to show the details of the event

List splitting(String data) {
  DateTime now = DateTime.parse(data);
  var formatter = DateFormat('EEEE, MMM d, yyyy');
  var formatted = formatter.format(now);
  var formatter1 = DateFormat.jm();
  var formatted1 = formatter1.format(now);

  return [formatted, formatted1];
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
  late int tierIndex = 0;
  String promo = '';
  int count = 1;
  late List ticketList = [];

  //POP UP
  Future<void> showInformationDialog(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          //bool isChecked = false;
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
                shape: RoundedRectangleBorder(
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
                          Row(
                            children: [
                              Radio(
                                  value: _eventData.filteredEvents[0]
                                          ['ticketTiers'][i]['tierName']
                                      .toString(),
                                  groupValue: tier,
                                  onChanged: (value) {
                                    setState(() {
                                      tier = value.toString();
                                      tierIndex = i;
                                    });
                                  }),
                              Text(_eventData.filteredEvents[0]['ticketTiers']
                                      [i]['tierName'] +
                                  ' -  Price: ' +
                                  _eventData.filteredEvents[0]['ticketTiers'][i]
                                      ['price'])
                            ],
                          ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    count++;
                                  });
                                },
                                icon: const Icon(Icons.add)),
                            Text(count.toString()),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (count > 0) {
                                      count--;
                                    }
                                  });
                                },
                                icon: const Icon(Icons.remove)),
                          ],
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Promocode',
                          ),
                          validator: (value) {
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
                              child: const Text("Save"),
                              onPressed: () {
                                if (_eventData.tierCapacityFull[tierIndex]
                                        ['isCapacityFull'] ==
                                    true) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    duration: Duration(seconds: 2),
                                    content: Text('This tier is Full'),
                                    shape: StadiumBorder(),
                                    behavior: SnackBarBehavior.floating,
                                  ));
                                } else {
                                  ticketList.add(TicketTierSelected(
                                          tierName: _eventData.filteredEvents[0]
                                                  ['ticketTiers'][tierIndex]
                                              ['tierName'],
                                          quantity: count,
                                          price: 20)
                                      .toMap());
                                  count = 1;
                                  print(count);
                                  tier = '';
                                }
                              },
                            ),
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
                                  if (_eventData.tierCapacityFull[tierIndex]
                                          ['isCapacityFull'] ==
                                      true) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      duration: Duration(seconds: 2),
                                      content: Text('This tier is Full'),
                                      shape: StadiumBorder(),
                                      behavior: SnackBarBehavior.floating,
                                    ));
                                  } else if (ticketList.isEmpty) {
                                    print('hereee');
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      duration: Duration(seconds: 2),
                                      content: Text('Choose a tier'),
                                      shape: StadiumBorder(),
                                      behavior: SnackBarBehavior.floating,
                                    ));
                                  } else {
                                    print('here');
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => CheckOut(
                                            charge: _eventData.isEventFree,
                                            ticketTier:
                                                ticketList), //GIVING THE PRICE AS STRING
                                      ),
                                    );
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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          _eventData.filteredEvents[0]['basicInfo']
              ['eventName'], //APP BAR EVENT NAME
          style: TextStyle(
              fontFamily: 'NeuePlak',
              color: AppColors.lightBackground,
              fontSize: 25),
        ),
        //backgroundColor: AppColors.primary,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context); //back to landing page
            },
            icon: Icon(
              Icons.close,
              color: AppColors.secondaryTextOnLight,
            )),
      ),
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
                    _eventData.filteredEvents[0]['ticketTiers'][tierIndex]
                            ['price']
                        .toString(),
                    style: const TextStyle(
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
                        colourText: Colors.white,
                        //ticket
                        onTap: () async {
                          if (context.mounted) {
                            //String ticketTierName = _eventData.filteredEvents[0].ticketTiers[tierIndex].tierName;
                            if (_eventData.isEventCapacityFull == true) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
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
      backgroundColor: AppColors.lightBackground,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(_eventData.filteredEvents[0]
                        ['basicInfo']['eventImage']), //EVENT IMAGE
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                _eventData.filteredEvents[0]['basicInfo']['eventName'],
                style: TextStyle(
                    fontFamily: 'NeuePlak',
                    color: AppColors.textOnLight,
                    fontSize: 30),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.calendar_today,
                    size: 25,
                    color: AppColors.textOnLight,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //date text
                      Text(
                        splitting(_eventData.filteredEvents[0]['ticketTiers']
                            [tierIndex]['startSelling'])[0],
                        style: TextStyle(
                            fontFamily: 'NeuePlak',
                            color: Color.fromARGB(255, 44, 42, 42),
                            fontSize: 20,
                            fontWeight: FontWeight.w100),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      //date text end
                      Text(
                        ' To ' +
                            splitting(_eventData.filteredEvents[0]
                                ['ticketTiers'][tierIndex]['endSelling'])[0],
                        style: TextStyle(
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
              SizedBox(
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
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //date text
                      Text(
                        splitting(_eventData.filteredEvents[0]['ticketTiers']
                            [tierIndex]['startSelling'])[1],
                        style: TextStyle(
                            fontFamily: 'NeuePlak',
                            color: Color.fromARGB(255, 44, 42, 42),
                            fontSize: 20,
                            fontWeight: FontWeight.w100),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      //date text end
                      Text(
                        ' To ' +
                            splitting(_eventData.filteredEvents[0]
                                ['ticketTiers'][tierIndex]['endSelling'])[1],
                        style: TextStyle(
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
              SizedBox(
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
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //offline or online
                      if (_eventData.filteredEvents[0]['isOnline'] == true) ...[
                        Text(
                          'Online',
                          style: TextStyle(
                              fontFamily: 'NeuePlak',
                              color: Color.fromARGB(255, 44, 42, 42),
                              fontSize: 20,
                              fontWeight: FontWeight.w100),
                        ),
                        TextButton(
                            onPressed: () {},
                            child: Text(
                              'Click here to get to your event live ',
                              style: TextStyle(
                                  fontFamily: 'NeuePlak',
                                  color: Color.fromARGB(255, 44, 42, 42),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w100),
                            ))
                      ] else ...[
                        Text(
                          'Offline',
                          style: TextStyle(
                              fontFamily: 'NeuePlak',
                              color: Color.fromARGB(255, 44, 42, 42),
                              fontSize: 20,
                              fontWeight: FontWeight.w100),
                        ),
                        Text(
                          _eventData.filteredEvents[0]['basicInfo']
                              ['location']!['city'],
                          style: TextStyle(
                              fontFamily: 'NeuePlak',
                              color: Color.fromARGB(255, 44, 42, 42),
                              fontSize: 20,
                              fontWeight: FontWeight.w100),
                        )
                      ],
                      //location
                    ],
                  )
                ],
              ),
              SizedBox(
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
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Refund policy',
                        style: TextStyle(
                            fontFamily: 'NeuePlak',
                            color: Color.fromARGB(255, 44, 42, 42),
                            fontSize: 20,
                            fontWeight: FontWeight.w100),
                      ),
                      Text(
                        'Tessera\'s fee is non-refundabe',
                        style: TextStyle(
                            fontFamily: 'NeuePlak',
                            color: Color.fromARGB(255, 44, 42, 42),
                            fontSize: 20,
                            fontWeight: FontWeight.w100),
                      )
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'About',
                style: TextStyle(
                    fontFamily: 'NeuePlak',
                    color: Color.fromARGB(255, 44, 42, 42),
                    fontSize: 20,
                    fontWeight: FontWeight.w100),
              ),
              //desciption
              Text(
                _eventData.filteredEvents[0]['summary'],
                style: TextStyle(
                    fontFamily: 'NeuePlak',
                    color: Color.fromARGB(255, 44, 42, 42),
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
                              ['ticketTiers'][tierIndex]['startSelling'])[0],
                          time: splitting(_eventData.filteredEvents[0]
                              ['ticketTiers'][tierIndex]['startSelling'])[1],
                          details: _eventData.filteredEvents[0]['description']),
                    ),
                  );
                },
                child: Text(
                  'see more',
                  style: TextStyle(color: AppColors.secondary, fontSize: 20),
                ),
                style: ButtonStyle(
                    overlayColor: MaterialStateProperty.resolveWith<Color?>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.hovered)) {
                          return AppColors.textOnLight.withOpacity(0.04);
                        }
                        if (states.contains(MaterialState.focused) ||
                            states.contains(MaterialState.pressed)) {
                          return AppColors.textOnLight.withOpacity(0.12);
                        }
                        return null; // Defer to the widget's default.
                      },
                    ),
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.all(0))),
              ),
              SizedBox(
                height: 10,
              ),
              //how many tickets left/ full capacity or not
              if (_eventData.filteredEvents[0]['creatorId'] == null) ...[
                Text(
                  'NO KNOWN ORGANIZER',
                  style: TextStyle(
                      fontFamily: 'NeuePlak',
                      color: Color.fromARGB(255, 44, 42, 42),
                      fontSize: 20,
                      fontWeight: FontWeight.w100),
                ),
              ] else ...[
                Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.addressCard,
                      size: 25,
                      color: AppColors.textOnLight,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'organizers  ' +
                          _eventData.filteredEvents[0]['creatorId']
                              ['firstName'] +
                          _eventData.filteredEvents[0]['creatorId']['lastName'],
                      style: TextStyle(
                          fontFamily: 'NeuePlak',
                          color: Color.fromARGB(255, 44, 42, 42),
                          fontSize: 20,
                          fontWeight: FontWeight.w100),
                    ),
                  ],
                ),
              ],
              const SizedBox(
                height: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
