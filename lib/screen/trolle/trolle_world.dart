import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:px1_mobile/screen/trolle/Board.dart';
import 'package:px1_mobile/screen/trolle/MyCard.dart';
import 'package:px1_mobile/screen/trolle/Notification%20copy.dart';
import 'package:px1_mobile/screen/trolle/Notification.dart';
import 'package:px1_mobile/screen/trolle/SearchPage.dart';

class TrolleWorld extends ConsumerWidget {
  const TrolleWorld({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final PersistentTabController _controller = PersistentTabController(initialIndex: 0);
    List<Widget> _buildScreens() {
      return [BoardPage(), MyCardPage(), SearchPage(), NotificationPage(), MyAccountPage()];
    }

    List<PersistentBottomNavBarItem> _navBarsItems() {
      return [
        PersistentBottomNavBarItem(
          icon: Icon(Icons.home_outlined),
          title: "Board",
          activeColorPrimary: Colors.deepPurple,
          inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(Icons.person_2_outlined),
          title: "My card",
          activeColorPrimary: Colors.deepPurple,
          inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(Icons.work_outline),
          title: "Search",
          activeColorPrimary: Colors.deepPurple,
          inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(Icons.settings),
          title: "Notification",
          activeColorPrimary: Colors.deepPurple,
          inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(Icons.person_outline),
          title: "Account",
          activeColorPrimary: Colors.deepPurple,
          inactiveColorPrimary: Colors.grey,
        ),
      ];
    }

    return PersistentTabView(
      // key: ValueKey(locale.languageCode),
      context,
      screens: _buildScreens(),
      items: _navBarsItems(),
      backgroundColor: Colors.grey.shade300,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      navBarStyle: NavBarStyle.style6,
      navBarHeight: 50.0,
      confineToSafeArea: true,
      controller: _controller,
      padding: EdgeInsets.only(top: 10),
    );
  }
}
