import 'package:flutter/material.dart';

class order extends StatefulWidget {
  const order({super.key});

  @override
  State<order> createState() => _orderState();
}

class _orderState extends State<order> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            padding: EdgeInsets.only(top: 50, left: 30, right: 30, bottom: 30),
            height: MediaQuery.of(context).size.height * 0.15,
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
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "รายการ",
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () {
                        // Button action
                      },
                      icon: Icon(
                        Icons.history,
                        color: Colors.white, // Icon color
                      ),
                      label: Text(
                        "ประวัติ",
                        style: TextStyle(
                            color: Colors.white, // Text color
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        side: BorderSide(
                            color: Colors.white), // For ripple effectect
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
              height: MediaQuery.of(context).size.height * 0.75,
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("ยังไม่มีรายการตอนนี้",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold)),
                  Text("หากเริ่มใช้บริการแล้ว รายการของคุณจะปรากฎที่นี่")
                ],
              )))
        ],
      ),
    );
  }
}
