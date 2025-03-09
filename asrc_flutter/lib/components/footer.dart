import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Container(
            height: 124,
            width: double.infinity,
            color: Color.fromARGB(255, 50, 53, 62),
          ),
          Expanded(
            child: Container(
              color: Color.fromARGB(255, 13, 15, 17),
            ),
          ),
        ],
      ),
    );
  }
}
