import 'package:flutter/material.dart';

class payment extends StatefulWidget {
  const payment({super.key});

  @override
  State<payment> createState() => _paymentState();
}

class _paymentState extends State<payment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(padding: EdgeInsets.zero, children: [
      Container(
        padding: EdgeInsets.only(top: 50, left: 30, right: 30, bottom: 30),
        height: MediaQuery.of(context).size.height * 0.2,
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
        child: Center(
            child: Text(
          "ชำระเงิน",
          style: TextStyle(color: Colors.white, fontSize: 25),
        )),
      ),
      SizedBox(
        height: 10,
      ),
      Padding(
          padding: EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("เลือกวิธีการชำระเงิน",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ))
            ],
          ))
    ]));
  }
}
