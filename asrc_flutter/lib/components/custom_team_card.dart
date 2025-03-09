import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/dimensions.dart';

class CustomTeamCard extends StatelessWidget {
  const CustomTeamCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1240,
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 244, 241, 237),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 50),
        child: Stack(
          children: [
            Positioned(
              right: 0,
              top: 0,
              child: InkWell(
                customBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                onTap: () {
                  // !TODO: Define your LinkedIn button's action here
                },
                child: Container(
                  height: 50,
                  width: 50,
                  padding: EdgeInsets.all(13),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 0.5,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SvgPicture.asset(
                    'assets/linkedin.svg',
                  ),
                ),
              ),
            ),
            if (Dimensions.isMobile(context))
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _ImagePart(),
                  const SizedBox(height: 16),
                  _TextPart(),
                ],
              ),
            if (Dimensions.isTablet(context) || Dimensions.isDesktop(context))
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _ImagePart(),
                  const SizedBox(width: 16),
                  Expanded(child: _TextPart()),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class _ImagePart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Stack(
          children: [
            ShaderMask(
              shaderCallback: (Rect bounds) {
                return LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.white, Colors.transparent],
                  stops: [0.1, 1.0],
                ).createShader(bounds);
              },
              blendMode: BlendMode.dstIn,
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  Colors.grey,
                  BlendMode.saturation,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    width: Dimensions.isDesktop(context) ? 328 : 240,
                    'assets/najiyaalarifazoo.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Text(
              'Managing Editor',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: Dimensions.isDesktop(context) ? 20 : 16,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _TextPart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Dr. Najiya al-Arifa, PhD',
          style: TextStyle(
            fontSize: Dimensions.isDesktop(context) ? 32 : 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'Assistant Professor / Zoologist',
          style: TextStyle(
            fontSize: Dimensions.isDesktop(context) ? 20 : 16,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          "Dr. Najiya al-Arifa is an accomplished academic and researcher, serving as an Assistant Professor in the Department of Zoology at Lahore College for Women University (LCWU), Lahore, Pakistan. With a strong foundation in zoology, Dr. Najiya al-Arifa completed their Ph.D. in Zoology in 2018 from Government College University (GCU), Lahore, after earning their M.Phil. and M.Sc. in the same field.",
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 10),
        const Text(
          "Their research interests lie in immunology, toxicology, and microbiology, focusing on the impact of environmental factors like toxins, allergens, and microbes on the immune system, particularly in relation to asthma and allergies.",
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 10),
        const Text(
          "Dr. Najiya al-Arifa has published numerous research articles in national and international journals, and has presented their work at various conferences and symposiums. They are also a member of the editorial board of several scientific journals, and have served as a reviewer for various publications.",
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
