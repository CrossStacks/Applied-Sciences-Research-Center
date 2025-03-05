import 'package:flutter/material.dart';

class Navbar extends StatelessWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        spacing: 10,
        children: const [
          Text('Home'),
          Text('Publications'),
          Text('Events'),
          Text('About'),
        ],
      ),
    );
  }
}
