import 'package:flutter/material.dart';
import 'package:petpal_health/widgets/bottom_nav_bar.dart';
import 'package:petpal_health/widgets/gradient_background.dart';

class TipsScreen extends StatelessWidget {
  const TipsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        body: Center(
          child: Text('tip'),
        ),
        bottomNavigationBar: BottomNavBar(context).getFooterMenu(3),
      ),
    );
  }
}
