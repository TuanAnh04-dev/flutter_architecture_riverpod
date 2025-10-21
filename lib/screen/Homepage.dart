import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:px1_mobile/feature/product/presentation/pages/product_list_page.dart';
import 'package:px1_mobile/module/base/logic/my_profile.dart';
import 'package:px1_mobile/module/user/screen/list_user.dart';
import 'package:px1_mobile/screen/Dashboard.dart';
import 'package:px1_mobile/screen/Function.dart';
import 'package:px1_mobile/screen/Setting.dart';

class Homepage extends ConsumerWidget {
  Homepage({super.key});
  final PersistentTabController _controller = PersistentTabController(
    initialIndex: 0,
  );
  List<Widget> _buildScreens() {
    return [Dashboard(), ListUser(), ProductListPage(), Setting()];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home_outlined),
        title: "Home",
        activeColorPrimary: Colors.deepPurple,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.person_2_outlined),
        title: "User",
        activeColorPrimary: Colors.deepPurple,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.work_outline),
        title: "Work",
        activeColorPrimary: Colors.deepPurple,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.settings),
        title: "Settings",
        activeColorPrimary: Colors.deepPurple,
        inactiveColorPrimary: Colors.grey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final locale = ref.watch(localeProvider);
    final profile = ref.read(myProfileProvider.notifier).getMyProfile();
    return PersistentTabView(
      context,
      screens: _buildScreens(),
      items: _navBarsItems(),
      backgroundColor: Colors.white,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      navBarStyle: NavBarStyle.style3,
      navBarHeight: 45.0,
      confineToSafeArea: true,
      controller: _controller,
    );
  }
}
