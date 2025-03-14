import 'package:flutter/material.dart';
import '../utils/global.dart';
import 'manage_events_page.dart';
import 'manage_users_page.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  int _selectedIndex = 0;

  static final List<Map<String, dynamic>> adminPages = [
    {
      'title': 'Manage Events',
      'widget': const ManageEventsPage(),
    },
    {
      'title': 'Manage Users',
      'widget': const ManageUsersPage(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Panel'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/images/logo.png'),
                  ),
                  Text(
                    'Admin',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            // Create a drawer item for each page.
            ...adminPages.asMap().entries.map((entry) {
              final int index = entry.key;
              final Map page = entry.value;
              return ListTile(
                title: Text(page['title']),
                onTap: () {
                  setState(() {
                    _selectedIndex = index;
                  });
                  Navigator.pop(context); // Close the drawer.
                },
              );
            }).toList(),
          ],
        ),
      ),
      body: adminPages[_selectedIndex]['widget'],
    );
  }
}
