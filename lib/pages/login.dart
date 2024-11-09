import 'package:flutter/material.dart';
import 'package:flutter_application_1/widget/widget.dart';


class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 40.0, left: 20.0, right: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset("images/laptop.jpg"),
              Center(
                child: Text(
                  "Sign In",
                  style: Appwidget.boldText(),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                "Please enter details",
                style: Appwidget.lightText(),
              ),
              SizedBox(
                height: 20.0,
              ),
              SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(
                      color: Color(0xfff2f2f2),
                      borderRadius: BorderRadius.circular(20)),
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter Name",
                      hintStyle: Appwidget.lightText(),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 40.0,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('home');
                  },
                  child: const Text('Login'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
