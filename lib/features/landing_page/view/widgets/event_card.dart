import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tessera/constants/app_colors.dart';
import 'package:tessera/features/events/cubit/event_book_cubit.dart';
import 'package:tessera/features/events/data/event_data.dart';
import 'package:tessera/features/events/view/pages/event_screen.dart';
import 'package:tessera/features/landing_page/data/event_card_model.dart';

/// A card displaying a single event.
///
/// Takes in an [EventCardModel] and displays the event's title, image, date and
/// location.
class EventCard extends StatelessWidget {
  final EventCardModel event;
  const EventCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: const EdgeInsets.all(0),
      onPressed: () async {
        EventModel eventModel =
            await context.read<EventBookCubit>().getEventData(event.id);
        if (context.mounted) {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (BuildContext context) {
              return EventPage(eventData: eventModel);
            }),
          );
        }
      },
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
                  height: 100,
                  width: 100,
                  child: event.image,
                ),
                const SizedBox(width: 10),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        event.title,
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
                            event.location,
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
                '${event.date.day.toString()} ${DateFormat('MMM').format(event.date).toUpperCase()}',
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
