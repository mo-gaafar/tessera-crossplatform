import 'package:animated_icon_button/animated_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';
import 'package:tessera/core/theme/cubit/theme_cubit.dart';
import 'package:tessera/features/authentication/cubit/auth_cubit.dart';
import 'package:tessera/features/events_filter/cubit/events_filter_cubit.dart';
import 'dart:math';

import 'package:tessera/features/landing_page/view/widgets/landing_page_sections.dart';
import 'package:tessera/features/landing_page/view/widgets/network_error_section.dart';
import 'package:tessera/features/landing_page/view/widgets/side_menu.dart';
import 'package:tessera/features/landing_page/view/widgets/side_menu_components.dart';

/// The landing page of the app.
class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  late Image headerImage;

  final GlobalKey<SideMenuState> _sideMenuKey = GlobalKey<SideMenuState>();

  @override
  void initState() {
    super.initState();
    headerImage = Image.asset(
      'assets/images/StockConcert${1 + Random().nextInt(5)}.jpg',
      fit: BoxFit.cover,
    );
  }

  toggleMenu() {
    final state = _sideMenuKey.currentState!;
    if (state.isOpened) {
      state.closeSideMenu();
    } else {
      state.openSideMenu();
    }

    // setState(() {});
  }

  // final userLocation = 'New York, ;
  @override
  Widget build(BuildContext context) {
    return CustomSideMenu(
      sideMenuKey: _sideMenuKey,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: CustomScrollView(
          key: const PageStorageKey('landingPage'),
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              leading: IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () => toggleMenu(),
              ),
              elevation: 0,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: EdgeInsets.zero,
                centerTitle: true,
                title: SafeArea(
                  child: SizedBox(
                    height: 200,
                    child: LayoutBuilder(builder: (context, constraints) {
                      return Image.asset(
                        'assets/images/LogoFullTextLarge.png',
                        color:
                            constraints.maxHeight > 100 ? Colors.white : null,
                        width: 150,
                      );
                    }),
                  ),
                ),
                background: Container(
                  foregroundDecoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: const [0.7, 1],
                      colors: [
                        // Colors.black.withOpacity(0.7),
                        Colors.black.withOpacity(0.2),
                        // Colors.transparent,
                        Colors.black,
                      ],
                    ),
                  ),
                  child: headerImage,
                ),
              ),
              expandedHeight: 250,
            ),
            context.select((EventsFilterCubit events) => events.state)
                    is EventsError
                ? const NetworkErrorSection()
                : const LandingPageSections()
          ],
        ),
      ),
    );
  }
}
