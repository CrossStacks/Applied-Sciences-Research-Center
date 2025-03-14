import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../services/app/image_picker.dart';
import '../services/auth/validators.dart';
import '../services/firebase_firestore/auth_methods.dart';
import '../services/firebase_firestore/database.dart';
import '../utils/global.dart';
import '../utils/routing/routes_name.dart';
import 'package:image_picker/image_picker.dart';

class SignUpController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController linkedInController = TextEditingController();
  final TextEditingController professionController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController aboutController = TextEditingController();

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

  Uint8List? profileImage;

  final AuthService _authService = AuthService();

  Future<void> pickProfileImage() async {
    Uint8List? img = await PickImage().pickImage(ImageSource.gallery);
    profileImage = img;
  }

  Future<void> userSignUp(
      BuildContext context, Function(bool) setLoading) async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    final email = emailController.text.trim();
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;
    final firstName = firstNameController.text.trim();
    final lastName = lastNameController.text.trim();

    if (firstName.isEmpty ||
        lastName.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      _showErrorSnackbar(context, 'Please fill in all the required fields.');
      return;
    }

    if (!Validators.isValidEmail(email)) {
      _showErrorSnackbar(context, 'Please enter a valid email address.');
      return;
    }

    if (!Validators.isValidPassword(password)) {
      _showErrorSnackbar(context,
          'Password must be at least 6 characters long, include at least one uppercase letter, one lowercase letter, and one digit.');
      return;
    }

    if (password != confirmPassword) {
      _showErrorSnackbar(context, 'Passwords do not match.');
      return;
    }
    if (!Validators.isValidLinkedIn(linkedInController.text.trim())) {
      _showErrorSnackbar(context, 'Please enter a valid LinkedIn profile URL.');
      return;
    }

    if (qualificationLevel == null ||
        designation == null ||
        editorialRole == null) {
      _showErrorSnackbar(context,
          'Please select qualification level, designation, and editorial role.');
      return;
    }

    setLoading(true);
    try {
      final userCredential = await _authService.signUp(
        email: email,
        password: password,
      );

      final String uid = userCredential.user!.uid;

      final Map<String, dynamic> userInfoMap = {
        "FirstName": firstName,
        "LastName": lastName,
        "Email": email,
        "LinkedIn": linkedInController.text.trim(),
        "Profession": professionController.text.trim(),
        "About": aboutController.text.trim(),
        "QualificationLevel": qualificationLevel,
        "Designation": designation,
        "EditorialRole": editorialRole,
        "ProfilePhotoUrl": '',
        "IsVerified": false,
        "IsAdmin": false,
        "UserId": uid,
      };

      await FirestoreDatabaseMethods().addUserDetails(userInfoMap, uid);

      Global.userDetails = UserDetail(
        firstName: firstName,
        lastName: lastName,
        email: email,
        userId: uid,
        profilePhotoUrl: '',
        isVerified: false,
        isAdmin: false,
        designation: designation!,
        editorialRole: editorialRole!,
        linkedIn: linkedInController.text.trim(),
        profession: professionController.text.trim(),
        about: aboutController.text.trim(),
        qualificationLevel: qualificationLevel!,
      );
      Global.isLoggedIn = true;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sign up successful!')),
      );

      Navigator.pushReplacementNamed(context, RouteName.adminPage);
    } on FirebaseAuthException catch (e) {
      _handleFirebaseAuthException(e, context);
    } catch (e) {
      _showErrorSnackbar(context, 'Sign up failed: ${e.toString()}');
    } finally {
      setLoading(false);
    }
  }

  void _handleFirebaseAuthException(
      FirebaseAuthException e, BuildContext context) {
    String message;
    switch (e.code) {
      case 'email-already-in-use':
        message = 'This email is already in use.';
        break;
      case 'invalid-email':
        message = 'Invalid email format.';
        break;
      case 'operation-not-allowed':
        message = 'Operation not allowed. Please try again later.';
        break;
      case 'weak-password':
        message = 'Password is too weak.';
        break;
      default:
        message = 'An error occurred. Please try again later.';
    }
    _showErrorSnackbar(context, message);
  }

  void _showErrorSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
