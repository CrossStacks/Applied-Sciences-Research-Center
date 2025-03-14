import 'dart:typed_data';
import 'package:flutter/material.dart';

class Contributor {
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  Uint8List? image;
  String? imageUrl;

  Contributor({
    required this.firstNameController,
    required this.lastNameController,
    this.image,
    this.imageUrl,
  });
}
