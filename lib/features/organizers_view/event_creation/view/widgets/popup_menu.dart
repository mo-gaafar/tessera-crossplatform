import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tessera/features/organizers_view/event_creation/cubit/createEvent_cubit.dart';

class PopupMenu extends StatelessWidget {
  String selectEvent = '';
  late List<Icon> selectEventIcons;
  late List<String> selectEventText;
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
        'Confrence',
        'Seminar or Talk',
        'Tradeshow, Consumer Show or Expo',
        'Convection',
        'Fesitval or Fair',
        'Concert or Performance',
        'Screening',
        'Dinner or Gala',
        'Class, Training, or Workshop',
        'Meeting or Networking Event',
        'Party or Social Gathering',
        'Rally',
        'Tournament',
        'Game or Competiotion',
        'Race or Endurance Event',
        'Tour',
        'Attraction',
        'Camp, Trip, or Retreat',
        'Appearance or Signing',
        'Other',
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
        Icon(Icons.category_outlined),
        Icon(Icons.category_outlined),
        Icon(Icons.category_outlined),
        Icon(Icons.category_outlined),
        Icon(Icons.category_outlined),
        Icon(Icons.category_outlined),
        Icon(Icons.category_outlined),
        Icon(Icons.category_outlined),
        Icon(Icons.category_outlined),
        Icon(Icons.category_outlined),
        Icon(Icons.category_outlined),
        Icon(Icons.category_outlined),
      ];
      selectEventText = const [
        'Music',
        'Business & Professional',
        'Food & Drink',
        'Community & Culture',
        'Performing & Visual Arts',
        'Film, Media & Entertainment',
        'Sports & Fitness',
        'Health & Wellness',
        'Boat & Air',
        'Charity & Causes',
        'Family & Education',
        'Fashion & Beauty',
        'Government & Politics',
        'Hobbies & Special Interest',
        'Home & Lifestyle',
        'School Activities',
        'Science & Technology',
        'Seasonal & Holiday',
        'Travel & Outdoor',
        'Other',
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
            title: Text(selectEventText[index]),
            onTap: () {
              if (selectEvent == 'Category') {
                String tempSelectedEventText = selectEventText[index];
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
