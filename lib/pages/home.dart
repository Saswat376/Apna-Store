import 'package:flutter/material.dart';
import 'package:flutter_application_1/widget/widget.dart';
import 'package:flutter_application_1/pages/Order.dart';
import 'package:flutter_application_1/pages/home.dart';
import 'package:flutter_application_1/pages/profile.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List categories = [
    "images/laptop.jpg",
    "images/mobile.jpg",
    "images/headphone.webp",
    "images/watch.jpg",
    "images/gadgets-accessories-gadgets-accessories-isolated-white-background-133429004.webp"
  ];
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
            Icon(
              Icons.home_outlined,
              color: Colors.white,
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
      backgroundColor: Color(0xfff2f2f2),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 40.0, left: 20.0, right: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Hey, Saswat", style: Appwidget.boldText()),
                      Text("Good Morning", style: Appwidget.lightText()),
                    ],
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      'images/user-icon-2048x2048-ihoxz4vq.png',
                      height: 70.0,
                      width: 70.0,
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 30.0,
              ),
              SingleChildScrollView(
                child: Container(
                    padding: EdgeInsets.only(left: 5.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    width: MediaQuery.of(context).size.width,
                    child: TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Search Products",
                          hintStyle: Appwidget.lightText(),
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.black,
                          )),
                    )),
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Categories", style: Appwidget.semibold()),
                  Text("See all", style: Appwidget.semibold())
                ],
              ),
              SizedBox(height: 20.0),
              Row(
                children: [
                  Container(
                      padding: EdgeInsets.all(20),
                      margin: EdgeInsets.only(right: 20.0),
                      decoration: BoxDecoration(
                          color: Color(0xFFFd6F3E),
                          borderRadius: BorderRadius.circular(20.0)),
                      height: 130,
                      width: 90,
                      child: Center(
                          child: Text(
                        "All",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ))),
                  Expanded(
                    child: SizedBox(
                      height: 130,
                      child: ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: categories.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return CategoryTile(image: categories[index]);
                          }),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("All Products", style: Appwidget.semibold()),
                  Text("See all", style: Appwidget.semibold())
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              SizedBox(
                height: 200,
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 20.0),
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        children: [
                          Image.asset(
                            "images/laptop.jpg",
                            height: 120,
                            width: 120,
                          ),
                          Text(
                            "Laptop",
                            style: Appwidget.semibold(),
                          ),
                          Row(
                            children: [
                              Text(
                                "\$100",
                                style: TextStyle(
                                    color: Color(0xFFFd6F3E),
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 20.0,
                              ),
                              Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: Color(0xFFFd6F3E),
                                      borderRadius: BorderRadius.circular(7)),
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ))
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 20.0),
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        children: [
                          Image.asset(
                            "images/mobile.jpg",
                            height: 120,
                            width: 120,
                          ),
                          Text(
                            "Phone",
                            style: Appwidget.semibold(),
                          ),
                          Row(
                            children: [
                              Text(
                                "\$100",
                                style: TextStyle(
                                    color: Color(0xFFFd6F3E),
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 20.0,
                              ),
                              Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: Color(0xFFFd6F3E),
                                      borderRadius: BorderRadius.circular(7)),
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  )),
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 20.0),
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        children: [
                          Image.asset(
                            "images/headphone.webp",
                            height: 120,
                            width: 120,
                          ),
                          Text(
                            "Headphone",
                            style: Appwidget.semibold(),
                          ),
                          Row(
                            children: [
                              Text(
                                "\$100",
                                style: TextStyle(
                                    color: Color(0xFFFd6F3E),
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 20.0,
                              ),
                              Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: Color(0xFFFd6F3E),
                                      borderRadius: BorderRadius.circular(7)),
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  )),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  String image;
  CategoryTile({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.only(right: 20.0),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20.0)),
      height: 90,
      width: 90,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            image,
            height: 50,
            width: 50,
            fit: BoxFit.cover,
          ),
          Icon(Icons.arrow_forward)
        ],
      ),
    );
  }
}
