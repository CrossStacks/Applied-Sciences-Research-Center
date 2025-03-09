import 'package:asrc_flutter/components/footer.dart';
import 'package:asrc_flutter/pages/signin_page.dart';
import 'package:asrc_flutter/utils/colors.dart';
import 'package:asrc_flutter/utils/global.dart';
import 'package:flutter/material.dart';
import '../utils/constants.dart';
import 'about_page.dart';
import 'event_page.dart';
import 'home_page.dart';
import 'publication_page.dart';

class Index extends StatelessWidget {
  Index({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> timelineData = [
      {
        "date": "14 Feb, 2025",
        "title": "Founders Update #30",
        "tag": "UPDATES",
        "imageUrl":
            "https://images.unsplash.com/photo-1524995997946-a1c2e315a42f?auto=format&fit=crop&w=800&q=80",
        "description":
            "Michael here! Today we have a very special announcement! You WON'T want to miss this Join us for a live Q&A session with a surprise guest!Join us for a live Q&A session with a surprise guest!Join us for a live Q&A session with a surprise guest! Join us for a live Q&A session with a surprise guest! Join us for a live Q&A session with a surprise guest! Join us for a live Q&A session with a surprise guest! Join us for a live Q&A session with a surprise guest! Join us for a live Q&A session with a surprise guest!Join us for a live Q&A session with a surprise guest! Join us for a live Q&A session with a surprise guest!Join us for a live Q&A session with a surprise guest! Join us for a live Q&A session with a surprise guest!",
        "fullDate": "February 14, 2025",
        "readTime": "3 min read",
      },
      {
        "date": "21 Mar, 2025",
        "title": "Special Guest Event",
        "tag": "EVENT",
        "imageUrl":
            "https://images.unsplash.com/photo-1524995997946-a1c2e315a42f?auto=format&fit=crop&w=800&q=80",
        "description": "Join us for a live Q&A session with a surprise guest!",
        "fullDate": "March 21, 2025",
        "readTime": "5 min read",
      },
    ];
    final List<Widget> tabs = [
      HomePage(),
      PublicationPage(),
      EventPage(timelineData: timelineData),
      AboutPage(),
    ];
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          bottom: TabBar(
            tabs: [
              Tooltip(
                message: 'Home',
                child: Icon(Icons.home),
              ),
              Tooltip(
                message: 'Publications',
                child: Icon(Icons.newspaper_rounded),
              ),
              Tooltip(
                message: 'Events',
                child: Icon(Icons.event),
              ),
              Tooltip(
                message: 'About us',
                child: Icon(Icons.info_outline_rounded),
              ),
              Global.isLoggedIn
                  ? Tooltip(
                      message: 'Account',
                      child: IconButton(
                        onPressed: () => {
                          //TODO
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => AboutPage()))
                        },
                        icon: Icon(Icons.person),
                      ),
                    )
                  : Tooltip(
                      message: 'Sign In',
                      child: IconButton(
                        onPressed: () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignInPage()))
                        },
                        hoverColor: AppColor.primaryColor,
                        icon: Icon(Icons.person),
                      ),
                    )
            ],
          ),
        ),
        body: TabBarView(
          children: tabs,
        ),
        // extendBody: true,
        // persistentFooterAlignment: ,
        // persistentFooterButtons: [
        //   Footer(),
        // ],
      ),
    );
  }
}
