import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/home.dart';
import 'package:flutter_application_1/widget/widget.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({super.key});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFfef5f1),
      body: Container(
        padding: EdgeInsets.only(
          top: 50.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(
                      context, MaterialPageRoute(builder: (context) => Home()));
                },
                child: Container(
                    margin: EdgeInsets.only(left: 20.0),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(30)),
                    child: Icon(Icons.arrow_back_ios_new_outlined)),
              ),
              Center(
                  child: Image.asset(
                "images/phone.webp",
                height: 300,
              ))
            ]),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 20.0, top: 20.0, right: 20.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Phone",
                          style: Appwidget.semibold(),
                        ),
                        Text("\$300", style: Appwidget.semibold())
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      "details",
                      style: Appwidget.boldText(),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                        "hgxvdkvxuekdybeudhbxeudghedkjhwsbduywvxbjhdwxvukgvwshx"),
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 20.0),
                      decoration: BoxDecoration(
                          color: Color(0xFFFd6F3E),
                          borderRadius: BorderRadius.circular(20)),
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: Text(
                          "Buy Now",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
