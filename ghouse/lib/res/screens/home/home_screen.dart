import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ghouse/res/screens/control/control_screen.dart';
import 'package:ghouse/res/screens/monitor/monitoring_Screen.dart';
import 'package:ghouse/res/screens/profile/profile_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // MQTTClientWrapper clientWrapper;
  PersistentTabController _controller;

  @override
  void initState() {
    _controller = PersistentTabController(initialIndex: 0);
    // clientWrapper = MQTTClientWrapper(() {
    //   print('connected succserss');
    // }, 'P2Ox8oZOzucLvFKRcZUr');

    // clientWrapper.prepareMqttClient();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        boxShadow: [
          // BoxShadow(
          //     color: Colors.black12,
          //     offset: Offset(0, 5),
          //     spreadRadius: 3,
          //     blurRadius: 9)
          BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 0),
              spreadRadius: 12,
              blurRadius: 33)
        ],
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style1, // Choose the nav bar style with this property.
    );
  }
}

List<Widget> _buildScreens() {
  return [MonitoringScreen(), ControlScreen(), ProfileScreen()];
}

List<PersistentBottomNavBarItem> _navBarsItems() {
  return [
    PersistentBottomNavBarItem(
      icon: Icon(CupertinoIcons.home),
      title: ("Monitor"),
      activeColorPrimary: CupertinoColors.activeGreen,
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
    PersistentBottomNavBarItem(
      icon: Icon(CupertinoIcons.antenna_radiowaves_left_right),
      title: ("Control"),
      activeColorPrimary: CupertinoColors.activeGreen,
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
    PersistentBottomNavBarItem(
      icon: Icon(CupertinoIcons.leaf_arrow_circlepath),
      title: ("Profile"),
      activeColorPrimary: CupertinoColors.activeGreen,
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
  ];
}
