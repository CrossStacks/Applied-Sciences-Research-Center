import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../services/firebase/database.dart';
import '../utils/global.dart';

class SignInController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isLoading = false;

  Future<void> userLogin(BuildContext context, Function setLoading) async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    setLoading(true);

    try {
      final email = emailController.text.trim();
      final password = passwordController.text.trim();

      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final querySnapshot = await DatabaseMethods().getUserByEmail(email);
      if (querySnapshot.docs.isEmpty) {
        _showErrorSnackbar(context, 'User record not found in Firestore.');
        return;
      }

      final userData = querySnapshot.docs[0].data() as Map<String, dynamic>;
      final userDetails = await DatabaseMethods()
          .getUserByEmail(userData['Email'] as String)
          .then((value) => value.docs[0].data() as Map<String, dynamic>);

      Global.userDetails = UserDetail(
        firstName: userDetails['FirstName'],
        lastName: userDetails['LastName'],
        userId: userDetails['Id'],
        email: userDetails['Email'],
        profilePhotoUrl: userDetails['ProfilePhotoUrl'],
      );
    } on FirebaseAuthException catch (e) {
      _handleFirebaseAuthException(context, e);
    } catch (e, stackTrace) {
      debugPrint("Unexpected error: $e");
      debugPrintStack(stackTrace: stackTrace);
      _showErrorSnackbar(
          context, 'An unexpected error occurred. Please try again.');
    } finally {
      setLoading(false);
    }
  }

  void _handleFirebaseAuthException(
      BuildContext context, FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        _showErrorSnackbar(context, 'No user found for this email.');
        break;
      case 'wrong-password':
        _showErrorSnackbar(context, 'Incorrect password. Please try again.');
        break;
      case 'network-request-failed':
        _showErrorSnackbar(
            context, 'Network error. Check your internet connection.');
        break;
      default:
        _showErrorSnackbar(context, 'Authentication error: ${e.message}');
        break;
    }
  }

  void _showErrorSnackbar(BuildContext context, String message,
      {Color color = Colors.orangeAccent}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
      ),
    );
  }
}
