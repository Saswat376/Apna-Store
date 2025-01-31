import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/Order.dart';
import 'package:flutter_application_1/pages/bottomnav.dart';
import 'package:flutter_application_1/pages/home.dart';
import 'package:flutter_application_1/pages/login.dart';
import 'package:flutter_application_1/pages/onboard.dart';
import 'package:flutter_application_1/pages/product_detail.dart';
import 'package:flutter_application_1/pages/profile.dart';
import 'package:flutter_application_1/pages/signup.dart';
import 'package:flutter_application_1/services/constant.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = publishablekey;
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Apna Store',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Order(),
      initialRoute: 'onboard',
      routes: {
        'home': (context) => Home(),
        'login': (context) => Login(),
        'onboard': (context) => Onboard(),
        'navbar': (context) => Bottomnav(),
        //'details': (context) => ProductDetail(),
        'profile': (context) => Profile(),
        'order': (context) => Order(),
        'Sign Up': (context) => Signup(),
      },
    );
  }
}
