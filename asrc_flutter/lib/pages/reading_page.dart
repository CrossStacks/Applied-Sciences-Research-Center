import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../components/icon_button.dart';
import '../components/newsletter_widget.dart';
import '../models/reading_page_model.dart';
import '../utils/global.dart';
import '../utils/routing/routes_name.dart';
import '../utils/url_launcher.dart';

class ReadingPage extends StatefulWidget {
  final Uri url;
  final String previousPageTitle;
  final String title;
  final String description;
  final List<ReadingContent> content;
  const ReadingPage({
    super.key,
    required this.title,
    required this.content,
    required this.description,
    required this.previousPageTitle,
    required this.url,
  });

  @override
  State<ReadingPage> createState() => _ReadingPageState();
}

class _ReadingPageState extends State<ReadingPage> {
  String getFirstThreeWordsWithEllipsis(String input) {
    List<String> words = input.split(RegExp(r'\s+'));
    String result = words.take(3).join(' ');

    if (words.length > 3) {
      result += ' ...';
    }

    return result;
  }

  List<String> getWords(String text) {
    List<String> parts = text.split('–');
    return parts;
  }

  final ScrollController _scrollController = ScrollController();
  double fabPosition = 500;
  final double stopPosition = 40;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      setState(() {
        double newFabPosition = 500 - (_scrollController.position.pixels - 500);

        double newsletterPosition = 1000;

        if (_scrollController.position.pixels < 500) {
          fabPosition = 500;
        } else if (_scrollController.position.pixels >= newsletterPosition) {
          fabPosition = newsletterPosition - 50;
        } else {
          fabPosition = newFabPosition;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 252, 246, 243),
      body: SingleChildScrollView(
        controller: _scrollController,
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 16),
              child: Row(
                children: [
                  _buildBreadcrumbItem(
                      'Home',
                      (() => {
                            Global.pageIdx = 0,
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              RouteName.index,
                              (Route<dynamic> route) => false,
                            ),
                          })),
                  _buildBreadcrumbSeparator(),
                  _buildBreadcrumbItem(widget.previousPageTitle,
                      (() => {Navigator.pop(context)})),
                  _buildBreadcrumbSeparator(),
                  Text(
                    getFirstThreeWordsWithEllipsis(widget.title),
                    style: TextStyle(
                      fontSize: 14,
                      color: Color.fromARGB(255, 158, 157, 164),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Text(
                      widget.previousPageTitle,
                      style: TextStyle(
                        color: Color.fromARGB(255, 240, 106, 106),
                      ),
                    ),
                  ),
                  if (widget.title.contains('–'))
                    ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 1000),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: getWords(widget.title)[0],
                              style: TextStyle(
                                fontSize: 72,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            TextSpan(
                              text: '–',
                              style: TextStyle(
                                fontSize: 72,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 72, 76, 81),
                              ),
                            ),
                            TextSpan(
                              text: getWords(widget.title)[1],
                              style: TextStyle(
                                fontSize: 72,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 72, 76, 81),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  if (!widget.title.contains('–'))
                    ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 1000),
                      child: Text(
                        widget.title,
                        style: TextStyle(
                          fontSize: 72,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 750),
                      child: Text(
                        widget.description,
                        style: TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 13, 15, 17),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    spacing: 10,
                    children: [
                      ClipOval(
                        child: Image.asset(
                          'assets/najiyaalarifazoo.jpg',
                          width: 40,
                          height: 40,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Text(
                        'Name',
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      Icon(
                        Icons.circle,
                        size: 8,
                        color: Color.fromARGB(255, 72, 76, 81),
                      ),
                      Text(
                        'February 17, 2025',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 72, 76, 81),
                        ),
                      ),
                      Icon(
                        Icons.circle,
                        size: 8,
                        color: Color.fromARGB(255, 72, 76, 81),
                      ),
                      Text(
                        '8 min read',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 72, 76, 81),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 984,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 80.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(48),
                        child: AspectRatio(
                          aspectRatio: 984 / 541,
                          child: Image.network(
                            // scale: 3 / 2,
                            width: double.infinity,
                            // height: 3587,
                            'https://images.unsplash.com/photo-1524995997946-a1c2e315a42f?auto=format&fit=crop&w=800&q=80',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Stack(
              children: [
                SizedBox(
                  width: 728,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: widget.content.map((item) {
                      if (item.type == "heading") {
                        return Padding(
                          padding: const EdgeInsets.only(top: 96, bottom: 48),
                          child: Text(
                            item.content,
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 13, 15, 17),
                            ),
                          ),
                        );
                      } else if (item.type == "paragraph") {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 25),
                          child: Text(
                            item.content,
                            style: const TextStyle(
                              fontSize: 20,
                              color: Color.fromARGB(255, 50, 53, 62),
                            ),
                          ),
                        );
                      } else if (item.type == "image" &&
                          item.imageUrl != null) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 40),
                          child: AspectRatio(
                            aspectRatio: 364 / 185,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.network(
                                item.imageUrl!,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      }
                      return const SizedBox();
                    }).toList(),
                  ),
                ),
                Positioned(
                  left: -20,
                  top: fabPosition,
                  child: Column(
                    spacing: 4,
                    children: [
                      IconButtonWidget(
                          icon: Icons.facebook,
                          onTap: () {
                            launchUrlSafe(
                              Uri.parse(
                                'https://www.facebook.com',
                              ),
                            );
                          }),
                      IconButtonWidget(
                        onTap: () {
                          launchUrlSafe(
                            Uri.parse(
                              'https://www.linkedin.com',
                            ),
                          );
                        },
                        usingPicture: true,
                        picturePath: 'assets/linkedin.svg',
                      ),
                      IconButtonWidget(
                        usingPicture: true,
                        picturePath: 'assets/twitter-x.svg',
                        onTap: () {
                          launchUrlSafe(
                            Uri.parse(
                              'x.com',
                            ),
                          );
                        },
                      ),
                      IconButtonWidget(
                        icon: Icons.link,
                        onTap: () {
                          Clipboard.setData(ClipboardData(
                              text: 'Link of article')); //TODO: Add link

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text('Link copied to clipboard!')),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (widget.previousPageTitle == "Publications")
              SizedBox(
                width: 728,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 25.0),
                  child: Row(
                    children: [
                      const Text(
                        'DOI: ',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 50, 53, 62),
                        ),
                      ),
                      InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        onTap: () {
                          launchUrlSafe(widget.url);
                        },
                        child: Text(
                          widget.url.toString(),
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: 20,
                            color: Color.fromARGB(255, 17, 24, 39),
                          ),
                        ),
                      ),
                      Spacer(),
                      InkWell(
                        customBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        onTap: () {
                          // !TODO: Open PDF
                        },
                        child: Container(
                          height: 50,
                          width: 50,
                          padding: EdgeInsets.all(13),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 0.5,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            Icons.picture_as_pdf_outlined,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 120.0),
              child: NewsletterWidget(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBreadcrumbItem(String text, dynamic function) {
    return InkWell(
      onTap: function,
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          color: Color.fromARGB(255, 72, 76, 81),
        ),
      ),
    );
  }

  Widget _buildBreadcrumbSeparator() {
    return const Text(
      ' / ',
      style: TextStyle(
        fontSize: 16,
        color: Color.fromARGB(255, 158, 157, 164),
      ),
    );
  }
}
