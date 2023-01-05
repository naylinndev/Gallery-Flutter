import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallery/ui/photo/photo_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../common/styles/color_palettes.dart';
import '../../common/utils/ad_manager.dart';
import '../../common/utils/app_constant.dart';
import '../../common/utils/argument.dart';
import '../../common/utils/navigation.dart';
import '../../di/injection_container.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/';
  final String title;

  const HomeScreen({Key? key, required this.title}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PersistentTabController _controller;

  @override
  void initState() {
    super.initState();

    _controller = PersistentTabController(initialIndex: 0);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  List<Widget> _buildScreens() {
    List<Widget> screenArr = [];
    screenArr.add(const PhotoScreen());
    screenArr.add(const PhotoScreen());
    screenArr.add(const PhotoScreen());

    return screenArr;
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    List<PersistentBottomNavBarItem> bottomNavArr = [];
    bottomNavArr.add(PersistentBottomNavBarItem(
      icon: const Icon(Icons.image, size: 20),
      title: ("Photo"),
      activeColorPrimary: ColorPalettes.darkAccent,
      inactiveColorPrimary: ColorPalettes.grey,
    ));

    bottomNavArr.add(PersistentBottomNavBarItem(
      icon: const Icon(Icons.dashboard, size: 20),
      title: ("Category"),
      activeColorPrimary: ColorPalettes.darkAccent,
      inactiveColorPrimary: ColorPalettes.grey,
    ));

    bottomNavArr.add(PersistentBottomNavBarItem(
      icon: const Icon(Icons.favorite, size: 20),
      title: ("Favorites"),
      activeColorPrimary: ColorPalettes.darkAccent,
      inactiveColorPrimary: ColorPalettes.grey,
    ));
    return bottomNavArr;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white,
      // Default is Colors.white.
      handleAndroidBackButtonPress: true,
      // Default is true.
      resizeToAvoidBottomInset: true,
      // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true,
      // Default is true.
      hideNavigationBarWhenKeyboardShows: true,
      // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.once,
      itemAnimationProperties: const ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      navBarStyle:
          NavBarStyle.style3, // Choose the nav bar style with this property.
    ));
  }
}
