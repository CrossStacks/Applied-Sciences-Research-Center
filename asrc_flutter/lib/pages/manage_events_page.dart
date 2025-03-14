import 'package:asrc_flutter/components/custom_button_widget.dart';
import 'package:asrc_flutter/utils/colors.dart';
import 'package:flutter/material.dart';

import '../utils/routing/routes_name.dart';

class ManageEventsPage extends StatefulWidget {
  const ManageEventsPage({super.key});

  @override
  State<ManageEventsPage> createState() => _ManageEventsPageState();
}

class _ManageEventsPageState extends State<ManageEventsPage> {
  // Dummy function to simulate fetching events (replace with your Firestore query)
  Future<List<Map<String, dynamic>>> fetchEvents() async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      {'id': '1', 'title': 'Annual Conference', 'date': '2023-09-15'},
      {'id': '2', 'title': 'Workshop on AI', 'date': '2023-10-01'},
      {'id': '3', 'title': 'Networking Meetup', 'date': '2023-11-05'},
    ];
  }

  // Dummy delete function (replace with your deletion logic)
  void deleteEvent(String id) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Deleted event $id')),
    );
    // Optionally, refresh the events list.
    setState(() {});
  }

  // Dummy edit function (navigate to edit event page)
  void editEvent(Map<String, dynamic> event) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Editing event: ${event['title']}')),
    );
    // Implement navigation to an edit event page as needed.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Events'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            AppColor.lightGrey,
            Color.fromARGB(255, 244, 241, 237),
            Colors.white,
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: fetchEvents(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            final events = snapshot.data ?? [];
            if (events.isEmpty) {
              return const Center(child: Text('No events found.'));
            }
            return ListView.builder(
              itemCount: events.length,
              itemBuilder: (context, index) {
                final event = events[index];
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(event['title'] ?? 'Untitled Event'),
                    subtitle: Text('Date: ${event['date']}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () => editEvent(event),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => deleteEvent(event['id']),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: CustomButtonWidget(
        text: 'Add event',
        textStyle: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
        initialTextColor: Colors.white,
        hoverTextColor: Color.fromARGB(255, 13, 15, 17),
        onTap: () => Navigator.pushNamed(context, RouteName.addOrModifyEvent),
        initialBorderColor: Color.fromARGB(255, 13, 15, 17),
        initialColor: Color.fromARGB(255, 13, 15, 17),
        hoverBorderColor: Color.fromARGB(255, 13, 15, 17),
        hoverColor: Colors.white,
      ),
    );
  }
}
