import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/home.dart';
import 'package:flutter_application_1/pages/profile.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class Order extends StatefulWidget {
  const Order({super.key});

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  late List<Widget> pages;

  late Home Homepage;
  late Order order;
  late Profile profile;
  int currentTabIndex = 0;

  @override
  void initState() {
    Homepage = Home();
    order = Order();
    profile = Profile();
    pages = [Homepage, order, profile];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
          height: 43,
          backgroundColor: Color(0xfff2f2f2),
          color: Colors.black,
          animationDuration: Duration(milliseconds: 200),
          onTap: (int index) {
            setState(() {
              currentTabIndex = index;
            });
          },
          items: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed('home');
              },
              child: Icon(
                Icons.home_outlined,
                color: Colors.white,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed('order');
              },
              child: Icon(
                Icons.shopping_bag_outlined,
                color: Colors.white,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed('profile');
              },
              child: Icon(
                Icons.person_outlined,
                color: Colors.white,
              ),
            ),
          ]),
    );
  }
}
