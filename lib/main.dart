import 'package:flutter/material.dart';
import 'package:project/mainscreen.dart';
import 'package:project/screens/Normal_User_Side/FirstIn.dart';
import 'package:project/screens/Normal_User_Side/LorS.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:project/components/firebase_options.dart';
import 'package:project/screens/Normal_User_Side/login.dart';
import 'package:project/screens/Pharmacist_Side/PharmacistLorS.dart';
import 'package:project/screens/Normal_User_Side/account.dart';
import 'package:project/screens/Normal_User_Side/userdetail.dart';
import 'package:project/screens/Normal_User_Side/welcome.dart';
import 'package:project/screens/Pharmacist_Side/PharmacistMainscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(scaffoldBackgroundColor: Colors.white),
        home: PharmacistMainscreen());
  }
}
