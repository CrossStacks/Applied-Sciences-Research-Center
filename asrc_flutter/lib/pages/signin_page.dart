import 'package:asrc_flutter/models/auth_models.dart';
import 'package:asrc_flutter/pages/ojs_page.dart';
import 'package:asrc_flutter/pages/signup_page.dart';
import 'package:asrc_flutter/services/api/auth_service.dart';
import 'package:asrc_flutter/utils/colors.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _emailTxtController = TextEditingController();
  final TextEditingController _passwordTxtController = TextEditingController();

  Future<void> _loginHandler() async {
    String email = _emailTxtController.text;
    String password = _passwordTxtController.text;

    var (response, status) =
        await loginRequest(LoginRequestModel(email: email, password: password));

    // TODO
    if (status == "Ok") {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => OjsPage()));
    } else
      print(status);
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
          height: 450,
          padding: EdgeInsets.all(25),
          decoration: BoxDecoration(
            color: AppColor.whiteColor,
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
              SizedBox(height: 50),
              TextButton(
                onPressed: () {
                  _loginHandler();
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
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => SignUpPage()))
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
