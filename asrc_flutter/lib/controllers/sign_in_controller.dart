import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../services/auth/validators.dart';
import '../services/firebase/auth_methods.dart';
import '../services/firebase/database.dart';
import '../utils/global.dart';
import '../utils/routing/routes_name.dart';

class SignInController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  Future<void> userLogin(
      BuildContext context, Function(bool) setLoading) async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    setLoading(true);
    try {
      final email = emailController.text.trim();
      final password = passwordController.text.trim();

      if (email.isEmpty || password.isEmpty) {
        _showErrorSnackbar(context, 'Email and Password cannot be empty.');
        setLoading(false);
        return;
      }

      if (!Validators.isValidEmail(email)) {
        _showErrorSnackbar(context, 'Please enter a valid email address.');
        setLoading(false);
        return;
      }

      if (!Validators.isValidPassword(password)) {
        _showErrorSnackbar(context,
            'Password must be at least 6 characters long, include at least one uppercase letter, one lowercase letter, and one digit.');
        setLoading(false);
        return;
      }

      await _authService.signIn(email: email, password: password);

      final querySnapshot = await DatabaseMethods().getUserByEmail(email);
      if (querySnapshot.docs.isEmpty) {
        _showErrorSnackbar(context, 'User not found. Please register first.');
        setLoading(false);
        return;
      }

      final userData = querySnapshot.docs[0].data() as Map<String, dynamic>;
      if (!userData.containsKey('Email')) {
        _showErrorSnackbar(context, 'Invalid user data.');
        setLoading(false);
        return;
      }

      final userDetails = await DatabaseMethods()
          .getUserByEmail(userData['Email'])
          .then((value) => value.docs[0].data() as Map<String, dynamic>);

      Global.userDetails = UserDetail(
        firstName: userDetails['FirstName'],
        lastName: userDetails['LastName'],
        email: userDetails['Email'],
        userId: userDetails['UserId'],
        profilePhotoUrl: userDetails['ProfilePhotoUrl'],
        isVerified: userDetails['IsVerified'],
        isAdmin: userDetails['IsAdmin'],
        designation: userDetails['Designation'],
        editorialRole: userDetails['EditorialRole'],
        linkedIn: userDetails['LinkedIn'],
        profession: userDetails['Profession'],
        about: userDetails['About'],
        qualificationLevel: userDetails['QualificationLevel'],
      );

      Navigator.pushReplacementNamed(context, RouteName.index);
    } on FirebaseAuthException catch (e) {
      _handleFirebaseAuthException(e, context);
    } catch (e) {
      _showErrorSnackbar(context, 'Login failed: ${e.toString()}');
    } finally {
      setLoading(false);
    }
  }

  void _handleFirebaseAuthException(
      FirebaseAuthException e, BuildContext context) {
    String message;
    switch (e.code) {
      case 'user-not-found':
        message = 'No user found for that email.';
        break;
      case 'wrong-password':
        message = 'Incorrect password. Please try again.';
        break;
      case 'invalid-email':
        message = 'Invalid email format.';
        break;
      case 'user-disabled':
        message = 'This user account has been disabled.';
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
