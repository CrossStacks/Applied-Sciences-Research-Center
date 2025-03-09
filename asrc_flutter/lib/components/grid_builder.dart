import 'package:flutter/material.dart';
import '../models/reading_page_model.dart';
import '../pages/reading_page.dart';
import '../utils/colors.dart';
import '../utils/dimensions.dart';

class GridB extends StatefulWidget {
  const GridB({super.key});

  @override
  State<GridB> createState() => _GridBState();
}

class _GridBState extends State<GridB> {
  final List<Map<String, dynamic>> gridMap = [
    {
      "title": "Innovations in Biotechnology",
      "description":
          "An in-depth review of modern biotechnological advancements and their future prospects. An in-depth review of modern biotechnological advancements and their future prospects.",
      "images":
          "https://images.unsplash.com/photo-1581091870621-cb8e6c3735e7?auto=format&fit=crop&w=800&q=80",
      "date": "June 14, 2024",
      "read": "12 min read",
      "publicationType": "Journal Article",
    },
    {
      "title": "Modern Art in the 21st Century",
      "description":
          "Exploring the evolution of art and its impact on society through detailed case studies. An in-depth review of modern biotechnological advancements and their future prospects.",
      "images":
          "https://images.unsplash.com/photo-1524995997946-a1c2e315a42f?auto=format&fit=crop&w=800&q=80",
      "date": "March 12, 2025",
      "read": "8 min read",
      "publicationType": "Research Paper",
    },
    {
      "title": "The Future of Renewable Energy",
      "description":
          "A comprehensive analysis of renewable energy trends, challenges, and innovative solutions.",
      "images":
          "https://images.unsplash.com/photo-1509395062183-67c5ad6faff9?auto=format&fit=crop&w=800&q=80",
      "date": "April 14, 2024",
      "read": "10 min read",
      "publicationType": "Conference Paper",
    },
    {
      "title": "Cultural Impacts of Globalization",
      "description":
          "Investigating how globalization influences cultural identities and the arts in a digital era.",
      "images":
          "https://images.unsplash.com/photo-1515165562835-cf00b7e04a53?auto=format&fit=crop&w=800&q=80",
      "date": "May 20, 2024",
      "read": "7 min read",
      "publicationType": "Article",
    },
    {
      "title": "Advances in Artificial Intelligence",
      "description":
          "Discussing breakthroughs in AI, machine learning, and their applications across industries.",
      "images":
          "https://images.unsplash.com/photo-1518770660439-4636190af475?auto=format&fit=crop&w=800&q=80",
      "date": "June 14, 2024",
      "read": "9 min read",
      "publicationType": "Research Paper",
    },
    {
      "title": "The Rise of E-Commerce",
      "description":
          "Examining the impact of e-commerce on traditional retail and the shifting dynamics of global trade.",
      "images":
          "https://images.unsplash.com/photo-1556742400-b5c7c57b66c3?auto=format&fit=crop&w=800&q=80",
      "date": "August 05, 2024",
      "read": "6 min read",
      "publicationType": "Book Review",
    },
    {
      "title": "Digital Marketing Strategies",
      "description":
          "An overview of modern digital marketing techniques and the evolution of online consumer behavior.",
      "images":
          "https://images.unsplash.com/photo-1556740738-b6a63e27c4df?auto=format&fit=crop&w=800&q=80",
      "date": "July 10, 2024",
      "read": "5 min read",
      "publicationType": "Article",
    },
  ];
  void onCellTap(int index) {
    final item = gridMap[index];
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(item["title"]),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Date: ${item['date']}"),
              Text("Read Time: ${item['read']}"),
              Text("Publication Type: ${item['publicationType']}"),
              SizedBox(height: 10),
              Text(item['description']),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("close"),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ReadingPage(
                      previousPageTitle: "Publications",
                      title: "Music and Sleep – Does Music Help You Sleep?",
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
              child: const Text("read more"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    int crossAxisCount;
    double mainAxisSpacing;
    double crossAxisSpacing;
    double childAspectRatio;
    EdgeInsets gridPadding;

    if (Dimensions.isDesktop(context)) {
      crossAxisCount = 3;
      mainAxisSpacing = 80.0;
      crossAxisSpacing = 40.0;
      childAspectRatio = 0.91;
      gridPadding = const EdgeInsets.fromLTRB(16.0, 40.0, 16.0, 16.0);
    } else if (Dimensions.isTablet(context)) {
      crossAxisCount = 2;
      mainAxisSpacing = 64.0;
      crossAxisSpacing = 16.0;
      childAspectRatio = 0.88;
      gridPadding = const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 16.0);
    } else {
      crossAxisCount = 1;
      mainAxisSpacing = 40.0;
      crossAxisSpacing = 16.0;
      childAspectRatio = 0.65;
      gridPadding = const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 16.0);
    }

    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 1496),
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: gridPadding,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            mainAxisSpacing: mainAxisSpacing,
            crossAxisSpacing: crossAxisSpacing,
            childAspectRatio: childAspectRatio,
          ),
          itemCount: gridMap.length,
          itemBuilder: (_, index) {
            final item = gridMap[index];
            return GestureDetector(
              onTap: () => onCellTap(index),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(25.0)),
                    child: AspectRatio(
                      aspectRatio: 1.49813,
                      child: Image.network(
                        item['images'],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['publicationType'],
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: selectColor(item['publicationType']),
                          ),
                        ),
                        Text(
                          item['title'],
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 22, 24, 29),
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          item['description'],
                          maxLines: 2,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: Color.fromARGB(255, 72, 76, 81),
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Row(
                          children: [
                            Text(
                              item['date'],
                              style: const TextStyle(
                                color: Color.fromARGB(255, 72, 76, 81),
                                fontSize: 14,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: Icon(
                                Icons.circle,
                                size: 5,
                                color: Color.fromARGB(255, 72, 76, 81),
                              ),
                            ),
                            Text(
                              item['read'],
                              style: const TextStyle(
                                color: Color.fromARGB(255, 72, 76, 81),
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Color selectColor(String publicationType) {
    switch (publicationType) {
      case "Journal Article":
        return AppColor.orange;
      case "Research Paper":
        return AppColor.red;
      case "Conference Paper":
        return Colors.green;
      case "Article":
        return AppColor.purple;
      case "Book Review":
        return AppColor.blue;
      default:
        return Colors.black;
    }
  }
}
