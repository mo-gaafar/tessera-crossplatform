import 'package:flutter/material.dart';
import 'package:tessera/constants/app_colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tessera/features/Booking/view/widgets/email_button.dart';
import 'package:tessera/features/Booking/view/widgets/rounded_button.dart';

class EventPage extends StatelessWidget {
  final String headerImage;
  final String organizerName;
  final String headerText;
  final String dateText;
  final String timeText;
  final String placeText;
  final String locationText;
  final String feesText; //money or free
  final String aboutText; //for see more
  final String buttonText;
  final String seemoreButton;
  final Function()? onTap_ticket;
  final Function()? onTap_seeMore;

  const EventPage({
    Key? key,
    required this.headerImage,
    required this.organizerName,
    required this.headerText,
    required this.dateText,
    required this.timeText,
    required this.placeText,
    required this.locationText,
    required this.feesText,
    required this.aboutText,
    required this.buttonText,
    required this.seemoreButton,
    this.onTap_ticket,
    this.onTap_seeMore,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        title: Text(
          headerText,
          style: TextStyle(
              fontFamily: 'NeuePlak', color: Colors.white, fontSize: 25),
        ),
        backgroundColor: AppColors.primary,
        leading: IconButton(
              onPressed: () {
                Navigator.pushNamed(context,'/');
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
                feesText,
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
                    colourText: Colors.white,
                    onTap: onTap_ticket)),
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
                    image: AssetImage(headerImage),
                  ),
                ),
              ),
              Text(
                headerText,
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
                      Text(
                        dateText,
                        style: TextStyle(
                            fontFamily: 'NeuePlak',
                            color: Color.fromARGB(255, 44, 42, 42),
                            fontSize: 20,
                            fontWeight: FontWeight.w100),
                      ),
                      Text(
                        timeText,
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
                      Text(
                        placeText,
                        style: TextStyle(
                            fontFamily: 'NeuePlak',
                            color: Color.fromARGB(255, 44, 42, 42),
                            fontSize: 20,
                            fontWeight: FontWeight.w100),
                      ),
                      Text(
                        locationText,
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
              Text(
                aboutText,
                style: TextStyle(
                    fontFamily: 'NeuePlak',
                    color: Color.fromARGB(255, 44, 42, 42),
                    fontSize: 15,
                    fontWeight: FontWeight.w100),
              ),
              TextButton(
                onPressed: onTap_seeMore,
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
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      backgroundImage:
                          AssetImage('assets/images/no_profile_pic.jpg'),
                      radius: 45,
                      backgroundColor: Colors.white,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      organizerName,
                      style: const TextStyle(
                          fontFamily: 'NeuePlak',
                          color: Color.fromARGB(255, 44, 42, 42),
                          fontSize: 20,
                          fontWeight: FontWeight.w100),
                    ),
                    const Text(
                      'Organizer',
                      style: TextStyle(
                          fontFamily: 'NeuePlak',
                          color: Color.fromARGB(255, 44, 42, 42),
                          fontSize: 15,
                          fontWeight: FontWeight.w100),
                    ),
                  ],
                ),
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
