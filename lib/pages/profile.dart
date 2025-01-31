import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/Order.dart';
import 'package:flutter_application_1/pages/home.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_application_1/pages/onboard.dart';
import 'package:flutter_application_1/services/auth.dart';
import 'package:flutter_application_1/services/shared_pref.dart';
import 'package:flutter_application_1/widget/widget.dart';
import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String? image, name, email;
  final ImagePicker _picker = ImagePicker();
  File? selectedImage;

  getUserData() async {
    image = await SharedPreferenceHelper().getUserImage();
    name = await SharedPreferenceHelper().getUserName();
    email = await SharedPreferenceHelper().getUserEmail();
    setState(() {});
  }

  int currentTabIndex = 2; // Default profile tab
  final List<Widget> pages = [Home(), Order(), Profile()];

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  Future pickImage() async {
    var image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
      });
    }
  }

  Widget profileItem(IconData icon, String title, String value) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: EdgeInsets.all(12.0),
        child: Row(
          children: [
            Icon(icon, size: 30, color: Colors.blueGrey),
            SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Appwidget.lightText()),
                SizedBox(height: 4),
                Text(value, style: Appwidget.semibold().copyWith(fontSize: 16)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget actionButton(String text, IconData icon, Color color, Function onTap) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: color,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          child: Row(
            children: [
              Icon(icon, size: 28, color: Colors.white),
              SizedBox(width: 12),
              Text(text, style: TextStyle(color: Colors.white, fontSize: 16)),
              Spacer(),
              Icon(Icons.arrow_forward, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color(0xfff8f8f8),
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text("Profile", style: TextStyle(color: Colors.black)),
        centerTitle: true,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        height: 50,
        backgroundColor: Color(0xfff8f8f8),
        color: Colors.black,
        animationDuration: Duration(milliseconds: 200),
        index: currentTabIndex,
        onTap: (index) {
          setState(() {
            currentTabIndex = index;
          });
        },
        items: [
          Icon(Icons.home_outlined, color: Colors.white),
          Icon(Icons.shopping_bag_outlined, color: Colors.white),
          Icon(Icons.person_outlined, color: Colors.white),
        ],
      ),
      body: name == null
          ? Center(child: CircularProgressIndicator(color: Colors.blue))
          : SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 20),

                  // Profile Picture
                  GestureDetector(
                    onTap: () => pickImage(),
                    child: Center(
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            radius: screenWidth *
                                0.2, // Adjusted size based on screen width
                            backgroundColor: Colors.grey.shade300,
                            backgroundImage: selectedImage != null
                                ? FileImage(selectedImage!)
                                : NetworkImage(
                                    'https://cdn-icons-png.flaticon.com/512/9203/9203764.png',
                                  ) as ImageProvider,
                          ),
                          Container(
                            padding: EdgeInsets.all(
                                screenWidth * 0.03), // Dynamic padding
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              shape: BoxShape.circle,
                            ),
                            child:
                                Icon(Icons.edit, color: Colors.white, size: 20),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 20),

                  // Name & Email
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                    child: Column(
                      children: [
                        profileItem(Icons.person_outline, "Name", name!),
                        SizedBox(height: 12),
                        profileItem(Icons.mail_outline, "Email", email!),
                        SizedBox(height: 20),

                        // Logout & Delete Account Buttons
                        actionButton(
                          "Logout",
                          Icons.logout_outlined,
                          Colors.red.shade400,
                          () async {
                            await AuthMethods().SignOut();
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Onboard()));
                          },
                        ),
                        SizedBox(height: 10),
                        actionButton(
                          "Delete Account",
                          Icons.delete_outline,
                          Colors.red.shade800,
                          () async {
                            await AuthMethods().deleteuser();
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Onboard()));
                          },
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 30),
                ],
              ),
            ),
    );
  }
}
