import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tessera/features/Booking/view/widgets/event_page.dart';
import 'package:tessera/features/Booking/view/widgets/pop_up.dart';

class EventScreen extends StatelessWidget {
  const EventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: EventPage(
        headerImage: 'assets/images/books.jpeg',
        organizerName: 'booktok by mariam',
        headerText:
            'Bestseller book bootcamp for every one who wants to leave reality behind',
        dateText: 'Wed, March 15-Thu, March 16',
        timeText: '9:00 AM-12:00 PM GMT +02:00',
        placeText: 'offline',
        locationText: '0, Cairo, Cairo Government 11837',
        feesText: 'Free',
        aboutText:
            'get to read, buy and talk about your favourite books and share your thoughts with others',
        buttonText: 'Tickets',
        seemoreButton: 'hi',
        onTap_seeMore: () {
          Navigator.pushNamed(context, '/third');
        },
        onTap_ticket: () {
          showAlertDialog(context);
        },
      ),
    );
  }
}
