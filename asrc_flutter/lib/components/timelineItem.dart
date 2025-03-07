import 'package:flutter/material.dart';
import 'package:dotted_line/dotted_line.dart';
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
                  event['date'] ?? '',
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
                    child: Image.network(
                      event['imageUrl'] ?? '',
                      width: 680,
                      height: 453.89,
                      fit: BoxFit.cover,
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
                        event['tag']?.toUpperCase() ?? '',
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
                    event['title'] ?? '',
                    style: const TextStyle(
                      color: Color.fromARGB(255, 13, 15, 17),
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    event['description'] ?? '',
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
                        event['fullDate'] ?? '',
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
                        event['readTime'] ?? '',
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
                    onTap: () {},
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
