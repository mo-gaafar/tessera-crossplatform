import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tessera/features/Booking/view/widgets/event_page.dart';

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
          Navigator.of(context).pushNamed('/second');
        },
        onTap_ticket: () {
          _dialogBuilder(context);
        },
      ),
    );
  }

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('booking'),
          content: const Text('Choose the number of tickets and add a promo code if you have'),
          actions: <Widget>[
            const TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter your promocode',
            ),
          ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('checkout'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
