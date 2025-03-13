import 'package:asrc_flutter/components/custom_button_widget.dart';
import 'package:flutter/material.dart';
import '../components/gradient_border_container.dart';
import '../utils/colors.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController linkedInController = TextEditingController();
  final TextEditingController professionController = TextEditingController();
  String? qualificationLevel;
  String? designation;
  String? editorialRole;
  final List<String> qualificationLevels = ['PhD', 'Masters', 'Bachelors'];
  final List<String> designations = [
    'Lecturer',
    'Assistant Lecturer',
    'Assistant Professor',
    'Associate Professor',
    'Professor',
    'Senior Professor',
    'Emeritus Professor',
    'Visiting Professor',
    'Research Professor',
    'Adjunct Professor',
    'Instructor',
  ];

  final List<String> editorialRoles = [
    'Chief Editor',
    'Senior Editor',
    'Managing Editor',
    'Associate Editor',
    'Assistant Editor',
    'Editorial Assistant',
    'Copy Editor',
    'Technical Editor',
    'Contributing Editor',
    'Review Editor',
    'Consulting Editor',
    'Editorial Board Member',
    'Section Editor',
    'Proofreader',
    'Editorial Intern',
  ];
  ImageProvider? profileImage;
  bool isLoading = false;

  void setLoading(bool value) {
    setState(() {
      isLoading = value;
    });
  }

  void pickProfileImage() {
    // TODO: Implement image picker functionality.
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
                      key: _formKey,
                      child: SingleChildScrollView(
                        child: Column(
                          spacing: 20,
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
                            GestureDetector(
                              onTap: () => pickProfileImage(),
                              child: CircleAvatar(
                                radius: 40,
                                backgroundImage: profileImage,
                                backgroundColor: Colors.grey,
                                child: profileImage == null
                                    ? const Icon(Icons.camera_alt,
                                        size: 40, color: Colors.white)
                                    : null,
                              ),
                            ),
                            TextFormField(
                              controller: firstNameController,
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Color.fromARGB(255, 245, 245, 245),
                                labelStyle: TextStyle(color: Colors.grey),
                                hintStyle: TextStyle(color: Colors.grey),
                                labelText: 'First name...',
                                hintText: 'Your given name...',
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
                                  return 'Please enter your first name';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              controller: lastNameController,
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Color.fromARGB(255, 245, 245, 245),
                                labelStyle: TextStyle(color: Colors.grey),
                                hintStyle: TextStyle(color: Colors.grey),
                                labelText: 'Last name...',
                                hintText: 'Your family name...',
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
                                  return 'Please enter your last name';
                                }
                                return null;
                              },
                            ),
                            DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                filled: true,
                                labelStyle: TextStyle(color: Colors.grey),
                                fillColor: Color.fromARGB(255, 245, 245, 245),
                                labelText: 'Qualification Level...',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  borderSide: const BorderSide(
                                    color: Colors.transparent,
                                    // color: Color.fromARGB(255, 236, 196, 164),
                                    // width: 2,
                                  ),
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
                              dropdownColor: Color.fromARGB(255, 246, 246, 246),
                              borderRadius: BorderRadius.circular(25.0),
                              style:
                                  TextStyle(fontSize: 14, color: Colors.black),
                              value: qualificationLevel,
                              items: qualificationLevels.map((level) {
                                return DropdownMenuItem<String>(
                                  value: level,
                                  child: Text(
                                    level,
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.black),
                                  ),
                                );
                              }).toList(),
                              selectedItemBuilder: (BuildContext context) {
                                return editorialRoles.map((String value) {
                                  return Text(
                                    value,
                                    style: TextStyle(color: Colors.black),
                                  );
                                }).toList();
                              },
                              onChanged: (value) {
                                setState(() {
                                  qualificationLevel = value;
                                });
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please select a qualification level';
                                }
                                return null;
                              },
                            ),
                            DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                filled: true,
                                labelStyle: TextStyle(color: Colors.grey),
                                fillColor: Color.fromARGB(255, 245, 245, 245),
                                labelText: 'Designation...',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  borderSide: const BorderSide(
                                    color: Colors.transparent,
                                    // color: Color.fromARGB(255, 236, 196, 164),
                                    // width: 2,
                                  ),
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
                              dropdownColor: Color.fromARGB(255, 246, 246, 246),
                              borderRadius: BorderRadius.circular(25.0),
                              style:
                                  TextStyle(fontSize: 14, color: Colors.black),
                              value: designation,
                              items: designations.map((designation) {
                                return DropdownMenuItem(
                                  value: designation,
                                  child: Text(designation),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  designation = value;
                                });
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please select a designation';
                                }
                                return null;
                              },
                            ),
                            DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                filled: true,
                                labelStyle: TextStyle(color: Colors.grey),
                                fillColor: Color.fromARGB(255, 245, 245, 245),
                                labelText: 'Editorial Role...',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  borderSide: const BorderSide(
                                    color: Colors.transparent,
                                    // color: Color.fromARGB(255, 236, 196, 164),
                                    // width: 2,
                                  ),
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
                              dropdownColor: Color.fromARGB(255, 246, 246, 246),
                              borderRadius: BorderRadius.circular(25.0),
                              style:
                                  TextStyle(fontSize: 14, color: Colors.black),
                              value: editorialRole,
                              items: editorialRoles.map((role) {
                                return DropdownMenuItem(
                                  value: role,
                                  child: Text(role),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  editorialRole = value;
                                });
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please select a editorial role';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              controller: professionController,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Color.fromARGB(255, 245, 245, 245),
                                labelStyle: TextStyle(color: Colors.grey),
                                hintStyle: TextStyle(color: Colors.grey),
                                labelText: 'Profession...',
                                hintText: 'i,e. Zoologist',
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
                                  return 'Please enter your profession';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              controller: linkedInController,
                              keyboardType: TextInputType.url,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Color.fromARGB(255, 245, 245, 245),
                                labelStyle: TextStyle(color: Colors.grey),
                                hintStyle: TextStyle(color: Colors.grey),
                                labelText: 'LinkedIn Profile URL...',
                                hintText: 'https://linkedin.com/in/username',
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
                                  return 'Please enter your LinkedIn profile URL';
                                }
                                return null;
                              },
                            ),
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
                                if (_formKey.currentState!.validate()) {
                                  // TODO: Implement Sign Up logic.
                                  setLoading(true);
                                }
                              },
                            ),
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
