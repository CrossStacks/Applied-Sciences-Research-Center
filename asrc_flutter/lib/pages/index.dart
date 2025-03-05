import 'package:flutter/material.dart';
import '../utils/constants.dart';
import 'home_page.dart';

class Index extends StatelessWidget {
  final List<Widget> _tabs = [
    HomePage(),
  ];
  Index({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text(Constants.appName),
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.home), text: 'Home'),
              Tab(icon: Icon(Icons.newspaper_rounded), text: 'Publications'),
              Tab(icon: Icon(Icons.event), text: 'Events'),
              Tab(icon: Icon(Icons.info_outline_rounded), text: 'About'),
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
