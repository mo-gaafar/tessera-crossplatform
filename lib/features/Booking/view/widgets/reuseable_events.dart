import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:tessera/constants/app_colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tessera/features/Booking/view/widgets/email_button.dart';
import 'package:tessera/features/Booking/view/widgets/rounded_button.dart';
import 'package:tessera/features/Booking/view/widgets/more_like_this.dart';

class EventDetails extends StatelessWidget {
  final String headerImage;
  final String organizerImage;
  final String buttonText;
  final Function()? onTap;

  const EventDetails({
    Key? key,
    required this.headerImage,
    required this.organizerImage,
    required this.buttonText,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      //mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: 200,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage("assets/images/books.jpeg"),
            ),
          ),
        ),
        Text(
          buttonText,
          style: TextStyle(
              fontFamily: 'NeuePlak',
              color: AppColors.textOnLight,
              fontSize: 30),
        ),
        SizedBox(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextButton(
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.focused) ||
                          states.contains(MaterialState.pressed)) {
                        return Colors.white.withOpacity(0);
                      }
                      return null; // Defer to the widget's default.
                    },
                  ),
                ),
                onPressed: () {
                  debugPrint('Received click to see the organizer');
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      backgroundImage:
                          AssetImage('assets/images/no_profile_pic.jpg'),
                      radius: 30,
                      backgroundColor: Colors.white,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 100,
                      child: Text(
                        'booktok by mariam ',
                        style: const TextStyle(
                            fontFamily: 'NeuePlak',
                            color: Color.fromARGB(255, 44, 42, 42),
                            fontSize: 20,
                            fontWeight: FontWeight.w100),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                width: 50,
              ),
              Container(
                width: 150,
                child: OutlinedButton(
                    onPressed: () {
                      debugPrint('Received click to follow ');
                    },
                    style: OutlinedButton.styleFrom(
                        side: BorderSide(color: AppColors.secondary),
                        padding: EdgeInsets.all(15)),
                    child: Text(
                      'Follow',
                      style: TextStyle(
                          fontFamily: 'NeuePlak',
                          color: AppColors.secondary,
                          fontSize: 20),
                    )),
              )
            ],
          ),
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
                  'Wed, March 15-Thu, March 16',
                  style: TextStyle(
                      fontFamily: 'NeuePlak',
                      color: Color.fromARGB(255, 44, 42, 42),
                      fontSize: 20,
                      fontWeight: FontWeight.w100),
                ),
                Text(
                  '9:00 AM-12:00 PM GMT +02:00',
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
                  'Cairo',
                  style: TextStyle(
                      fontFamily: 'NeuePlak',
                      color: Color.fromARGB(255, 44, 42, 42),
                      fontSize: 20,
                      fontWeight: FontWeight.w100),
                ),
                Text(
                  '0, Cairo, Cairo Government 11837',
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
            const Icon(FontAwesomeIcons.ticket, size: 25),
            SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Free',
                  style: TextStyle(
                      fontFamily: 'NeuePlak',
                      color: Color.fromARGB(255, 44, 42, 42),
                      fontSize: 20,
                      fontWeight: FontWeight.w100),
                ),
                Text(
                  'on Tessera',
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
        SizedBox(height: 10,),
        Text(
          'About',
          style: TextStyle(
              fontFamily: 'NeuePlak',
              color: Color.fromARGB(255, 44, 42, 42),
              fontSize: 20,
              fontWeight: FontWeight.w100),
        ),
        Text(
          'get to read, buy and talk about your favourite books and share your thoughts with others',
          style: TextStyle(
              fontFamily: 'NeuePlak',
              color: Color.fromARGB(255, 44, 42, 42),
              fontSize: 15,
              fontWeight: FontWeight.w100),
        ),
        TextButton(
          onPressed: () {
            print('follow more was pressed');
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
              padding:
                  MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(0))),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          'Location',
          style: TextStyle(
              fontFamily: 'NeuePlak',
              color: Color.fromARGB(255, 44, 42, 42),
              fontSize: 20,
              fontWeight: FontWeight.w100),
        ),
        Center(
          child: TextButton(
            style: ButtonStyle(
              overlayColor: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.focused) ||
                      states.contains(MaterialState.pressed)) {
                    return Colors.white.withOpacity(0);
                  }
                  return null; // Defer to the widget's default.
                },
              ),
            ),
            onPressed: () {
              debugPrint('Received click to see the organizer');
            },
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
                  'booktok by mariam ',
                  style: const TextStyle(
                      fontFamily: 'NeuePlak',
                      color: Color.fromARGB(255, 44, 42, 42),
                      fontSize: 20,
                      fontWeight: FontWeight.w100),
                ),
                Text(
                  'Organizer',
                  style: const TextStyle(
                      fontFamily: 'NeuePlak',
                      color: Color.fromARGB(255, 44, 42, 42),
                      fontSize: 15,
                      fontWeight: FontWeight.w100),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Center(
          child: Container(
            width: 170,
            child: OutlinedButton(
                onPressed: () {
                  debugPrint('Received click to follow ');
                },
                style: OutlinedButton.styleFrom(
                    side: BorderSide(color: AppColors.secondary),
                    padding: EdgeInsets.all(15)),
                child: Text(
                  'Follow',
                  style: TextStyle(
                      fontFamily: 'NeuePlak',
                      color: AppColors.secondary,
                      fontSize: 15),
                )),
          ),
        ),
        Text(
          'Tags',
          style: TextStyle(
              fontFamily: 'NeuePlak',
              color: Color.fromARGB(255, 44, 42, 42),
              fontSize: 20,
              fontWeight: FontWeight.w100),
        ),
    
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              RoundedButton(buttonText: '#booktok'),
              SizedBox(width: 10,),
              RoundedButton(buttonText: '#tiktok'),
              SizedBox(width: 10,),
              RoundedButton(buttonText: '#books'),
              SizedBox(width: 10,),
              RoundedButton(buttonText: '#fictional'),
              SizedBox(width: 10,),
              RoundedButton(buttonText: '#grumpy'),
            ],
          ),
        ),
        SizedBox(height: 10,),
        Text(
          'More Like This',
          style: TextStyle(
              fontFamily: 'NeuePlak',
              color: Color.fromARGB(255, 44, 42, 42),
              fontSize: 20,
              fontWeight: FontWeight.w100),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SimilarEvents(),
              SizedBox(width: 10,),
              SimilarEvents(),
              SizedBox(width: 10,),
             SimilarEvents(),
              SizedBox(width: 10,),
              SimilarEvents(),
              SizedBox(width: 10,),
              SimilarEvents(),
            ],
          ),
        ),
        SizedBox(height: 10,),
        EmailButton(buttonText: 'Tickets', colourBackground: AppColors.primary, colourText: Colors.white)
      ],
    );
  }
}
