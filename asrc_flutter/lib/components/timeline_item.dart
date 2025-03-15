import 'package:flutter/material.dart';
import 'package:dotted_line/dotted_line.dart';
import '../models/reading_page_model.dart';
import '../pages/reading_page.dart';
import 'custom_button_widget.dart';

class TimelineItem extends StatelessWidget {
  final Map<String, dynamic> event;

  const TimelineItem({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.play_arrow, size: 14),
                const SizedBox(width: 4),
                Text(
                  event['Date'] ?? '',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Color.fromARGB(255, 49, 52, 61),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const DottedLine(
              direction: Axis.vertical,
              dashLength: 4,
              dashGapLength: 4,
              lineThickness: 1.2,
              dashColor: Colors.grey,
              lineLength: 640,
            ),
          ],
        ),
        const SizedBox(width: 24),
        Expanded(
          child: Center(
            child: SizedBox(
              width: 680,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: AspectRatio(
                      aspectRatio: 1.8181818181818181,
                      child: Image.network(
                        event['CoverImageUrl'] ?? '',
                        width: 680,
                        height: 453.89,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(
                        Icons.label,
                        size: 14,
                        color: Color.fromARGB(255, 252, 137, 95),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        event['EventType']?.toUpperCase() ?? '',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 252, 137, 95),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    event['Title'] ?? '',
                    style: const TextStyle(
                      color: Color.fromARGB(255, 13, 15, 17),
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    event['MetaDescription'] ?? '',
                    style: const TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 50, 53, 62),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        event['FullDate'] ?? '',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color.fromARGB(255, 50, 53, 62),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Icon(
                          Icons.circle,
                          size: 5,
                          color: Color.fromARGB(255, 50, 53, 62),
                        ),
                      ),
                      Text(
                        event['ReadingTime'] ?? '',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color.fromARGB(255, 50, 53, 62),
                        ),
                      ),
                    ],
                  ),
                  CustomButtonWidget(
                    initialColor: const Color.fromARGB(255, 237, 144, 104),
                    initialTextColor: Color.fromARGB(255, 31, 11, 4),
                    hoverColor: Colors.black,
                    hoverTextColor: Colors.white,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ReadingPage(
                            url: Uri.parse('https://flutter.dev'),
                            previousPageTitle: "Events",
                            title:
                                "Music and Sleep – Does Music Help You Sleep?",
                            description:
                                "Music uniquely syncs with your brain, slowing your heart rate and reducing cortisol - the stress hormone.",
                            content: [
                              ReadingContent(
                                  type: "paragraph",
                                  content:
                                      'The connection between music and sleep is real—and backed by science. Listening to calming music before bed can help lower stress, relax your body, and create the perfect environment for sleep. Music uniquely syncs with your brain, slowing your heart rate and reducing cortisol (the stress hormone). Certain types of music, especially classical or soothing instrumental pieces, are often recommended to help you unwind. But not all music works the same for everyone. So now you’re wondering, “Does classical music improve sleep quality?” “Is it safe to sleep with music on?” and “Does music really help with insomnia?” Well, stick around as we tackle all that and much more!'),
                              ReadingContent(
                                  type: "image",
                                  content: "",
                                  imageUrl:
                                      "https://images.unsplash.com/photo-1518770660439-4636190af475?auto=format&fit=crop&w=800&q=80"),
                              ReadingContent(
                                  type: "heading",
                                  content: "How Music Helps You Sleep"),
                              ReadingContent(
                                  type: "paragraph",
                                  content:
                                      "These quick adjustments will be completed before January 5th and will greatly improve the experience of the mask as we gear up for Beta production."),
                              ReadingContent(
                                  type: "paragraph",
                                  content:
                                      "We’re thrilled with how far we’ve come and can’t wait to bring you the ultimate sleep experience."),
                            ],
                          ),
                        ),
                      );
                    },
                    text: 'Read More',
                    textStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
