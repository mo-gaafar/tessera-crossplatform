import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tessera/constants/app_colors.dart';

class EventCard extends StatelessWidget {
  final String eventTitle;
  final DateTime eventDate;
  final String eventLocation;
  final Image eventImage;
  const EventCard(
      {super.key,
      required this.eventTitle,
      required this.eventDate,
      required this.eventLocation,
      required this.eventImage});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: const EdgeInsets.all(0),
      onPressed: () {},
      child: Container(
        clipBehavior: Clip.hardEdge,
        width: double.maxFinite,
        height: 100,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 100,
                  child: eventImage,
                ),
                const SizedBox(width: 10),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        eventTitle,
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'NeuePlak',
                          color: Theme.of(context)
                              .colorScheme
                              .onSecondaryContainer,
                        ),
                      ),
                      // Text('Event Date'),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            size: 12,
                          ),
                          const SizedBox(width: 2),
                          Text(
                            eventLocation,
                            style: TextStyle(
                              fontSize: 10,
                              fontFamily: 'NeuePlak',
                              color: Theme.of(context)
                                  .colorScheme
                                  .onTertiaryContainer,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.all(15),
              padding: const EdgeInsets.all(4),
              // height: 20,
              // width: 30,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.8),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                '${eventDate.day.toString()} ${DateFormat('MMM').format(eventDate).toUpperCase()}',
                style: const TextStyle(
                  fontSize: 10,
                  color: Colors.white,
                  fontFamily: 'NeuePlak',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
