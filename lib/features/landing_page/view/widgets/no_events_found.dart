import 'package:flutter/material.dart';

class NoEventsFound extends StatelessWidget {
  const NoEventsFound({super.key, this.description = 'found'});

  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        children: [
          Icon(
            Icons.calendar_month_outlined,
            size: 50,
            color: Theme.of(context).textTheme.bodyLarge!.color,
          ),
          Text(
            'No events $description',
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
