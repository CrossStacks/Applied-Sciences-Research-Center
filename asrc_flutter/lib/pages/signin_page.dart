import 'package:asrc_flutter/components/custom_button_widget.dart';
import 'package:flutter/material.dart';
import '../components/custom_input_widget.dart';
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

  void setLoading(bool value) {
    setState(() {
      isLoading = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 252, 246, 243),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Color.fromARGB(255, 236, 196, 164),
              ),
            )
          : Center(
              child: Material(
                elevation: 10,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  width: 400,
                  height: 490,
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    color: AppColor.whiteColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: GradientBorderContainer(
                    borderWidth: 2,
                    width: 350,
                    height: 260,
                    child: Column(
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
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color.fromARGB(255, 245, 245, 245),
                            labelStyle: TextStyle(color: Colors.grey),
                            hintStyle: TextStyle(color: Colors.grey),
                            labelText: 'Your email...',
                            hintText: 'example@gmail.com',
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _controller.passwordController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color.fromARGB(255, 245, 245, 245),
                            labelStyle: TextStyle(color: Colors.grey),
                            hintStyle: TextStyle(color: Colors.grey),
                            labelText: 'Your password...',
                            hintText: '********',
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
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
                          onTap: () =>
                              _controller.userLogin(context, setLoading),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: 10,
                          children: [
                            InkWell(
                              onTap: () {
                                // TODO: Implement Forgot Password
                              },
                              child: const Text(
                                "Forgot Password",
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                            const Text("|"),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  RouteName.signupPage,
                                );
                              },
                              child: const Text(
                                "Create Account",
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
