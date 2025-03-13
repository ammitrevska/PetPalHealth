import 'package:flutter/material.dart';
import 'package:petpal_health/constants.dart';
import 'package:petpal_health/widgets/outlines_icons.dart';

class BottomNavBar {
  final List<String> routes = [
    Pages.homeScreen,
    Pages.calendarScreen,
    Pages.mapScreen,
    Pages.factsScreen,
  ];

  void goScreen(BuildContext context, int newScreen) {
    if (newScreen >= 0 && newScreen < routes.length) {
      Navigator.pushReplacementNamed(context, routes[newScreen]);
    } else {
      debugPrint('Invalid screen index: $newScreen');
    }
  }

  BottomNavigationBar getFooterMenu(BuildContext context, int index) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      useLegacyColorScheme: false,
      backgroundColor: Colors.transparent,
      elevation: 0,
      selectedItemColor: kButtonColor,
      unselectedItemColor: Colors.transparent,
      currentIndex: index,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: customIcon(Icons.home_outlined, Icons.home,
              isSelected: index == 0),
          label: ' ',
        ),
        BottomNavigationBarItem(
          icon: customIcon(Icons.calendar_today_outlined, Icons.calendar_today,
              isSelected: index == 1),
          label: ' ',
        ),
        BottomNavigationBarItem(
          icon: customIcon(Icons.location_on_outlined, Icons.location_on,
              isSelected: index == 2),
          label: ' ',
        ),
        BottomNavigationBarItem(
          icon: customIcon(Icons.lightbulb_outline_rounded, Icons.lightbulb,
              isSelected: index == 3),
          label: ' ',
        ),
      ],
      onTap: (int index) {
        goScreen(context, index);
      },
    );
  }
}
