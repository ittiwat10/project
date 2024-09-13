import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // Import the shop.dart file

class homescreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<homescreen> {
  final List<String> category = [
    "ยาสามัญประจำบ้าน",
    "วิตามินและอาหารเสริม",
    "ยาสมุนไพร",
    "อื่นๆ"
  ];

  final List<FaIcon> categoryIcon = [
    FaIcon(FontAwesomeIcons.pills, color: Color.fromARGB(255, 59, 182, 162)),
    FaIcon(FontAwesomeIcons.appleWhole,
        color: Color.fromARGB(255, 59, 182, 162)),
    FaIcon(FontAwesomeIcons.leaf, color: Color.fromARGB(255, 59, 182, 162)),
    FaIcon(FontAwesomeIcons.list, color: Color.fromARGB(255, 59, 182, 162)),
  ];

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
                              fontSize: 12,
                              color: Colors.white,
                              fontFamily: ''),
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
          Padding(
            padding: EdgeInsets.only(top: 10, right: 20, left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("หมวดหมู่",
                    style: TextStyle(fontSize: 20, color: Colors.black)),
                SizedBox(height: 20),
                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount:
                        2, // Adjust to your preferred number of columns
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 2 / 1, // Adjust as needed
                  ),
                  itemCount: category.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 240, 240, 240),
                              shape: BoxShape.circle),
                          child: Center(
                            child: categoryIcon[index],
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          category[index],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
