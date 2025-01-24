import 'package:flutter/material.dart';
import 'package:petpal_health/screens/add_pet_screen.dart';
import 'package:petpal_health/screens/login_screen.dart';
import 'package:petpal_health/screens/map_screen.dart';
import 'package:petpal_health/screens/notifications_screen.dart';
import 'package:petpal_health/screens/home_screen.dart';
import 'package:petpal_health/screens/sign_up_screen.dart';
import 'package:petpal_health/screens/tips_screen.dart';

const kButtonColor = Color(0xFFFFC363);
const kTextColor = Color(0xFF242D68);

class Pages {
  static String loginScreen = '$LoginScreen';
  static String signupScreen = '$SignUpScreen';
  static String setUpScreen = '$HomeScreen';
  static String addPetScreen = '$AddPetScreen';
  static String mapScreen = '$MapScreen';
  static String notificationsScreen = '$NotificationsScreen';
  static String tipsScreen = '$TipsScreen';
}
