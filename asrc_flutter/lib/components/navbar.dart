import 'package:asrc_flutter/utils/constants.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';

class Navbar extends StatelessWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    const TextStyle navbarTextStyle = TextStyle(
      color: AppColor.navbarTextColor,
      // fontSize: 16,
    );
    return Container(
      margin: EdgeInsets.all(10),
      height: 50,
      decoration: BoxDecoration(
        color: AppColor.appBarColor,
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 0.1,
            spreadRadius: 0.1,
            offset: Offset(0, 1),
          ),
        ],
        // border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Expanded(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            spacing: 10,
            children: [
              Text(Constants.appName),
              Spacer(),
              Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 245, 245, 245),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Text('Home', style: navbarTextStyle),
                    Divider(
                      color: Colors.black,
                      thickness: 20,
                      height: 20,
                    ),
                  ],
                ),
              ),
              Text('Publications', style: navbarTextStyle),
              Text('Events', style: navbarTextStyle),
              Text('About', style: navbarTextStyle),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
