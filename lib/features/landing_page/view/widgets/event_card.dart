import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tessera/constants/app_colors.dart';

class EventCard extends StatelessWidget {
  final String eventTitle;
  final String eventDate;
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
          alignment: Alignment.topRight,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 100,
                  child: eventImage,
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      eventTitle,
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'NeuePlak',
                        color:
                            Theme.of(context).colorScheme.onSecondaryContainer,
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
              ],
            ),
            Container(
              margin: const EdgeInsets.all(15),
              // padding: const EdgeInsets.all(5),
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Stack(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      '16',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontFamily: 'NeuePlak',
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      'FEB',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                        fontFamily: 'NeuePlak',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
