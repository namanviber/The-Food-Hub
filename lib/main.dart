import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:thefoodhub/appScreens/homePage.dart';
import 'package:thefoodhub/appScreens/signinScreen.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'appScreens/signupScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  try {} catch (e) {
    print('Init failed' + e.toString());
  }
  runApp(const MyApp());
  _init();
}

_init() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final token = prefs.getString("userID");
  if (token != null) {
    print('Token: $token');
    Get.offAll(HomePage());
  } else {
    Get.offAll(SignIn());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'The Food Hub',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const SignUp(),
    );
  }
}
