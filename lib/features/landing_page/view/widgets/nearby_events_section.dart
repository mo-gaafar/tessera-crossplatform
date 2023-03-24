import 'package:flutter/material.dart';
import 'package:tessera/features/landing_page/view/widgets/event_card.dart';

class NearbyEvents extends StatelessWidget {
  const NearbyEvents({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Events Near New Cairo',
          style: TextStyle(fontSize: 20),
        ),
        EventCard(
            eventTitle: 'The Weeknd Tour',
            eventImage: Image.asset('assets/images/placeholder.jpg'),
            eventDate: '12/12/2021',
            eventLocation: 'Koshk Omar Cultural Center'),
      ],
    );
  }
}
