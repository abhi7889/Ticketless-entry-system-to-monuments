// ignore_for_file: unused_import
import 'package:EZEntry/screens/googel_sign_in.dart';
import 'package:EZEntry/splashscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

void main() async {
  Stripe.publishableKey =
      'pk_test_51MvJZUSBTWA3x7fKPzHVMULjguZr8fwbiVMJYFgpyeKVI6zrVPLODObOm5re5xNEjjZAZirFRjbPEBbfKoUIaHZh00SHlnQTcq';
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      theme: ThemeData(
        primaryColor: Colors.blueGrey, // set the primary color here
      ),
    );
  }
}
