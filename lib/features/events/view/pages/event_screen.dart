import 'package:flutter/material.dart';
import 'package:tessera/constants/app_colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tessera/features/events/view/widgets/email_button.dart';
import 'package:tessera/features/events/view/widgets/rounded_button.dart';
import 'package:tessera/features/events/cubit/event_book_cubit.dart';
import 'package:provider/provider.dart';
import 'package:tessera/features/events/data/event_data.dart';
import 'package:tessera/features/events/view/widgets/pop_up.dart';
import 'package:tessera/features/events/view/pages/see_more.dart';
import 'package:tessera/features/events/view/pages/check_out.dart';

List splitting(String data) {
  int idx = data.indexOf(":");
  return [data.substring(0, idx).trim(), data.substring(idx + 1).trim()];
}

List<String> addTier(var data) {
  List<String> ticketTierAndprice = [];
  for (int i = 0; i < data.filteredEvents[0]['ticketTiers'].length; i++)
    ticketTierAndprice.add(data.filteredEvents[0]['ticketTiers'][i]
            ['tierName'].toString() +
        data.filteredEvents[0]['ticketTiers'][i]['price']..toString());

  return ticketTierAndprice;
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
  int count = 0;

  //POP UP
  Future<void> showInformationDialog(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          //bool isChecked = false;
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
                content: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    for (int i = 0;
                        i < _eventData.filteredEvents[0]['ticketTiers'].length;
                        i++)
                      Row(
                        children: [
                          Radio(
                              value: _eventData.filteredEvents[0]['ticketTiers']
                                      [i]['tierName']
                                  .toString(),
                              groupValue: tier,
                              onChanged: (value) {
                                setState(() {
                                  tier = value.toString();
                                  tierIndex = i;
                                });
                              }),
                          Text(_eventData.filteredEvents[0]['ticketTiers'][i]
                              ['tierName'])
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
                                count--;
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
                          child: const Text("Cancel"),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        TextButton(
                          child: const Text("CheckOut"),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CheckOut(
                                      feesText: _eventData.filteredEvents[0]
                                              ['ticketTiers'][tierIndex]
                                              ['price']
                                          .toString(),
                                      ticketTier: _eventData.filteredEvents[0]
                                              ['ticketTiers'][tierIndex][
                                          'tierName']), //GIVING THE PRICE AS STRING
                                ),
                              );
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
      appBar: AppBar(
        elevation: 3,
        title: Text(
          _eventData.filteredEvents[0]['basicInfo']
              ['eventName'], //APP BAR EVENT NAME
          style: TextStyle(
              fontFamily: 'NeuePlak', color: Colors.white, fontSize: 25),
        ),
        backgroundColor: AppColors.primary,
        leading: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/'); //back to landing page
            },
            icon: Icon(Icons.close)),
      ),
      bottomNavigationBar: BottomAppBar(
          //INCLUDES THE TICKET AND PRICE
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: Text(
                textAlign: TextAlign.center,
                _eventData.filteredEvents[0]['ticketTiers'][tierIndex]['price']
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
                        if (_eventData.tierCapacityFull[tierIndex]
                                ['isCapacityFull'] ==
                            true) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            duration: Duration(seconds: 2),
                            content:
                                Text('Unfourntly The event is fully booked'),
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
      backgroundColor: Colors.white,
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
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(_eventData.filteredEvents[0]
                        ['basicInfo']['eventImage']), //EVENT IMAGE
                  ),
                ),
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
                  const Icon(Icons.calendar_today, size: 25),
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
                      //date text end
                      Text(
                        'to' +
                            splitting(_eventData.filteredEvents[0]
                                ['ticketTiers'][tierIndex]['endSelling'])[0],
                        style: TextStyle(
                            fontFamily: 'NeuePlak',
                            color: Color.fromARGB(255, 44, 42, 42),
                            fontSize: 20,
                            fontWeight: FontWeight.w100),
                      ),
                      //time text
                      Text(
                        splitting(_eventData.filteredEvents[0]['ticketTiers']
                            [tierIndex]['startSelling'])[1],
                        style: TextStyle(
                            fontFamily: 'NeuePlak',
                            color: Color.fromARGB(255, 44, 42, 42),
                            fontSize: 20,
                            fontWeight: FontWeight.w100),
                      ),
                      //time text end
                      Text(
                        'to' +
                            splitting(_eventData.filteredEvents[0]
                                ['ticketTiers'][tierIndex]['endSelling'])[1],
                        style: TextStyle(
                            fontFamily: 'NeuePlak',
                            color: Color.fromARGB(255, 44, 42, 42),
                            fontSize: 20,
                            fontWeight: FontWeight.w100),
                      ),
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
                  const Icon(Icons.location_on, size: 25),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //offline or online
                      if (_eventData.filteredEvents[0]['isOnline'] == true) ...[
                        Text(
                          'online',
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
                  const Icon(FontAwesomeIcons.dollarSign, size: 25),
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
                height: 20,
              ),
              //how many tickets left/ full capacity or not
              /*if (_eventData.filteredEvents[0]['creatorId'] == null) ...[
                Text(
                  'NO KNOWN ORGANIZER',
                  style: TextStyle(
                      fontFamily: 'NeuePlak',
                      color: Color.fromARGB(255, 44, 42, 42),
                      fontSize: 20,
                      fontWeight: FontWeight.w100),
                ),
              ] else ...[
                Text(
                  'organizers name:' +
                      _eventData.filteredEvents[0]['creatorId']['firstName'] +
                      _eventData.filteredEvents[0]['creatorId']['lasttName'],
                  style: TextStyle(
                      fontFamily: 'NeuePlak',
                      color: Color.fromARGB(255, 44, 42, 42),
                      fontSize: 20,
                      fontWeight: FontWeight.w100),
                ),
              ],*/
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
