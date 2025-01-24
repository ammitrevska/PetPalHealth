import 'package:flutter/material.dart';
import 'package:petpal_health/constants.dart';

class BottomNavBar {
  late BuildContext context;
  BottomNavBar(this.context);

  goScreen(int newScreen) {
    switch (newScreen) {
      case 0:
        Navigator.popAndPushNamed(context, Pages.setUpScreen);
        break;
      case 1:
        Navigator.popAndPushNamed(context, Pages.mapScreen);
        break;
      case 2:
        Navigator.popAndPushNamed(context, Pages.notificationsScreen);
        break;
      case 3:
        Navigator.popAndPushNamed(context, Pages.tipsScreen);
        break;
    }
  }

  getFooterMenu(int index) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      useLegacyColorScheme: false,
      backgroundColor: const Color.fromRGBO(249, 235, 162, 0.27),
      selectedItemColor: kButtonColor,
      unselectedItemColor: Colors.white,
      iconSize: 38.0,
      currentIndex: index,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home), // Home icon
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.map), // Map icon
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications), // Notifications icon
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.close), // Cross icon
          label: '',
        ),
      ],
      onTap: (int index) {
        goScreen(index);
      },
    );
  }
}
