import 'package:flutter/material.dart';
import 'package:tessera/features/attendees_view/landing_page/view/widgets/side_menu.dart';
// import 'package:tessera/features/organizers_view/event_creation/data/url_luncher.dart';
import 'package:tessera/features/organizers_view/event_creation/view/Widgets/no_event_template.dart';

class CreatorLandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: CustomSideMenu(
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: const [
                Tab(
                  text: 'Live',
                ),
                Tab(
                  text: 'Past',
                ),
                Tab(
                  text: 'Draft',
                ),
              ],
              labelColor: Theme.of(context).textTheme.bodyLarge!.color,
              dividerColor: Theme.of(context).textTheme.bodyLarge!.color,
            ),
            title: const Text(
              'Events',
              style: TextStyle(
                  fontFamily: 'NeuePlak',
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
            actions: <Widget>[
              Center(
                child: GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/dashboard'),
                  child: const Icon(
                    Icons.search_outlined,
                    color: Colors.grey,
                  ),
                ),
              )
            ],
          ),
          body: TabBarView(
            children: [
              NoEvenTemplate('you don\'t have any live events'),
              NoEvenTemplate('you don\'t have any past events'),
              NoEvenTemplate('you don\'t have any draft events'),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, '/neweventtitle');
            },
            backgroundColor: Colors.orange,
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}
