import 'package:flutter/material.dart';

class PopupMenu extends StatelessWidget {
  String selectEvent = '';
  late List<Icon> selectEventIcons;
  late List<Widget> selectEventText;
  PopupMenu({required this.selectEvent}) {
    if (selectEvent == 'Title') {
      selectEventIcons = const [
        Icon(Icons.mic_external_on_outlined),
        Icon(Icons.slideshow_outlined),
        Icon(Icons.theaters_outlined),
        Icon(Icons.tv_outlined),
        Icon(Icons.festival_outlined),
        Icon(Icons.music_note_outlined),
        Icon(Icons.video_camera_back_outlined),
        Icon(Icons.restaurant_outlined),
      ];
      selectEventText = const [
        Text('Confrence'),
        Text('Seminar or Talk'),
        Text('Tradeshow, Consumer S..'),
        Text('Convection'),
        Text('Fesitval or Fair'),
        Text('Concert or Performance'),
        Text('Screening'),
        Text('Dinner or Gala'),
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
              print(selectEventText[index]);
              Navigator.pop(context);
            },
          );
        },
      ),
    );
  }
}
