import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/Order.dart';
import 'package:flutter_application_1/pages/bottomnav.dart';
import 'package:flutter_application_1/pages/home.dart';
import 'package:flutter_application_1/pages/login.dart';
import 'package:flutter_application_1/pages/onboard.dart';
import 'package:flutter_application_1/pages/product_detail.dart';
import 'package:flutter_application_1/pages/profile.dart';

void main() {
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
      initialRoute: 'onboard',
      routes: {
        'home': (context) => Home(),
        'login': (context) => Login(),
        'onboard': (context) => Onboard(),
        'navbar': (context) => Bottomnav(),
        'details': (context) => ProductDetail(),
        'profile': (context) => Profile(),
        'order': (context) => Order(),
      },
    );
  }
}
