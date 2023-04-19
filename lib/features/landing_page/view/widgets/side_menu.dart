import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'package:shrink_sidemenu/shrink_sidemenu.dart';
import 'package:tessera/features/landing_page/view/widgets/side_menu_components.dart';

class CustomSideMenu extends StatelessWidget {
  const CustomSideMenu(
      {super.key, required this.sideMenuKey, required this.child});

  final GlobalKey<SideMenuState> sideMenuKey;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SideMenu(
        key: sideMenuKey,
        menu: CustomSideMenuComponents(),
        type: SideMenuType.slideNRotate,
        child: child);
  }
}
