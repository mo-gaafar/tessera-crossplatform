import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tessera/features/event_creation/cubit/createEvent_cubit.dart';

class PopupMenu extends StatelessWidget {
  String selectEvent = '';
  late List<Icon> selectEventIcons;
  late List<Widget> selectEventText;
  PopupMenu({required this.selectEvent}) {
    if (selectEvent == 'Type') {
      selectEventIcons = const [
        Icon(Icons.mic_external_on_outlined),
        Icon(Icons.slideshow_outlined),
        Icon(Icons.theaters_outlined),
        Icon(Icons.tv_outlined),
        Icon(Icons.festival_outlined),
        Icon(Icons.music_note_outlined),
        Icon(Icons.video_camera_back_outlined),
        Icon(Icons.restaurant_outlined),
        Icon(Icons.auto_stories_outlined),
        Icon(Icons.home_repair_service_outlined),
        Icon(Icons.local_bar_outlined),
        Icon(Icons.group_outlined),
        Icon(Icons.military_tech_outlined),
        Icon(Icons.videogame_asset_outlined),
        Icon(Icons.pedal_bike_outlined),
        Icon(Icons.directions_bus_outlined),
        Icon(Icons.map_outlined),
        Icon(Icons.campaign_outlined),
        Icon(Icons.mic_outlined),
        Icon(Icons.dynamic_feed_outlined),
      ];
      selectEventText = const [
        Text('Confrence'),
        Text('Seminar or Talk'),
        Text('Tradeshow, Consumer Show or Expo'),
        Text('Convection'),
        Text('Fesitval or Fair'),
        Text('Concert or Performance'),
        Text('Screening'),
        Text('Dinner or Gala'),
        Text('Class, Training, or Workshop'),
        Text('Meeting or Networking Event'),
        Text('Party or Social Gathering'),
        Text('Rally'),
        Text('Tournament'),
        Text('Game or Competiotion'),
        Text('Race or Endurance Event'),
        Text('Tour'),
        Text('Attraction'),
        Text('Camp, Trip, or Retreat'),
        Text('Appearance or Signing'),
        Text('Other'),
      ];
    } else if (selectEvent == 'Category') {
      selectEventIcons = const [
        Icon(Icons.music_note_outlined),
        Icon(Icons.slideshow_outlined),
        Icon(Icons.restaurant_outlined),
        Icon(Icons.home_work_outlined),
        Icon(Icons.theater_comedy_outlined),
        Icon(Icons.movie_creation_outlined),
        Icon(Icons.sports_outlined),
        Icon(Icons.health_and_safety_outlined),
      ];
      selectEventText = const [
        Text('Music'),
        Text('Buisness & Professional'),
        Text('Food & Drink'),
        Text('Commiunity & Culture'),
        Text('Preforming & Visual Arts'),
        Text('Film, Media &Entertainment'),
        Text('Sports & Fitness'),
        Text('Health & Wellness'),
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      child: ListView.separated(
        itemCount: selectEventText.length,
        separatorBuilder: (context, index) {
          return const Divider(
            color: Colors.grey,
            height: 1,
          );
        },
        shrinkWrap: true,
        itemBuilder: (BuildContext context, index) {
          return ListTile(
            leading: selectEventIcons[index],
            title: selectEventText[index],
            onTap: () {
              if (selectEvent == 'Category') {
                String tempSelectedEventText =
                    selectEventText[index].toString().replaceAll('Text(', "");
                tempSelectedEventText =
                    tempSelectedEventText.replaceAll(')', "");
                                    tempSelectedEventText =
                    tempSelectedEventText.replaceAll('"', "");
                // context.read<CreateEventCubit>().currentEvent.eventCategory =
                //     tempSelectedEventText;
                context
                    .read<CreateEventCubit>()
                    .updateBasicInfo(eventCategory: tempSelectedEventText);
              }
              Navigator.pop(context);
            },
          );
        },
      ),
    );
  }
}
