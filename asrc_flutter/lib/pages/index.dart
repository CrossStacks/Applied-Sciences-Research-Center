import 'package:asrc_flutter/pages/signin_page.dart';
import 'package:asrc_flutter/utils/colors.dart';
import 'package:asrc_flutter/utils/global.dart';
import 'package:asrc_flutter/utils/routing/routes_name.dart';
import 'package:flutter/material.dart';
import '../components/hover_underline_text.dart';
import '../utils/constants.dart';
import '../utils/routing/routes.dart';
import 'about_page.dart';
import 'event_page.dart';
import 'home_page.dart';
import 'publication_page.dart';

class Index extends StatefulWidget {
  const Index({super.key});

  @override
  State<Index> createState() => _IndexState();
}

class _IndexState extends State<Index> {
  // void _onPageSelected(int index) {
  //   setState(() {
  //     Global.pageIdx = index;
  //   });
  // }
  String? selectedItem;
  final List<String> items = ['Admin Panel', 'OJS'];

  @override
  Widget build(BuildContext context) {
    const pages = [
      RouteName.homePage,
      RouteName.publicationPage,
      RouteName.eventPage,
      RouteName.aboutPage,
    ];

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
      floatingActionButton: Container(
        height: 61,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
        ),
        margin: EdgeInsets.all(16),
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        child: Row(
          children: [
            Text(
              Constants.appName,
              style: TextStyle(fontSize: 16),
            ),
            Spacer(),
            HoverUnderlineText(
              onTap: () {
                setState(() {
                  Global.pageIdx = 0;
                });
              },
              text: 'Home',
              style: TextStyle(
                color: Color.fromARGB(255, 29, 31, 37),
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            SizedBox(
              width: 40,
            ),
            HoverUnderlineText(
              onTap: () {
                setState(() {
                  Global.pageIdx = 1;
                });
              },
              text: 'Publications',
              style: TextStyle(
                color: Color.fromARGB(255, 29, 31, 37),
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            SizedBox(
              width: 40,
            ),
            HoverUnderlineText(
              onTap: () {
                setState(() {
                  Global.pageIdx = 2;
                });
              },
              text: 'Events',
              style: TextStyle(
                color: Color.fromARGB(255, 29, 31, 37),
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            SizedBox(
              width: 40,
            ),
            HoverUnderlineText(
              onTap: () {
                setState(() {
                  Global.pageIdx = 3;
                });
              },
              text: 'About us',
              style: TextStyle(
                color: Color.fromARGB(255, 29, 31, 37),
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            Spacer(),
            Global.isLoggedIn
                ? InkWell(
                    onTap: () {},
                    child: Text('Account'),
                  )
                : Container(
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                        width: 0.5,
                        color: Color.fromARGB(255, 219, 219, 220),
                      ),
                    ),
                    child: Tooltip(
                      message: 'Sign In',
                      child: PopupMenuButton<String>(
                        icon: Icon(
                          Icons.person,
                          color: Color.fromARGB(255, 72, 76, 81),
                        ),
                        color: Color.fromARGB(255, 246, 246, 246),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        onSelected: (value) {
                          setState(() {
                            selectedItem = value;
                          });
                          if (value == 'Admin Panel') {
                            Navigator.pushNamed(context, RouteName.signinPage);
                          } else if (value == 'OJS') {
                            // Navigator.pushNamed(context, RouteName.ojsPage);
                          }
                        },
                        itemBuilder: (context) => items.map(
                          (item) {
                            return PopupMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                            );
                          },
                        ).toList(),
                      ),
                    ),
                  ),
          ],
        ),
      ),
      body: Routes.getPage(pages[Global.pageIdx]),
      // extendBody: true,
      // persistentFooterAlignment: ,
      // persistentFooterButtons: [
      //   Footer(),
      // ],
    );
  }
}
