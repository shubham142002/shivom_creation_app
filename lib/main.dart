import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shivom_creation/AuthScreen/authscreen.dart';
import 'package:shivom_creation/SplashScreen/splashscreen.dart';
import 'package:shivom_creation/global/global.dart';
import 'firebase_options.dart';

Future<void> main() async
{
  final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  sharedPreferences = await SharedPreferences.getInstance();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);

  runApp (MaterialApp(
    debugShowCheckedModeBanner: false,
    home: AuthScreen(),
  ));
}



