import 'package:flutter/material.dart';
import '../controllers/sign_up_controller.dart';
import '../utils/colors.dart';
import '../components/custom_button_widget.dart';
import '../components/gradient_border_container.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final SignUpController _controller = SignUpController();
  bool isLoading = false;
  bool _isPasswordObscured = true;

  void setLoading(bool value) {
    setState(() {
      isLoading = value;
    });
  }

  InputDecoration buildInputDecoration({
    required String labelText,
    required String hintText,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      filled: true,
      fillColor: const Color.fromARGB(255, 245, 245, 245),
      labelStyle: const TextStyle(color: Colors.grey),
      hintStyle: const TextStyle(color: Colors.grey),
      labelText: labelText,
      hintText: hintText,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
        borderSide: const BorderSide(color: Colors.transparent),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
        borderSide: const BorderSide(color: Colors.transparent),
      ),
      hoverColor: Colors.transparent,
      suffixIcon: suffixIcon,
    );
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
            width: 450,
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
                        child: Column(
                          children: [
                            ShaderMask(
                              blendMode: BlendMode.srcIn,
                              shaderCallback: (bounds) => const LinearGradient(
                                colors: [
                                  Color.fromARGB(255, 241, 106, 106),
                                  Color.fromARGB(255, 255, 171, 93),
                                ],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ).createShader(bounds),
                              child: const Text(
                                "Sign Up",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 40,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            GestureDetector(
                              onTap: () async {
                                await _controller.pickProfileImage();
                                setState(() {});
                              },
                              child: CircleAvatar(
                                radius: 60,
                                backgroundImage:
                                    _controller.profileImage != null
                                        ? MemoryImage(_controller.profileImage!)
                                        : null,
                                backgroundColor: Colors.grey,
                                child: _controller.profileImage == null
                                    ? const Icon(Icons.camera_alt,
                                        size: 60, color: Colors.white)
                                    : null,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: _controller.firstNameController,
                                    keyboardType: TextInputType.name,
                                    decoration: buildInputDecoration(
                                      labelText: 'First name...',
                                      hintText: 'Your given name...',
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: TextFormField(
                                    controller: _controller.lastNameController,
                                    keyboardType: TextInputType.name,
                                    decoration: buildInputDecoration(
                                      labelText: 'Last name...',
                                      hintText: 'Your family name...',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: _controller.emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: buildInputDecoration(
                                labelText: 'Your email...',
                                hintText: 'username...@example.com',
                              ),
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: _controller.passwordController,
                              obscureText: _isPasswordObscured,
                              keyboardType: TextInputType.visiblePassword,
                              decoration: buildInputDecoration(
                                labelText: 'Password...',
                                hintText: _isPasswordObscured
                                    ? '********'
                                    : 'S3cur3P4ssw0rd...',
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _isPasswordObscured
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: Colors.grey,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _isPasswordObscured =
                                          !_isPasswordObscured;
                                    });
                                  },
                                ),
                              ),
                              // validator: (value) {
                              //   if (value == null || value.isEmpty) {
                              //     return 'Please enter a password';
                              //   }
                              //   if (value.length < 6) {
                              //     return 'Password must be at least 6 characters';
                              //   }
                              //   return null;
                              // },
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: _controller.confirmPasswordController,
                              obscureText: _isPasswordObscured,
                              keyboardType: TextInputType.visiblePassword,
                              decoration: buildInputDecoration(
                                labelText: 'Confirm Password...',
                                hintText: _isPasswordObscured
                                    ? '********'
                                    : 'S3cur3P4ssw0rd...',
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _isPasswordObscured
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: Colors.grey,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _isPasswordObscured =
                                          !_isPasswordObscured;
                                    });
                                  },
                                ),
                              ),
                              // validator: (value) {
                              //   if (value == null || value.isEmpty) {
                              //     return 'Please confirm your password';
                              //   }
                              //   if (value !=
                              //       _controller.passwordController.text) {
                              //     return 'Passwords do not match';
                              //   }
                              //   return null;
                              // },
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: _controller.professionController,
                              keyboardType: TextInputType.text,
                              decoration: buildInputDecoration(
                                labelText: 'Profession...',
                                hintText: 'e.g. Zoologist...',
                              ),
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: _controller.linkedInController,
                              keyboardType: TextInputType.url,
                              decoration: buildInputDecoration(
                                labelText: 'LinkedIn profile URL...',
                                hintText: 'https://linkedin.com/in/username...',
                              ),
                            ),
                            const SizedBox(height: 20),
                            DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                filled: true,
                                fillColor:
                                    const Color.fromARGB(255, 245, 245, 245),
                                labelStyle: const TextStyle(color: Colors.grey),
                                hintStyle: const TextStyle(color: Colors.grey),
                                labelText: 'Qualification level...',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  borderSide: BorderSide.none,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  borderSide: const BorderSide(
                                      color: Colors.transparent),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  borderSide: const BorderSide(
                                      color: Colors.transparent),
                                ),
                                hoverColor: Colors.transparent,
                              ),
                              dropdownColor:
                                  const Color.fromARGB(255, 246, 246, 246),
                              borderRadius: BorderRadius.circular(25.0),
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.black),
                              value: _controller.qualificationLevel,
                              items:
                                  _controller.qualificationLevels.map((level) {
                                return DropdownMenuItem<String>(
                                  value: level,
                                  child: Text(
                                    level,
                                    style: const TextStyle(
                                        fontSize: 14, color: Colors.black),
                                  ),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  _controller.qualificationLevel = value;
                                });
                              },
                            ),
                            const SizedBox(height: 20),
                            DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                filled: true,
                                fillColor:
                                    const Color.fromARGB(255, 245, 245, 245),
                                labelStyle: const TextStyle(color: Colors.grey),
                                hintStyle: const TextStyle(color: Colors.grey),
                                labelText: 'Designation...',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  borderSide: BorderSide.none,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  borderSide: const BorderSide(
                                      color: Colors.transparent),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  borderSide: const BorderSide(
                                      color: Colors.transparent),
                                ),
                                hoverColor: Colors.transparent,
                              ),
                              dropdownColor:
                                  const Color.fromARGB(255, 246, 246, 246),
                              borderRadius: BorderRadius.circular(25.0),
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.black),
                              value: _controller.designation,
                              items:
                                  _controller.designations.map((designation) {
                                return DropdownMenuItem(
                                  value: designation,
                                  child: Text(designation),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  _controller.designation = value;
                                });
                              },
                            ),
                            const SizedBox(height: 20),
                            DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                filled: true,
                                fillColor:
                                    const Color.fromARGB(255, 245, 245, 245),
                                labelStyle: const TextStyle(color: Colors.grey),
                                hintStyle: const TextStyle(color: Colors.grey),
                                labelText: 'Editorial role...',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  borderSide: BorderSide.none,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  borderSide: const BorderSide(
                                      color: Colors.transparent),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  borderSide: const BorderSide(
                                      color: Colors.transparent),
                                ),
                                hoverColor: Colors.transparent,
                              ),
                              dropdownColor:
                                  const Color.fromARGB(255, 246, 246, 246),
                              borderRadius: BorderRadius.circular(25.0),
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.black),
                              value: _controller.editorialRole,
                              items: _controller.editorialRoles.map((role) {
                                return DropdownMenuItem(
                                  value: role,
                                  child: Text(role),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  _controller.editorialRole = value;
                                });
                              },
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: _controller.aboutController,
                              keyboardType: TextInputType.multiline,
                              maxLines: 5,
                              maxLength: 1000,
                              decoration: buildInputDecoration(
                                labelText: 'About you...',
                                hintText: 'Tell about yourself...',
                              ),
                              // validator: (value) {
                              //   if (value == null || value.isEmpty) {
                              //     return 'Please tell us about yourself';
                              //   }
                              //   if (value.length > 1000) {
                              //     return 'About you must be less than 1000 characters';
                              //   }
                              //   return null;
                              // },
                            ),
                            const SizedBox(height: 20),
                            CustomButtonWidget(
                              text: 'Sign Up',
                              textStyle: const TextStyle(fontSize: 18),
                              width: 182.92,
                              initialGradient: const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color.fromARGB(255, 133, 81, 246),
                                  Color.fromARGB(255, 80, 29, 190),
                                ],
                              ),
                              hoverGradient: const LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [Colors.black, Colors.black],
                              ),
                              initialTextColor: Colors.white,
                              hoverTextColor: Colors.white,
                              onTap: () {
                                if (_controller.formKey.currentState!
                                    .validate()) {
                                  _controller.userSignUp(context, setLoading);
                                }
                              },
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    "Already have an account? Sign In",
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
        ),
      ),
    );
  }
}
