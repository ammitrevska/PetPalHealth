import 'package:flutter/material.dart';
import 'package:petpal_health/constants.dart';
import 'package:petpal_health/screens/cats_facts_screen.dart';
import 'package:petpal_health/screens/dogs_facts_screen.dart';
import 'package:petpal_health/widgets/bottom_nav_bar.dart';
import 'package:petpal_health/widgets/gradient_background.dart';

class FactsScreen extends StatelessWidget {
  const FactsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Random Pet Facts'),
            bottom: const TabBar(
              dividerColor: Color(0xFFF9EBA2),
              indicatorColor: kTextColor,
              tabs: [
                Tab(
                    text: 'Dog Facts',
                    icon: Icon(
                      Icons.pets,
                      color: kTextColor,
                    )),
                Tab(
                    text: 'Cat Facts',
                    icon: Icon(
                      Icons.pets_outlined,
                      color: kTextColor,
                    )),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              DogsFactsScreen(),
              CatsFactsScreen(),
            ],
          ),
          bottomNavigationBar: BottomNavBar(context).getFooterMenu(3),
        ),
      ),
    );
  }
}
