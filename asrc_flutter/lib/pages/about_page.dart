import 'package:asrc_flutter/components/custom_white_container.dart';
import 'package:flutter/material.dart';
import '../components/contact_us_widget.dart';
import '../components/custom_team_card.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 244, 241, 237),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 96,
              ),
              Text(
                'About Us',
                style: TextStyle(
                    fontSize: 16, color: Color.fromARGB(255, 236, 121, 72)),
              ),
              SizedBox(
                height: 52,
              ),
              CustomWhiteContainer(
                containerPadding: const EdgeInsets.only(
                    top: 160, left: 120, right: 120, bottom: 120),
                containerChild: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Meet Our In-House',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 72, color: Color.fromARGB(255, 72, 76, 81)),
                    ),
                    Text(
                      'Scientists & Expert Council',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 72),
                    ),
                    Text(
                      'We work with a lot of exceptional and thoughtful people—like the researchers,\nprofessors, and experts on our Zoology Faculty Research Team, who help\nguide paper development and academic inquiry.',
                      style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    CustomTeamCard(),
                    SizedBox(
                      height: 24,
                    ),
                    CustomTeamCard(),
                    SizedBox(
                      height: 24,
                    ),
                    CustomTeamCard(),
                    SizedBox(
                      height: 24,
                    ),
                    CustomTeamCard(),
                  ],
                ),
              ),
              ContactUsWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
