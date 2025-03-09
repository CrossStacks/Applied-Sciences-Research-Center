import 'package:flutter/material.dart';

class HoverText extends StatefulWidget {
  const HoverText({super.key});

  @override
  State<HoverText> createState() => _HoverTextState();
}

class _HoverTextState extends State<HoverText> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _isHovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          _isHovered = false;
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Hover over me!',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            height: 2,
            width: _isHovered ? 100 : 0,
            color: Colors.black,
            margin: EdgeInsets.only(top: 8),
          ),
        ],
      ),
    );
  }
}
