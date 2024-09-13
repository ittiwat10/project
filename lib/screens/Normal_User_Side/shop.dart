// shop.dart
import 'dart:ui';

import 'package:flutter/material.dart';

class shop extends StatefulWidget {
  const shop({super.key});

  @override
  State<shop> createState() => _shopState();
}

class _shopState extends State<shop> {
  List picture = ['sara', 'tylenol'];
  List name = ["sara", "tylenol"];
  List price = ["43 บาท", "140 บาท"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(padding: EdgeInsets.zero, children: [
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
            Row(
              children: [
                Icon(Icons.location_on, size: 60, color: Colors.white),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "ตำแหน่ง",
                      style: TextStyle(
                          fontSize: 12, color: Colors.white, fontFamily: ''),
                    ),
                    Text(
                      "มหาวิทยาลัยวลัยลักษณ์ ตำบลไทรบุรี",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
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
      SizedBox(height: 10),
      Padding(
          padding: EdgeInsets.only(top: 10, right: 20, left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("ยาสามัญประจำบ้าน",
                  style: TextStyle(fontSize: 20, color: Colors.black)),
            ],
          )),
      SizedBox(height: 10),
      GridView.builder(
        itemCount: picture.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 1 / 1.5 // Adjust as needed
            ),
        itemBuilder: (context, index) {
          return InkWell(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromARGB(104, 240, 240, 240)),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Image.asset("assets/${picture[index]}.jpg",
                          width: 200, height: 200),
                    ),
                    SizedBox(height: 5),
                    Text(name[index], style: TextStyle(fontSize: 20)),
                    Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(price[index],
                            style: TextStyle(
                                fontSize: 20,
                                color: Color.fromARGB(255, 59, 178, 184),
                                fontWeight: FontWeight.bold)),
                      )
                    ])
                  ],
                ),
              ));
        },
      )
    ]));
  }
}
