import 'package:flutter/material.dart';
import 'package:petpal_health/widgets/bottom_nav_bar.dart';
import 'package:petpal_health/widgets/gradient_background.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        body: Center(
          child: Text('map'),
        ),
        bottomNavigationBar: BottomNavBar(context).getFooterMenu(1),
      ),
    );
  }
}
