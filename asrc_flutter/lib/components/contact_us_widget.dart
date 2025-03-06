import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ContactUsWidget extends StatefulWidget {
  const ContactUsWidget({super.key});

  @override
  State<ContactUsWidget> createState() => _ContactUsWidgetState();
}

class _ContactUsWidgetState extends State<ContactUsWidget> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _questionController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _questionController.dispose();
    super.dispose();
  }

  void _sendForm() {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text;
      final question = _questionController.text;
      if (kDebugMode) {
        print('Email: $email');
        print('Question: $question');
      }
      _emailController.clear();
      _questionController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SizedBox(
        width: 500,
        height: 1000,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Questions?',
              style: TextStyle(fontSize: 64, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 32),
            const Text(
              'What can we help you\nwith today?',
              style: TextStyle(
                  fontSize: 40, color: Color.fromARGB(255, 72, 76, 81)),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                labelText: 'Your email...',
                labelStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: const BorderSide(color: Colors.transparent),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: const BorderSide(color: Colors.transparent),
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
            const SizedBox(height: 24),
            TextFormField(
              controller: _questionController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                labelStyle: TextStyle(color: Colors.grey),
                labelText: 'Type your question...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: const BorderSide(color: Colors.transparent),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: const BorderSide(color: Colors.transparent),
                ),
                hoverColor: Colors.transparent,
              ),
              maxLines: 3,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your question';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),
            //TODO: make UI better
            ElevatedButton(
              onPressed: _sendForm,
              child: const Text(
                'Send',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
