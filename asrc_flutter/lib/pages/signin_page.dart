import 'package:asrc_flutter/components/custom_button_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../components/gradient_border_container.dart';
import '../controllers/sign_in_controller.dart';
import '../utils/colors.dart';
import '../utils/routing/routes_name.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final SignInController _controller = SignInController();
  bool isLoading = false;
  bool _isObscured = true;

  void setLoading(bool value) {
    setState(() {
      isLoading = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 243, 240, 236),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Material(
          elevation: 10,
          borderRadius: BorderRadius.circular(25),
          child: Container(
            width: 400,
            height: 550,
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(
              color: AppColor.whiteColor,
              borderRadius: BorderRadius.circular(25),
            ),
            child: GradientBorderContainer(
              borderWidth: 1.5,
              child: isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Color.fromARGB(255, 236, 196, 164),
                      ),
                    )
                  : Form(
                      key: _controller.formKey,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          spacing: 20,
                          children: [
                            ShaderMask(
                              blendMode: BlendMode.srcIn,
                              shaderCallback: (bounds) => LinearGradient(
                                colors: [
                                  Color.fromARGB(255, 241, 106, 106),
                                  Color.fromARGB(255, 255, 171, 93),
                                ],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ).createShader(bounds),
                              child: const Text(
                                "Sign In",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 40,
                                ),
                              ),
                            ),
                            const Text(
                              "Welcome back! Please sign in to continue",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
                                color: Color.fromARGB(135, 0, 0, 0),
                              ),
                            ),
                            const SizedBox(height: 50),
                            TextFormField(
                              controller: _controller.emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Color.fromARGB(255, 245, 245, 245),
                                labelStyle: TextStyle(color: Colors.grey),
                                hintStyle: TextStyle(color: Colors.grey),
                                labelText: 'Your email...',
                                hintText: 'username...@example.com',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  borderSide: const BorderSide(
                                    color: Colors.transparent,
                                    // color: Color.fromARGB(255, 236, 196, 164),
                                    // width: 2,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  borderSide: const BorderSide(
                                    color: Colors.transparent,
                                    // color: Colors.grey,
                                    // width: 2,
                                  ),
                                ),
                                hoverColor: Colors.transparent,
                              ),
                            ),
                            TextFormField(
                              controller: _controller.passwordController,
                              obscureText: _isObscured,
                              keyboardType: TextInputType.visiblePassword,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Color.fromARGB(255, 245, 245, 245),
                                labelStyle: TextStyle(color: Colors.grey),
                                hintStyle: TextStyle(color: Colors.grey),
                                labelText: 'Your password...',
                                hintText: _isObscured
                                    ? '********'
                                    : 'S3cur3P4ssw0rd...',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  borderSide: const BorderSide(
                                    color: Colors.transparent,
                                    // color: Color.fromARGB(255, 236, 196, 164),
                                    // width: 2,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  borderSide: const BorderSide(
                                    color: Colors.transparent,
                                    // color: Colors.grey,
                                    // width: 2,
                                  ),
                                ),
                                hoverColor: Colors.transparent,
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _isObscured
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: Colors.grey,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _isObscured = !_isObscured;
                                    });
                                  },
                                ),
                              ),
                            ),
                            CustomButtonWidget(
                              text: 'Sign In',
                              textStyle: TextStyle(
                                fontSize: 18,
                              ),
                              width: 182.92,
                              initialGradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color.fromARGB(255, 133, 81, 246),
                                  Color.fromARGB(255, 80, 29, 190),
                                ],
                              ),
                              hoverGradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  Colors.black,
                                  Colors.black,
                                ],
                              ),
                              initialTextColor: Colors.white,
                              hoverTextColor: Colors.white,
                              onTap: () => {
                                _controller.userLogin(context, setLoading),
                              },
                            ),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Forgot Password",
                                    style: const TextStyle(color: Colors.blue),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        // TODO: Implement Forgot Password
                                      },
                                  ),
                                  const TextSpan(
                                    text: "\t\t|\t\t",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  TextSpan(
                                    text: "Create Account",
                                    style: const TextStyle(color: Colors.blue),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.pushNamed(
                                          context,
                                          RouteName.signupPage,
                                        );
                                      },
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
