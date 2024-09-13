import "package:flutter/material.dart";
import "package:project/screens/Normal_User_Side/userdetail.dart";
import "package:project/screens/Pharmacist_Side/PharmacistDetail.dart";

class PharmacistWelcome extends StatelessWidget {
  const PharmacistWelcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.2,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(255, 66, 230, 148),
                  Color.fromARGB(255, 59, 178, 184),
                ],
              ),
            ),
          ),
          Container(
              margin: EdgeInsets.only(top: 80),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 100),
                    Image.asset("assets/welcomedoctor.png"),
                    Text("ยินดีต้อนรับ!!!!",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold)),
                    Text("คลิ๊กปุ่มด้านล่างเพื่อดำเนินการต่อ",
                        style: TextStyle(
                          fontSize: 25,
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 60,
                      child: ElevatedButton(
                        child: Text("คลิ๊กที่นี่",
                            style: TextStyle(color: Colors.white)),
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return PharmacistDetail();
                          }));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 59, 178,
                              184), // Make the button background transparent
                          shadowColor: const Color.fromARGB(255, 121, 121,
                              121), // Remove shadow to keep background clean
                          side: BorderSide(
                              color: Colors.white, width: 2), // White border
                          textStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
