import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:project/components/Provinces.dart';
import 'package:project/components/profile.dart';

class AccountDetail extends StatefulWidget {
  const AccountDetail({super.key});

  @override
  State<AccountDetail> createState() => _AccountDetailState();
}

class _AccountDetailState extends State<AccountDetail> {
  final _formKey = GlobalKey<FormState>();
  final Profile profile = Profile();
  final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection("Users");

  @override
  void initState() {
    super.initState();
  }

  // Method to get the current user's UID
  String? getCurrentUserUid() {
    User? user = FirebaseAuth.instance.currentUser;
    return user?.uid;
  }

  @override
  Widget build(BuildContext context) {
    String? uid = getCurrentUserUid();
    if (uid == null) {
      // If UID is null, show an error message
      return Scaffold(
        body: Center(
            child: Text("User not logged in",
                style: TextStyle(color: Colors.white))),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title:
            Text("แก้ไขข้อมูลส่วนตัว", style: TextStyle(color: Colors.white)),
        backgroundColor: Color.fromARGB(255, 59, 178, 184),
        iconTheme: IconThemeData(
            color: Colors.white), // Set app bar icon color to white
      ),
      backgroundColor: Color.fromARGB(255, 59, 178, 184),
      body: StreamBuilder<DocumentSnapshot>(
        stream: _userCollection.doc(uid).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
                child: Text("Error: ${snapshot.error}",
                    style: TextStyle(color: Colors.white)));
          } else if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(
                child: Text("No data available.",
                    style: TextStyle(color: Colors.white)));
          }

          // Extract data from snapshot
          var userDoc = snapshot.data!;
          profile.Name = userDoc['Name'] ?? '';
          profile.LastName = userDoc['LastName'] ?? '';
          profile.Email = userDoc['Email'] ?? '';
          profile.Age = userDoc['Age'] ?? '';
          profile.Gender = userDoc['Gender'] ?? '';
          profile.Province = userDoc['Province'] ?? '';
          profile.Con_disease = userDoc['ChronicDisease'] ?? '';
          profile.Allergic = userDoc['Allergic'] ?? '';

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  TextFormField(
                    initialValue: profile.Name,
                    style: TextStyle(
                        color: Colors.white), // Set text color to white
                    decoration: InputDecoration(
                      labelText: "ชื่อ",
                      labelStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 20), // Label text color
                    ),
                    validator:
                        RequiredValidator(errorText: "กรุณาป้อนชื่อของคุณ"),
                    onSaved: (value) => profile.Name = value ?? '',
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    initialValue: profile.LastName,
                    style: TextStyle(
                        color: Colors.white), // Set text color to white
                    decoration: InputDecoration(
                      labelText: "นามสกุล",
                      labelStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 20), // Label text color
                    ),
                    validator:
                        RequiredValidator(errorText: "กรุณาป้อนนามสกุลของคุณ"),
                    onSaved: (value) => profile.LastName = value ?? '',
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    initialValue: profile.Email,
                    style: TextStyle(
                        color: Colors.white), // Set text color to white
                    decoration: InputDecoration(
                      labelText: "อีเมล",
                      labelStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 20), // Label text color
                    ),
                    readOnly: true, // Email should not be editable
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    initialValue: profile.Age,
                    style: TextStyle(
                        color: Colors.white), // Set text color to white
                    decoration: InputDecoration(
                      labelText: "อายุ",
                      labelStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 20), // Label text color
                    ),
                    validator:
                        RequiredValidator(errorText: "กรุณาป้อนอายุของคุณ"),
                    onSaved: (value) => profile.Age = value ?? '',
                  ),
                  SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: profile.Gender,
                    decoration: InputDecoration(
                      labelText: "เพศ",
                      labelStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 20), // Label text color
                    ),
                    style: TextStyle(
                        color: Colors.white), // Set dropdown text color
                    dropdownColor: Color.fromARGB(
                        255, 59, 178, 184), // Dropdown menu background color
                    items: [
                      DropdownMenuItem(value: 'ชาย', child: Text('ชาย')),
                      DropdownMenuItem(value: 'หญิง', child: Text('หญิง')),
                      DropdownMenuItem(value: 'อื่นๆ', child: Text('อื่นๆ')),
                    ],
                    onChanged: (value) =>
                        setState(() => profile.Gender = value ?? ''),
                    validator: (value) => value == null || value.isEmpty
                        ? 'กรุณาเลือกเพศของคุณ'
                        : null,
                  ),
                  SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: profile.Province != null &&
                            Provinces.getProvinces().contains(profile.Province)
                        ? profile.Province
                        : null, // Set to null if profile.Province does not match any items
                    decoration: InputDecoration(
                      labelText: "จังหวัด",
                      labelStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 20), // Label text color
                    ),
                    style: TextStyle(
                        color: Colors.white), // Set dropdown text color
                    dropdownColor: Color.fromARGB(
                        255, 59, 178, 184), // Dropdown menu background color
                    items: Provinces.getProvinces().map((String province) {
                      return DropdownMenuItem<String>(
                        value: province,
                        child: Text(province),
                      );
                    }).toList(),
                    onChanged: (value) =>
                        setState(() => profile.Province = value ?? ''),
                    validator: (value) => value == null || value.isEmpty
                        ? 'กรุณาเลือกจังหวัดของคุณ'
                        : null,
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    initialValue: profile.Con_disease,
                    style: TextStyle(
                        color: Colors.white), // Set text color to white
                    decoration: InputDecoration(
                      labelText: "โรคประจำตัว",
                      labelStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 20), // Label text color
                    ),
                    onSaved: (value) => profile.Con_disease = value ?? '',
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    initialValue: profile.Allergic,
                    style: TextStyle(
                        color: Colors.white), // Set text color to white
                    decoration: InputDecoration(
                      labelText: "ยาที่แพ้",
                      labelStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 20), // Label text color
                    ),
                    onSaved: (value) => profile.Allergic = value ?? '',
                  ),
                  SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: _saveDetails,
                    child: Text(
                      "ยืนยัน",
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue, // Button color
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // Save updated user details
  void _saveDetails() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      String? uid = getCurrentUserUid();
      if (uid != null) {
        await _userCollection.doc(uid).update(profile.toJson());
        Fluttertoast.showToast(
            msg: "ข้อมูลถูกอัปเดตเรียบร้อยแล้ว", gravity: ToastGravity.CENTER);
        Navigator.pop(context); // Go back to account screen
      }
    }
  }
}
