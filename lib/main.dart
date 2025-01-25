import 'package:flutter/material.dart';
import 'package:petpal_health/constants.dart';
import 'package:petpal_health/provider/pet_provider.dart';
import 'package:petpal_health/provider/task_provider.dart';
import 'package:petpal_health/screens/add_pet_screen.dart';
import 'package:petpal_health/screens/calendar_screen.dart';
import 'package:petpal_health/screens/login_screen.dart';
import 'package:petpal_health/screens/map_screen.dart';
import 'package:petpal_health/screens/notifications_screen.dart';
import 'package:petpal_health/screens/home_screen.dart';
import 'package:petpal_health/screens/sign_up_screen.dart';
import 'package:petpal_health/screens/tips_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const PetPalHealth());
}

class PetPalHealth extends StatelessWidget {
  const PetPalHealth({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PetProvider()),
        ChangeNotifierProvider(create: (_) => TaskProvider()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.transparent,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.transparent,
          ),
          useMaterial3: true,
        ),
        initialRoute: Pages.loginScreen,
        routes: {
          Pages.loginScreen: (context) => const LoginScreen(),
          Pages.signupScreen: (context) => const SignUpScreen(),
          Pages.setUpScreen: (context) => const HomeScreen(),
          Pages.addPetScreen: (context) => const AddPetScreen(),
          Pages.calendarScreen: (context) => const CalendarScreen(),
          Pages.notificationsScreen: (context) => const NotificationsScreen(),
          Pages.mapScreen: (context) => const MapScreen(),
          Pages.tipsScreen: (context) => const TipsScreen(),
        },
      ),
    );
  }
}
