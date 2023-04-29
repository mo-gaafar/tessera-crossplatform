import 'package:flutter/material.dart';
import 'package:tessera/constants/app_colors.dart';
import 'package:tessera/features/event_creation/data/url_luncher.dart';
import 'package:tessera/features/event_creation/view/Widgets/span_text_link.dart';
import 'package:tessera/features/event_creation/view/Widgets/no_event_template.dart';
import 'package:tessera/features/event_creation/view/Widgets/my_search_delegated.dart';

class CreatorLandingPage extends StatelessWidget {
  var _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
        foregroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.blue),
      )),
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
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
