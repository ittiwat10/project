import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:fluttertoast/fluttertoast.dart";
import "package:form_field_validator/form_field_validator.dart";
import "package:project/components/Provinces.dart";
import "package:project/components/profile.dart";
import "package:project/mainscreen.dart";
import "package:project/screens/Normal_User_Side/homescreen.dart";

class userdetail extends StatefulWidget {
  const userdetail({super.key});

  @override
  State<userdetail> createState() => _userdetailState();
}

class _userdetailState extends State<userdetail> {
  Profile profile = Profile();
  final formKey = GlobalKey<FormState>();
  CollectionReference _userCollection =
      FirebaseFirestore.instance.collection("Users");
  String? selectedProvince;

  // List of provinces in Thailan
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Center(
                    child: Column(
                      children: [
                        Text("กรอกข้อมูลของคุณ",
                            style: TextStyle(
                                fontSize: 30,
                                color: Color.fromARGB(255, 59, 178, 184),
                                fontWeight: FontWeight.bold)),
                        SizedBox(height: 20),
                        Form(
                          key: formKey,
                          child: Padding(
                            padding:
                                EdgeInsets.only(top: 20, left: 20, right: 20),
                            child: Column(
                              children: [
                                TextFormField(
                                  decoration: InputDecoration(
                                    labelText: "ชื่อ",
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    fillColor: Colors.white,
                                    filled: true,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(30.0),
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(30.0),
                                      ),
                                      borderSide: BorderSide(
                                        color: Color.fromARGB(255, 200, 200,
                                            200), // Set the default border color
                                        width: 1.5,
                                      ),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(30.0),
                                      ),
                                      borderSide: BorderSide(
                                        color: Colors
                                            .red, // Set the border color when there's an error
                                        width: 2.0,
                                      ),
                                    ),
                                    hintText: "พิมพ์ชื่อ",
                                    hintStyle: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black.withOpacity(0.5),
                                    ),
                                  ),
                                  validator: MultiValidator([
                                    (RequiredValidator(
                                        errorText: "กรุณาป้อนชื่อของคุณ")),
                                    PatternValidator(r'^[a-zA-Zก-ฮ\s]+$',
                                        errorText:
                                            "ชื่อไม่ควรมีตัวเลขหรือตัวอักษรพิเศษ"),
                                  ]),
                                  onSaved: (String? name) {
                                    profile.Name = name ?? '';
                                  },
                                ),

                                SizedBox(
                                    height: 20), // Spacing between the fields

                                TextFormField(
                                  decoration: InputDecoration(
                                    labelText: "นามสกุล",
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    fillColor: Colors.white,
                                    filled: true,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(30.0),
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(30.0),
                                      ),
                                      borderSide: BorderSide(
                                        color: Color.fromARGB(255, 200, 200,
                                            200), // Set the default border color
                                        width: 1.5,
                                      ),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(30.0),
                                      ),
                                      borderSide: BorderSide(
                                        color: Colors
                                            .red, // Set the border color when there's an error
                                        width: 2.0,
                                      ),
                                    ),
                                    hintText: "พิมพ์นามสกุล",
                                    hintStyle: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black.withOpacity(0.5),
                                    ),
                                  ),
                                  validator: MultiValidator([
                                    (RequiredValidator(
                                        errorText: "กรุณาป้อนนามสกุลของคุณ")),
                                    PatternValidator(r'^[a-zA-Zก-ฮ\s]+$',
                                        errorText:
                                            "นามสกุลไม่ควรมีตัวเลขหรือตัวอักษรพิเศษ"),
                                  ]),
                                  onSaved: (String? lastname) {
                                    profile.LastName = lastname ?? '';
                                  },
                                ),

                                SizedBox(
                                  height: 20,
                                ),
                                Row(children: [
                                  Expanded(
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        labelText: "อายุ",
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                        fillColor: Colors.white,
                                        filled: true,
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(30.0),
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(30.0),
                                          ),
                                          borderSide: BorderSide(
                                            color: Color.fromARGB(255, 200, 200,
                                                200), // Set the default border color
                                            width: 1.5,
                                          ),
                                        ),
                                        hintText: "พิมพ์อายุ",
                                        hintStyle: TextStyle(
                                            fontSize: 15,
                                            color:
                                                Colors.black.withOpacity(0.5)),
                                      ),
                                      keyboardType: TextInputType.number,
                                      validator: MultiValidator([
                                        (RequiredValidator(
                                            errorText: "กรุณาป้อนอายุของคุณ")),
                                      ]),
                                      onSaved: (String? age) {
                                        profile.Age = age ?? '';
                                      },
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: DropdownButtonFormField<String>(
                                        decoration: InputDecoration(
                                          labelText: "เพศ",
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.always,
                                          fillColor: Colors.white,
                                          filled: true,
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(30.0),
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(30.0),
                                            ),
                                            borderSide: BorderSide(
                                              color: Color.fromARGB(
                                                  255,
                                                  200,
                                                  200,
                                                  200), // Set the default border color
                                              width: 1.5,
                                            ),
                                          ),
                                          hintText: "",
                                          hintStyle: TextStyle(
                                            fontSize: 15,
                                            color:
                                                Colors.black.withOpacity(0.5),
                                          ),
                                        ),
                                        items: [
                                          DropdownMenuItem(
                                            value: 'ชาย',
                                            child: Text('ชาย'),
                                          ),
                                          DropdownMenuItem(
                                            value: 'หญิง',
                                            child: Text('หญิง'),
                                          ),
                                          DropdownMenuItem(
                                            value: 'อื่นๆ',
                                            child: Text('อื่นๆ'),
                                          ),
                                        ],
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            profile.Gender = newValue ?? '';
                                          });
                                        },
                                        validator: (value) =>
                                            value == null || value.isEmpty
                                                ? 'กรุณาเลือกเพศของคุณ'
                                                : null,
                                        onSaved: (value) {
                                          profile.Gender = value ?? '';
                                        }),
                                  ),
                                ]),
                                SizedBox(height: 20),
                                DropdownButtonFormField<String>(
                                  decoration: InputDecoration(
                                    labelText: "จังหวัด",
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    fillColor: Colors.white,
                                    filled: true,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(30.0),
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(30.0),
                                      ),
                                      borderSide: BorderSide(
                                        color: Color.fromARGB(255, 200, 200,
                                            200), // Set the default border color
                                        width: 1.5,
                                      ),
                                    ),
                                    hintText: "เลือกจังหวัด",
                                    hintStyle: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black.withOpacity(0.5),
                                    ),
                                  ),
                                  items: Provinces.getProvinces()
                                      .map((String province) {
                                    return DropdownMenuItem<String>(
                                      value: province,
                                      child: Text(province),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      selectedProvince = newValue;
                                    });
                                  },
                                  validator: (value) =>
                                      value == null || value.isEmpty
                                          ? 'กรุณาเลือกจังหวัดของคุณ'
                                          : null,
                                  onSaved: (value) {
                                    profile.Province = value;
                                  },
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  decoration: InputDecoration(
                                    labelText: "โรคประจำตัว",
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    fillColor: Colors.white,
                                    filled: true,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(30.0),
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(30.0),
                                      ),
                                      borderSide: BorderSide(
                                        color: Color.fromARGB(255, 200, 200,
                                            200), // Set the default border color
                                        width: 1.5,
                                      ),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(30.0),
                                      ),
                                      borderSide: BorderSide(
                                        color: Colors
                                            .red, // Set the border color when there's an error
                                        width: 2.0,
                                      ),
                                    ),
                                    hintText: "พิมพ์โรคประจำตัว",
                                    hintStyle: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black.withOpacity(0.5),
                                    ),
                                  ),
                                  validator: RequiredValidator(
                                      errorText: "กรุณากรอกช่องนี้"),
                                  onSaved: (String? disease) {
                                    profile.Con_disease = disease ?? '';
                                  },
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  decoration: InputDecoration(
                                    labelText: "ยาที่แพ้",
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    fillColor: Colors.white,
                                    filled: true,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(30.0),
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(30.0),
                                      ),
                                      borderSide: BorderSide(
                                        color: Color.fromARGB(255, 200, 200,
                                            200), // Set the default border color
                                        width: 1.5,
                                      ),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(30.0),
                                      ),
                                      borderSide: BorderSide(
                                        color: Colors
                                            .red, // Set the border color when there's an error
                                        width: 2.0,
                                      ),
                                    ),
                                    hintText: "พิมพ์ยาที่แพ้",
                                    hintStyle: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black.withOpacity(0.5),
                                    ),
                                  ),
                                  validator: RequiredValidator(
                                      errorText: "กรุณากรอกช่องนี้"),
                                  onSaved: (String? allergic) {
                                    profile.Allergic = allergic ?? '';
                                  },
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                ElevatedButton(
                                  child: Text("ยืนยัน",
                                      style: TextStyle(color: Colors.white)),
                                  onPressed: () async {
                                    if (formKey.currentState!.validate()) {
                                      formKey.currentState!.save();
                                      try {
                                        // Get current user's UID
                                        String uid = FirebaseAuth
                                            .instance.currentUser!.uid;

                                        // Save additional details in Firestore using the UID as document ID
                                        await _userCollection
                                            .doc(uid)
                                            .update(profile.toJson());

                                        formKey.currentState?.reset();
                                        Fluttertoast.showToast(
                                            msg: "บันทึกข้อมูลสำเร็จ",
                                            gravity: ToastGravity.TOP);
                                        Navigator.pushReplacement(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return MainScreen();
                                        }));
                                      } catch (e) {
                                        Fluttertoast.showToast(
                                            msg:
                                                "เกิดข้อผิดพลาดในการบันทึกข้อมูล",
                                            gravity: ToastGravity.CENTER);
                                      }
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 15,
                                      horizontal:
                                          MediaQuery.of(context).size.width *
                                              0.35,
                                    ),
                                    textStyle: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    backgroundColor:
                                        Color.fromARGB(255, 59, 178, 184),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
