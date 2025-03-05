import 'package:asrc_flutter/components/navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // double screenHeight = MediaQuery.of(context).size.height;
    // double screenWidth = MediaQuery.of(context).size.width;
    // bool isMobile = screenHeight > screenWidth;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Navbar(),

          // ? Slide show images
          AspectRatio(
            aspectRatio: 21 / 9,
            child: ImageSlideshow(
              indicatorColor: Colors.blue,
              autoPlayInterval: 3000,
              isLoop: true,
              children: [
                Image.asset(
                  'assets/logo1.jpg',
                  fit: BoxFit.cover,
                ),
                Image.asset(
                  'assets/logo2.jpg',
                  fit: BoxFit.cover,
                ),
                Image.asset(
                  'assets/logo3.jpg',
                  fit: BoxFit.cover,
                ),
              ],
            ),
          ),

          // ? Middle navigation bar
        ],
      ),
    );
  }
}
