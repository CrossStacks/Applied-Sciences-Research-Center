import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
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
            // ? slected journals
            // ?selected books
          ],
        ),
      ),
    );
  }
}
