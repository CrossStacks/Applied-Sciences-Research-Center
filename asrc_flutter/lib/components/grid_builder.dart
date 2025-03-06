import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    final int crossAxisCount = Dimensions.isMobile(context)
        ? 1
        : Dimensions.isTablet(context)
            ? 2
            : 3;
    final double imageHeight = Dimensions.isMobile(context)
        ? 200
        : Dimensions.isTablet(context)
            ? 250
            : 314;
    final double childAspectRatio = Dimensions.isMobile(context)
        ? 0.8
        : Dimensions.isTablet(context)
            ? 1.0
            : 1.2;

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.all(16.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        childAspectRatio: childAspectRatio,
      ),
      itemCount: gridMap.length,
      itemBuilder: (_, index) {
        final item = gridMap[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(25.0)),
              child: Image.network(
                item['images'],
                height: imageHeight,
                width: double.infinity,
                fit: BoxFit.cover,
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
                          size: 6,
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
                  const SizedBox(height: 8.0),
                  // New field: Publication Type.
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  selectColor(item) {
    switch (item) {
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
