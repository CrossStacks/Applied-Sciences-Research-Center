import 'package:asrc_flutter/models/auth_models.dart';
import 'package:asrc_flutter/services/api/auth_service.dart';
import 'package:asrc_flutter/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../utils/routing/routes_name.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _emailTxtController = TextEditingController();
  final TextEditingController _passwordTxtController = TextEditingController();
  final TextEditingController _confirmPasswordTxtController =
      TextEditingController();
  final TextEditingController _nameTxtController = TextEditingController();

  Future<void> _signUpHandler() async {
    String email = _emailTxtController.text;
    String password = _passwordTxtController.text;
    String confirmPassword = _confirmPasswordTxtController.text;
    String name = _nameTxtController.text;

    if (name == "" ||
        email == "" ||
        password == "" ||
        confirmPassword == "" ||
        (password != confirmPassword)) {
      Fluttertoast.showToast(
        msg: "Requirements not provided properly",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: AppColor.primaryColor,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return;
    }

    var (response, status) = await registerRequest(SignupRequestModel(
      email: email,
      password: password,
      name: name,
    ));

    if (status == "Ok")
      print(response!.email);
    else {
      print(status);
      Fluttertoast.showToast(
        msg: status,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: AppColor.whiteColor,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.lightGrey,
      appBar: AppBar(
        backgroundColor: AppColor.lightGrey,
      ),
      body: Center(
          child: Material(
        elevation: 10,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: 400,
          height: 570,
          padding: EdgeInsets.all(25),
          decoration: BoxDecoration(
            color: AppColor.whiteColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              Text(
                "Sign Up",
                style: TextStyle(
                  color: AppColor.secondaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                ),
              ),
              Text(
                "Welcome! Please sign up to get started.",
                style:
                    TextStyle(color: const Color.fromARGB(255, 142, 155, 161)),
              ),
              SizedBox(height: 50),
              TextField(
                controller: _nameTxtController,
                decoration: InputDecoration(
                  labelText: "Your Name...",
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: const Color.fromARGB(255, 204, 209, 211),
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: const Color.fromARGB(255, 204, 209, 211),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _emailTxtController,
                decoration: InputDecoration(
                  labelText: "Your email...",
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: const Color.fromARGB(255, 204, 209, 211),
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: const Color.fromARGB(255, 204, 209, 211),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _passwordTxtController,
                decoration: InputDecoration(
                  labelText: "Your password...",
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: const Color.fromARGB(255, 204, 209, 211),
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: const Color.fromARGB(255, 204, 209, 211),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _confirmPasswordTxtController,
                decoration: InputDecoration(
                  labelText: "Confirm password...",
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: const Color.fromARGB(255, 204, 209, 211),
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: const Color.fromARGB(255, 204, 209, 211),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              SizedBox(height: 45),
              TextButton(
                onPressed: () {
                  _signUpHandler();
                },
                style: TextButton.styleFrom(
                  backgroundColor: AppColor.secondaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 21, horizontal: 100),
                ),
                child: Text(
                  "SIGN UP",
                  style: TextStyle(color: Colors.white), // White text color
                ),
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () => {
                      Navigator.pop(context),
                    },
                    child: Text("Already have an account"),
                  ),
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}
