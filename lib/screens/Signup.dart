import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:notes_app/screens/Login.dart';
import 'package:notes_app/screens/setting.dart';
import 'package:notes_app/services/database.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController Confirm_email = TextEditingController();
  TextEditingController pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 70,
              left: 0,
              right: 0,
              child: CircleAvatar(
                backgroundImage: AssetImage("assets/logo.png"),
                radius: 100,
                backgroundColor: Colors.blueGrey.shade100,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blueGrey.shade50,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                height: 500,
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 45),

                      TextFormField(
                        controller: email,
                        decoration: InputDecoration(
                          label: Text("Email"),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Email required";
                          }
                          if (!value.contains("@gmail.com")) {
                            return "Enter valid email";
                          }
                          return null;
                        },
                      ),

                      SizedBox(height: 10),
                      TextFormField(
                        controller: Confirm_email,
                        decoration: InputDecoration(
                          label: Text("Confirm Email"),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Email required";
                          }
                          if (value != email.text) {
                            return " Email Mismatched";
                          }
                          return null;
                        },
                      ),

                      SizedBox(height: 10),

                      TextFormField(
                        controller: pass,
                        decoration: InputDecoration(
                          label: Text("Password"),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Password required";
                          }

                          return null;
                        },
                      ),
                      SizedBox(height: 10),

                      TextFormField(
                        decoration: InputDecoration(
                          label: Text("Confirm Password"),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Password required";
                          }
                          if (value != pass.text) {
                            return "Password Mismatched";
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 70,
              right: 60,
              child: Container(
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      try {
                    var result= await firebase.Signup
                        (
                          email.text.trim(),
                          pass.text.trim()
                      );
                    if(result==true){
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Signup Sucessfully"))
                      );
                      _formKey.currentState!.reset();
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context)=>Login()));
                    }

                      }
                      catch(e){
                        print("error $e");
                      }
                    }
                  },
                  child: Text("Signup"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade300,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Center(
                child: RichText(
                  text: TextSpan(
                    text: "Already have an  have an account ? ",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(
                        text: "Login",
                        style: TextStyle(color: Colors.blue),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => Login()),
                            );
                          },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
