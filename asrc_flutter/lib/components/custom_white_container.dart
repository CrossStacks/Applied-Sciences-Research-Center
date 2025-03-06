// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomWhiteContainer extends StatelessWidget {
  final EdgeInsetsGeometry containerPadding;
  final EdgeInsetsGeometry containerMargin;
  final Widget containerChild;
  const CustomWhiteContainer({
    super.key,
    required this.containerChild,
    required this.containerPadding,
    this.containerMargin = const EdgeInsets.all(0),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: containerMargin,
      width: double.infinity,
      padding: containerPadding,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
      ),
      child: containerChild,
    );
  }
}
