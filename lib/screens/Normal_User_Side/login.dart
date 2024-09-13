import "package:firebase_auth/firebase_auth.dart";
import "package:firebase_core/firebase_core.dart";
import "package:flutter/material.dart";
import "package:fluttertoast/fluttertoast.dart";
import "package:form_field_validator/form_field_validator.dart";
import "package:project/components/Iconlogin.dart";
import "package:project/components/profile.dart";
import "package:project/mainscreen.dart";
import "package:project/screens/Normal_User_Side/welcome.dart";

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  final formKey = GlobalKey<FormState>();
  Profile profile = Profile();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            Colors.transparent, // Makes the AppBar background transparent
        elevation: 0, // Removes the shadow
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white), // Back button
          onPressed: () => Navigator.of(context).pop(), // Pop the current page
        ),
      ),
      extendBodyBehindAppBar: true, // Makes the body extend behind the AppBar
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
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
              margin: EdgeInsets.only(top: 200),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  Text("เข้าสู่ระบบ",
                      style: TextStyle(
                          fontSize: 30,
                          color: Color.fromARGB(255, 59, 178, 184),
                          fontWeight: FontWeight.bold)),
                  SizedBox(height: 20),
                  Form(
                    key: formKey,
                    child: Padding(
                      padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                      child: Column(
                        children: [
                          SizedBox(height: 20),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: "อีเมล",
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
                              hintText: "พิมพ์อีเมล",
                              hintStyle: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black.withOpacity(0.5)),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            validator: MultiValidator([
                              (RequiredValidator(
                                  errorText: "กรุณาป้อนอีเมลของคุณ")),
                              EmailValidator(errorText: "รูปแบบอีเมลไม่ถูกต้อง")
                            ]),
                            onSaved: (String? email) {
                              profile.Email = email ?? '';
                            },
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: "รหัสผ่าน",
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
                              hintText: "พิมพ์รหัสผ่าน",
                              hintStyle: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black.withOpacity(0.5)),
                            ),
                            obscureText: true,
                            validator: RequiredValidator(
                                errorText: "กรุณาป้อนรหัสของคุณ"),
                            onSaved: (String? password) {
                              profile.Password = password ?? '';
                            },
                          ),
                          SizedBox(height: 20),
                          SizedBox(
                            height: 30,
                          ),
                          ElevatedButton(
                            child: Text("เข้าสู่ระบบ",
                                style: TextStyle(color: Colors.white)),
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                formKey.currentState!.save();
                                // Perform registration logic here
                                try {
                                  await FirebaseAuth.instance
                                      .signInWithEmailAndPassword(
                                          email: profile.Email ?? '',
                                          password: profile.Password ?? '')
                                      .then((value) {
                                    formKey.currentState?.reset();
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      if (profile.Name != null) {
                                        return MainScreen();
                                      } else
                                        return welcome();
                                    }));
                                  });
                                } on FirebaseAuthException catch (e) {
                                  Fluttertoast.showToast(
                                      msg: e.message ?? '',
                                      gravity: ToastGravity.CENTER);
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                vertical: 15,
                                horizontal:
                                    MediaQuery.of(context).size.width * 0.35,
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
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Divider(
                        thickness: 1,
                        color: Colors.grey[200],
                      )),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "ดำเนินการด้วย",
                          style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                          child: Divider(
                        thickness: 1,
                        color: Colors.grey[200],
                      )),
                    ],
                  ),
                  SizedBox(height: 30),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Iconlogin(imagePath: 'assets/Facebook_Icons.png'),
                    SizedBox(width: 60),
                    Iconlogin(imagePath: 'assets/Google_Icons.png'),
                    SizedBox(width: 60),
                    Iconlogin(imagePath: 'assets/Apple_Icons.png')
                  ]),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("ยังไม่มีบัญชีงั้นเหรอ? "),
                      Text(
                        "ลงทะเบียนผู้ใช้",
                        style: TextStyle(
                            color: Color.fromARGB(255, 59, 178, 184),
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  )
                  // Add other widgets here if needed
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
