import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../components/custom_button_widget.dart';
import '../components/custom_white_container.dart';
import '../components/timeline_item.dart';
import '../controllers/event_page_controller.dart';

class EventPage extends StatefulWidget {
  const EventPage({super.key});

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  final EventPageController controller = EventPageController();

  @override
  void initState() {
    super.initState();
    _loadEvents();
  }

  Future<void> _loadEvents() async {
    await controller.fetchEvents();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 243, 240, 236),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: CustomWhiteContainer(
          containerPadding: const EdgeInsets.only(
            top: 160,
            left: 120,
            right: 120,
            bottom: 120,
          ),
          containerChild: Column(
            children: [
              Text(
                'Updates',
                style: TextStyle(
                  fontSize: 48,
                  color: Color.fromARGB(255, 13, 15, 17),
                ),
              ),
              const Text(
                "New updates and improvements to Bia. We'll notify you right away via email when new versions are released.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: Color.fromARGB(255, 50, 53, 62),
                ),
              ),
              SizedBox(
                width: 400,
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Enter your email...',
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    filled: true,
                    fillColor: const Color.fromARGB(255, 245, 245, 245),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(color: Colors.transparent),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide:
                          const BorderSide(color: Color(0xFFFDE1D9), width: 4),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(color: Colors.transparent),
                    ),
                    suffixIcon: Container(
                      margin: const EdgeInsets.only(right: 6),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFF06A6A), Color(0xFFFC895F)],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: () {
                          // TODO: handle subscribe action
                        },
                        child: const Text(
                          'Subscribe',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    suffixIconConstraints:
                        const BoxConstraints(maxHeight: 50, maxWidth: 140),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: controller.events.isEmpty
                      ? [
                          if (controller.isLoading)
                            const CircularProgressIndicator()
                          else
                            const Text("No events found."),
                        ]
                      : controller.events.map((doc) {
                          final eventData = doc.data() as Map<String, dynamic>;

                          eventData['date'] = controller.formatTimestamp1(
                              eventData['EventDate'] as Timestamp);
                          eventData['FullDate'] = controller.formatTimestamp2(
                              eventData['EventDate'] as Timestamp);

                          return TimelineItem(event: eventData);
                        }).toList(),
                ),
              ),
              if (controller.hasMore)
                CustomButtonWidget(
                  width: 680,
                  initialColor: const Color.fromARGB(255, 245, 245, 245),
                  initialTextColor: Colors.black,
                  hoverColor: Colors.black,
                  hoverTextColor: Colors.white,
                  onTap: () async {
                    await _loadEvents();
                  },
                  text: 'Load More',
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
