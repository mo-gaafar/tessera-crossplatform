import 'package:flutter/material.dart';
import 'package:tessera/constants/app_colors.dart';
import 'package:tessera/features/landing_page/view/widgets/event_card.dart';
import 'package:sliver_tools/sliver_tools.dart';

class EventsSection extends StatelessWidget {
  const EventsSection({
    super.key,
    required this.title,
    this.radius = 20,
  });

  final String title;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return SliverStack(
      children: [
        SliverPositioned.fill(
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.lightBackground,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(radius),
              ),
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(10),
          sliver: MultiSliver(
            pushPinnedChildren: true,
            children: [
              SliverPinnedHeader(
                child: ColoredBox(
                  color: AppColors.lightBackground,
                  child: ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(fontSize: 25),
                        ),
                        // FilterChip(
                        //   selected: false,
                        //   label: Text('text'),
                        //   onSelected: (value) {},
                        //   showCheckmark: false,
                        // )
                      ],
                    ),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: EventCard(
                        eventTitle: 'The Weeknd Tour',
                        eventImage:
                            Image.asset('assets/images/placeholder.jpg'),
                        eventDate: '12/12/2021',
                        eventLocation: 'Koshk Omar Cultural Center'),
                  ),
                  childCount: 10,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// class NearbyEvents extends MultiSliver {
//   NearbyEvents({
//     Key? key,
//     required String title,
//     Color headerColor = Colors.white,
//     Color titleColor = Colors.black,
//     // required List<Widget> items,
//   }) : super(
//           key: key,
//           pushPinnedChildren: true,
//           children: [
//             SliverPinnedHeader(
//               child: ColoredBox(
//                 color: headerColor,
//                 child: ListTile(
//                   textColor: titleColor,
//                   title: Text(title),
//                 ),
//               ),
//             ),
//             SliverList(
//               delegate: SliverChildBuilderDelegate(
//                 (context, index) => EventCard(
//                     eventTitle: 'The Weeknd Tour',
//                     eventImage: Image.asset('assets/images/placeholder.jpg'),
//                     eventDate: '12/12/2021',
//                     eventLocation: 'Koshk Omar Cultural Center'),
//                 childCount: 10,
//               ),
//             ),
//           ],
//         );
// }
