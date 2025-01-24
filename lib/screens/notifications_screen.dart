import 'package:flutter/material.dart';
import 'package:petpal_health/widgets/bottom_nav_bar.dart';
import 'package:petpal_health/widgets/gradient_background.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        body: Center(
          child: Text('not'),
        ),
        bottomNavigationBar: BottomNavBar(context).getFooterMenu(2),
      ),
    );
  }
}
