import 'package:asrc_flutter/utils/colors.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

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
          height: 450,
          padding: EdgeInsets.all(25),
          decoration: BoxDecoration(
            color: AppColor.primaryColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              Text(
                "Sign In",
                style: TextStyle(
                  color: AppColor.secondaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                ),
              ),

              Text(
                "Welcome back! Please sign in to continue",
                style:
                    TextStyle(color: const Color.fromARGB(255, 142, 155, 161)),
              ),

              SizedBox(height: 50),
              // Align(
              //   alignment: Alignment.centerLeft,
              //   child: Text("Email Address"),
              // ),
              // SizedBox(height: 5),

              TextField(
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

              // Align(
              //   alignment: Alignment.centerLeft,
              //   child: Text("Password"),
              // ),
              TextField(
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

              SizedBox(height: 50),

              TextButton(
                onPressed: () {
                  //TODO
                },
                style: TextButton.styleFrom(
                  backgroundColor: AppColor.secondaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 21, horizontal: 100),
                ),
                child: Text(
                  "SIGN IN",
                  style: TextStyle(color: Colors.white), // White text color
                ),
              ),

              SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () => {
                      //TODO
                    },
                    child: Text("Forgot Password"),
                  ),
                  Text("|"),
                  TextButton(
                    onPressed: () => {
                      //TODO
                    },
                    child: Text("Create Account"),
                  )
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}
