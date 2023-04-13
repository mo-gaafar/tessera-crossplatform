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

class EventPage extends StatefulWidget {
  const EventPage({super.key});

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  late EventModel eventData;
  @override
  void initState() async {
    super.initState();
    // Add listeners to this class
    eventData = await context
        .read<EventBookCubit>()
        .getEventData('6427c9ffd13c6e22aab0a743');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        title: Text(
          eventData.eventName,
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
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: Text(
                textAlign: TextAlign.center,
                eventData.ticketTiersPrice.toString(),
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
                    onTap: () async{
                      if( await context.read<EventBookCubit>().eventFull('6427c9ffd13c6e22aab0a743')==true)
                      {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        duration: Duration(seconds: 2),
                        content: Text('The event is fully booked'),
                        shape: StadiumBorder(),
                        behavior: SnackBarBehavior.floating,
                        ));

                      }
                      else
                      {
                        //free or charged
                          showAlertDialog(context,eventData.promoCodesAvailable,eventData.ticketTiersPrice);
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
                    image: AssetImage('assets/images/LogoFullTextTicketSmall.png'),
                  ),
                ),
              ),
              Text(
                eventData.eventName,
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
                         eventData.startDateTimeUtc,
                        style: TextStyle(
                            fontFamily: 'NeuePlak',
                            color: Color.fromARGB(255, 44, 42, 42),
                            fontSize: 20,
                            fontWeight: FontWeight.w100),
                      ),
                      //time text
                      Text(
                        eventData.startDateTimeUtc,
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
                      Text(
                        eventData.eventStatus,
                        style: TextStyle(
                            fontFamily: 'NeuePlak',
                            color: Color.fromARGB(255, 44, 42, 42),
                            fontSize: 20,
                            fontWeight: FontWeight.w100),
                      ),
                      //location
                      Text(
                        eventData.location,
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
                eventData.description,
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
                MaterialPageRoute(builder: (context) =>SeeMore(title: eventData.eventName, date: eventData.startDateTimeUtc, time: eventData.startDateTimeUtc, details: eventData.description),),);
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
               Text(
                      eventData.v.toString() +'tickts'+'left',
                      style: TextStyle(
                          fontFamily: 'NeuePlak',
                          color: Color.fromARGB(255, 44, 42, 42),
                          fontSize: 15,
                          fontWeight: FontWeight.w100),
                    ),
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
