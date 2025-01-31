import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/home.dart';
import 'package:flutter_application_1/pages/profile.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_application_1/services/database.dart';
import 'package:flutter_application_1/services/shared_pref.dart';
import 'package:flutter_application_1/widget/widget.dart';

class Order extends StatefulWidget {
  const Order({super.key});

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  String? email;

  getthesharedpref() async {
    email = await SharedPreferenceHelper().getUserEmail();
    setState(() {});
  }

  Stream? orderStream;

  getontheload() async {
    await getthesharedpref();
    orderStream = await DatabaseMethods().getOrders(email!);
    setState(() {});
  }

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
    getontheload();
    super.initState();
  }

  // @override
  // void initState() {
  //   getontheload();
  //   super.initState();
  // }

  Widget allOrders() {
    return StreamBuilder(
        stream: orderStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];

                    return Material(
                      elevation: 3.0,
                      borderRadius: BorderRadius.circular(10.0),
                      child: Container(
                        margin: EdgeInsets.only(right: 20.0),
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          children: [
                            Image.network(
                              ds["image"],
                              height: 120,
                              width: 120,
                            ),
                            Text(
                              ds["name"],
                              style: Appwidget.semibold(),
                            ),
                            Row(
                              children: [
                                Text(
                                  ds["price"],
                                  style: TextStyle(
                                      color: Color(0xFFFd6F3E),
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 20.0,
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          color: Color(0xFFFd6F3E),
                                          borderRadius:
                                              BorderRadius.circular(7)),
                                      child: Icon(
                                        Icons.add,
                                        color: Colors.white,
                                      )),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  })
              : Container();
        });
  }

  // late List<Widget> pages;

  // late Home Homepage;
  // late Order order;
  // late Profile profile;
  // int currentTabIndex = 0;

  // @override
  // void initState() {
  //   Homepage = Home();
  //   order = Order();
  //   profile = Profile();
  //   pages = [Homepage, order, profile];
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
      appBar: AppBar(
        backgroundColor: Color(0xfff2f2f2),
        title: Center(
          child: Text(
            "Current Orders",
            style: Appwidget.boldText(),
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 20.0, right: 20.0),
        child: Column(
          children: [
            Material(
              elevation: 3.0,
              borderRadius: BorderRadius.circular(10.0),
              child: Container(
                padding: EdgeInsets.only(left: 15.0, top: 10.0, bottom: 10.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0)),
                child: Row(
                  children: [
                    Image.network(
                      "https://m.media-amazon.com/images/I/510uTHyDqGL.jpg",
                      height: 120,
                      width: 120,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    Column(
                      children: [
                        Text(
                          "HP Laptop",
                          style: Appwidget.semibold(),
                        ),
                        Text("\$300", style: Appwidget.lightText()),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
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
