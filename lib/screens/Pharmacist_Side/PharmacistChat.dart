import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // Import the shop.dart file

class PharmacistChat extends StatefulWidget {
  const PharmacistChat({super.key});
  @override
  State<PharmacistChat> createState() => _PharmacistChatState();
}

class _PharmacistChatState extends State<PharmacistChat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            padding: EdgeInsets.only(top: 50, left: 30, right: 30, bottom: 30),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromARGB(255, 66, 230, 148),
                    Color.fromARGB(255, 59, 178, 184)
                  ],
                ),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Container(
                  child: TextFormField(
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(40.0),
                        ),
                        borderSide: BorderSide.none,
                      ),
                      hintText: "ค้นหาในแอป PharmaDrop",
                      hintStyle: TextStyle(
                          fontSize: 20, color: Colors.black.withOpacity(0.5)),
                      prefixIcon: Icon(Icons.search, size: 30),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
