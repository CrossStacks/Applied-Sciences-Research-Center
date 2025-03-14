import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../components/hover_underline_text.dart';
import '../utils/constants.dart';
import '../utils/global.dart';
import '../utils/routing/routes.dart';
import '../utils/routing/routes_name.dart';

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
  final List<String> items = [
    'Admin Panel',
    'OJS',
  ];

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
            Container(
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
                  menuPadding: EdgeInsets.all(0),
                  color: Color.fromARGB(255, 246, 246, 246),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  onSelected: (value) {
                    setState(() {
                      selectedItem = value;
                    });
                    if (value == 'Admin Panel') {
                      Global.isLoggedIn
                          ? Navigator.pushNamed(context, RouteName.adminPage)
                          : Navigator.pushNamed(context, RouteName.signinPage);
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
                  child: Global.isLoggedIn
                      ? CircleAvatar(
                          backgroundImage:
                              NetworkImage(Global.userDetails!.profilePhotoUrl),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: SvgPicture.asset(
                            'assets/person_icon.svg',
                          ),
                        ),
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
