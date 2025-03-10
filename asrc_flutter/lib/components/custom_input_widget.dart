import 'package:flutter/material.dart';

class CustomInputWidget extends StatelessWidget {
  final String hintText;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final bool? obscureText;
  final int? maxLines;
  final String label;
  final double width;

  const CustomInputWidget({
    super.key,
    required this.hintText,
    required this.keyboardType,
    required this.controller,
    this.obscureText,
    this.maxLines,
    required this.label,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Padding(
        padding: const EdgeInsets.only(top: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                color: Color.fromARGB(255, 50, 53, 62),
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              constraints: BoxConstraints(
                minHeight: 56,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Color.fromARGB(255, 245, 245, 245),
              ),
              child: TextField(
                controller: controller,
                keyboardType: keyboardType,
                obscureText: obscureText ?? false,
                maxLines: maxLines ?? 1,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
                decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: TextStyle(
                    color: Color.fromARGB(255, 158, 157, 164),
                    fontSize: 18,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 2,
                      color: Color.fromARGB(255, 133, 81, 246),
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
