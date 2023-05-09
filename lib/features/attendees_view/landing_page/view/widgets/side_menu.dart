import 'package:flutter/material.dart';

import 'package:shrink_sidemenu/shrink_sidemenu.dart';
import 'package:tessera/features/attendees_view/landing_page/view/widgets/side_menu_components.dart';

class CustomSideMenu extends StatelessWidget {
  CustomSideMenu({super.key, required this.child, required this.sideMenuKey});

  final GlobalKey<SideMenuState> sideMenuKey;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        int sensitivity = 8;
        if (details.delta.dx < sensitivity &&
            sideMenuKey.currentState!.isOpened) {
          sideMenuKey.currentState!.closeSideMenu();
        }
      },
      child: SideMenu(
          background: Theme.of(context).appBarTheme.backgroundColor,
          closeIcon: null,
          key: sideMenuKey,
          menu: const CustomSideMenuComponents(),
          type: SideMenuType.slideNRotate,
          child: GestureDetector(
              onHorizontalDragUpdate: (details) {
                int sensitivity = 8;
                if (details.delta.dx > sensitivity &&
                    !sideMenuKey.currentState!.isOpened) {
                  sideMenuKey.currentState!.openSideMenu();
                  // User swiped Right
                } else if (details.delta.dx < sensitivity &&
                    sideMenuKey.currentState!.isOpened) {
                  sideMenuKey.currentState!.closeSideMenu();
                }
              },
              child: child)),
    );
  }
}
