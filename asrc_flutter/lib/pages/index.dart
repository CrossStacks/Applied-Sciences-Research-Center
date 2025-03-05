import 'package:asrc_flutter/utils/colors.dart';
import 'package:asrc_flutter/utils/global.dart';
import 'package:flutter/material.dart';
import '../utils/constants.dart';
import 'about_page.dart';
import 'event_page.dart';
import 'home_page.dart';
import 'publication_page.dart';

class Index extends StatelessWidget {
  final List<Widget> _tabs = [
    HomePage(),
    PublicationPage(),
    EventPage(),
    AboutPage(),
  ];
  Index({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AboutPage()))
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
                                  builder: (context) => AboutPage()))
                        },
                        hoverColor: AppColor.primaryColor,
                        icon: Icon(Icons.person),
                      ),
                    )
            ],
          ),
        ),
        body: TabBarView(
          children: _tabs,
        ),
      ),
    );
  }
}
