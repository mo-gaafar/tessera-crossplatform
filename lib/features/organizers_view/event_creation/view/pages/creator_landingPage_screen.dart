import 'package:flutter/material.dart';
import 'package:tessera/features/attendees_view/landing_page/view/widgets/side_menu.dart';
import 'package:tessera/features/organizers_view/event_creation/view/Widgets/my_search_delegated.dart';
import 'package:tessera/features/organizers_view/event_creation/data/organiser_model.dart';
import 'package:tessera/features/organizers_view/event_creation/view/Widgets/creator_eventsList.dart';

class CreatorLandingPage extends StatelessWidget {
  var _controller = TextEditingController();
  OrganiserModel organiserModel =
      OrganiserModel(email: 'email', accessToken: '6439f95a3d607d6c49e56a1e');
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: CustomSideMenu(
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            bottom: const TabBar(
              tabs: [
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
              labelColor: Colors.black,
              dividerColor: Colors.black,
            ),
            title: const Text('Events'),
            actions: <Widget>[
              Center(
                child: GestureDetector(
                  onTap: () {
                    showSearch(context: context, delegate: MySearchDelegated());
                  },
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
              // NoEvenTemplate('you don\'t have any live events'),
              CreatorEventList(
                  filterType: 'upcomingevents', organiserModel: organiserModel),
              CreatorEventList(
                  filterType: 'pastevents', organiserModel: organiserModel),
              // NoEvenTemplate('you don\'t have any past events'),
              // NoEvenTemplate('you don\'t have any draft events'),
              CreatorEventList(
                  filterType: 'draft', organiserModel: organiserModel),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, '/neweventtitle');
              //Navigator.pushNamed(context, '/atendeemanagementhomescreen');
              // Navigator.pushNamed(6
              //     context, '/atendeemanagementprocessingscreen');
              //Navigator.pushNamed(context, '/neweventlocation');
            },
            backgroundColor: Colors.orange,
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}
