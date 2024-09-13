import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/screens/Normal_User_Side/AccountDetail.dart';
import 'package:project/screens/Normal_User_Side/login.dart'; // Assuming you have a login screen

class account extends StatefulWidget {
  const account({super.key});

  @override
  State<account> createState() => _accountState();
}

class _accountState extends State<account> {
  // Reference to Firestore
  final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('Users');

  // Method to get the current user's UID
  String? getCurrentUserUid() {
    User? user = FirebaseAuth.instance.currentUser;
    return user?.uid;
  }

  // Method to get user details from Firestore
  Future<Map<String, dynamic>?> getUserDetails() async {
    String? uid = getCurrentUserUid();
    if (uid != null) {
      DocumentSnapshot userDoc = await _userCollection.doc(uid).get();
      if (userDoc.exists) {
        return userDoc.data() as Map<String, dynamic>?;
      }
    }
    return null;
  }

  // Method to log out the user
  Future<void> _logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => login()));
  }

  // Method to delete the user's account
  Future<void> _deleteAccount() async {
    String? uid = getCurrentUserUid();
    if (uid != null) {
      try {
        // Delete user from Firestore
        await _userCollection.doc(uid).delete();
        // Delete user authentication
        User? user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          await user.delete();
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Account deleted successfully')),
        );
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => login()));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to delete account: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
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
              child: Column(
                children: [
                  FutureBuilder<Map<String, dynamic>?>(
                    future: getUserDetails(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text("Error: ${snapshot.error}"));
                      } else if (snapshot.hasData && snapshot.data != null) {
                        // Retrieve name, lastName, and email from the snapshot data
                        String name = snapshot.data!['Name'] ?? 'Unknown';
                        String lastName =
                            snapshot.data!['LastName'] ?? 'Unknown';
                        String email =
                            snapshot.data!['Email'] ?? 'No email provided';
                        String fullName = '$name $lastName';

                        return Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 20),
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromARGB(255, 212, 212, 212),
                                offset: Offset(0, 0),
                                spreadRadius: 1.0,
                                blurRadius: 7.0,
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "ข้อมูลส่วนตัว",
                                      style: TextStyle(
                                          fontSize: 20,
                                          color:
                                              Color.fromARGB(255, 59, 178, 184),
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 30,
                                          backgroundImage: NetworkImage(
                                            'https://via.placeholder.com/150', // Replace with actual image URL or AssetImage
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              fullName,
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: Color.fromARGB(
                                                    255, 0, 0, 0),
                                              ),
                                            ),
                                            SizedBox(height: 5),
                                            Text(
                                              email,
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Color.fromARGB(
                                                    255, 100, 100, 100),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.arrow_forward_ios,
                                    color: Color.fromARGB(255, 59, 178, 184)),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) {
                                      return AccountDetail();
                                    }),
                                  ).then((value) {
                                    setState(() {});
                                  });
                                },
                              ),
                            ],
                          ),
                        );
                      } else {
                        return Center(
                            child: Text("No user details available."));
                      }
                    },
                  ),
                  Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(255, 212, 212, 212),
                            offset: Offset(0, 0),
                            spreadRadius: 1.0,
                            blurRadius: 7.0,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: Text(
                              "ข้อมูลสุขภาพและประวัติการใช้งาน",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Color.fromARGB(255, 59, 178, 184),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "ประวัติการสั่งซื้อ",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              IconButton(
                                icon: Icon(Icons.arrow_forward_ios),
                                onPressed: () {
                                  // Define action for button
                                },
                              ),
                            ],
                          ),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "ยาประจำตัว",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              IconButton(
                                icon: Icon(Icons.arrow_forward_ios),
                                onPressed: () {
                                  // Define action for button
                                },
                              ),
                            ],
                          ),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "ยาที่แพ้",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              IconButton(
                                icon: Icon(Icons.arrow_forward_ios),
                                onPressed: () {
                                  // Define action for button
                                },
                              ),
                            ],
                          ),
                        ],
                      )),
                  Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(255, 212, 212, 212),
                            offset: Offset(0, 0),
                            spreadRadius: 1.0,
                            blurRadius: 7.0,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: Text(
                              "อื่นๆ",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Color.fromARGB(255, 59, 178, 184),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "เปลี่ยนภาษา",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              IconButton(
                                icon: Icon(Icons.arrow_forward_ios),
                                onPressed: () {
                                  // Define action for button
                                },
                              ),
                            ],
                          ),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "การแจ้งเตือน",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              IconButton(
                                icon: Icon(Icons.arrow_forward_ios),
                                onPressed: () {
                                  // Define action for button
                                },
                              ),
                            ],
                          ),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "การยืนยันตัวตน",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              IconButton(
                                icon: Icon(Icons.arrow_forward_ios),
                                onPressed: () {
                                  // Define action for button
                                },
                              ),
                            ],
                          ),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "การเชื่อมตัว",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              IconButton(
                                icon: Icon(Icons.arrow_forward_ios),
                                onPressed: () {
                                  // Define action for button
                                },
                              ),
                            ],
                          ),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "เปิดร้านกับ PharmaDrop",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              IconButton(
                                icon: Icon(Icons.arrow_forward_ios),
                                onPressed: () {
                                  // Define action for button
                                },
                              ),
                            ],
                          ),
                          Divider(),
                          SizedBox(height: 8),
                          GestureDetector(
                            onTap: _logout, // Call the _logout method
                            child: Text(
                              "ออกจากระบบ",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red),
                            ),
                          ),
                          SizedBox(height: 8),
                          Divider(),
                          SizedBox(height: 10),
                          GestureDetector(
                            onTap:
                                _deleteAccount, // Call the _deleteAccount method
                            child: Text(
                              "ลบบัญชี",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red),
                            ),
                          ),
                          SizedBox(height: 8),
                        ],
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
