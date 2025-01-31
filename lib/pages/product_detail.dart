import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/home.dart';
import 'package:flutter_application_1/services/constant.dart';
import 'package:flutter_application_1/services/database.dart';
import 'package:flutter_application_1/services/shared_pref.dart';
import 'package:flutter_application_1/widget/widget.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

class ProductDetail extends StatefulWidget {
  String image, name, detail, price;
  ProductDetail(
      {required this.detail,
      required this.image,
      required this.name,
      required this.price});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  String? name, mail, image;

  getthesharedpref() async {
    name = await SharedPreferenceHelper().getUserName();
    mail = await SharedPreferenceHelper().getUserEmail();
    image = await SharedPreferenceHelper().getUserImage();
    setState(() {});
  }

  ontheload() async {
    await getthesharedpref();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    ontheload();
  }

  Map<String, dynamic>? paymentIntent;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFfef5f1),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 50.0, left: 20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(
                      context, MaterialPageRoute(builder: (context) => Home()));
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Icon(Icons.arrow_back_ios_new_outlined),
                ),
              ),
            ),
            Center(
              child: Image.network(
                widget.image,
                height: 300,
              ),
            ),
            Container(
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.name,
                        style: Appwidget.semibold(),
                      ),
                      Text(widget.price, style: Appwidget.semibold())
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Text("Details", style: Appwidget.boldText()),
                  SizedBox(height: 10.0),
                  Text(widget.detail),
                  SizedBox(height: 20.0),
                  GestureDetector(
                    onTap: () {
                      makePayment(widget.price);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 20.0),
                      decoration: BoxDecoration(
                        color: Color(0xFFFd6F3E),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: Text(
                          "Buy Now",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> makePayment(String amount) async {
    try {
      paymentIntent = await createPaymentIntent(amount, 'USD');
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent?['client_secret'],
          style: ThemeMode.dark,
          merchantDisplayName: 'Adnan',
        ),
      );
      displayPaymentSheet();
    } catch (e) {
      print('Exception: $e');
    }
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) async {
        Map<String, dynamic> orderInfoMap = {
          "Product": widget.name,
          "Price": widget.price,
          "Name": name,
          "Email": mail,
          "Image": image,
          "ProductImage": widget.image,
        };
        await DatabaseMethods().orderDetails(orderInfoMap);
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            content: Row(
              children: [
                Icon(Icons.check_circle, color: Colors.green),
                Text("Payment successful")
              ],
            ),
          ),
        );
        paymentIntent = null;
      }).onError((error, stackTrace) {
        print("Error: $error");
      });
    } on StripeException catch (e) {
      print("Stripe Error: $e");
      showDialog(
        context: context,
        builder: (_) => AlertDialog(content: Text("Payment Cancelled")),
      );
    } catch (e) {
      print('$e');
    }
  }

  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer $secretkey',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: body,
      );
      return jsonDecode(response.body);
    } catch (err) {
      print('Payment error: ${err.toString()}');
    }
  }

  calculateAmount(String amount) {
    final calculatedAmount = (int.parse(amount) * 100);
    return calculatedAmount.toString();
  }
}
