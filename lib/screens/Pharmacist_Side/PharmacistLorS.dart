import "package:flutter/material.dart";
import "package:project/screens/Pharmacist_Side/PharmacistLogin.dart";
import "package:project/screens/Pharmacist_Side/PharmacistRegister.dart";

class PharmacistLorS extends StatelessWidget {
  const PharmacistLorS({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent, // Make the AppBar transparent
          elevation: 0, // Remove shadow under the AppBar
          leading: IconButton(
            icon: Icon(Icons.arrow_back,
                color: Colors.white), // Arrow back icon with white color
            onPressed: () {
              Navigator.pop(context); // Go back to the previous screen
            },
          ),
        ),
        extendBodyBehindAppBar: true, // Extend body behind the AppBar
        body: Container(
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
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 150),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 180),
                    child: Column(
                      children: [
                        Image.asset("assets/Logo.png", width: 250),
                        Text(
                          "PHARMACIST",
                          style: TextStyle(
                              fontSize: 40,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      child: Text("เข้าสู่ระบบ",
                          style: TextStyle(
                            color: Color.fromARGB(255, 59, 178, 184),
                          )),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return PharmacistLogin();
                        }));
                      },
                      style: ElevatedButton.styleFrom(
                        textStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        backgroundColor: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      child: Text("ลงทะเบียน",
                          style: TextStyle(color: Colors.white)),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return PharmacistRegister();
                        }));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors
                            .transparent, // Make the button background transparent
                        shadowColor: Colors
                            .transparent, // Remove shadow to keep background clean
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
            )));
  }
}
