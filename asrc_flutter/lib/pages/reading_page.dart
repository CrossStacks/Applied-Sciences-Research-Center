import 'package:asrc_flutter/components/newsletter_widget.dart';
import 'package:flutter/material.dart';

class ReadingPage extends StatelessWidget {
  final String title;
  const ReadingPage({
    super.key,
    required this.title,
  });

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 252, 246, 243),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 16),
          child: Column(
            children: [
              Row(
                children: [
                  MouseRegion(
                    onEnter: (_) => {},
                    onExit: (_) => {},
                    child: InkWell(
                      onTap: () {
                        // Navigator.pop(context);
                      },
                      child: Text(
                        'Home',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color.fromARGB(255, 72, 76, 81),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    ' / ',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(255, 158, 157, 164),
                    ),
                  ),
                  MouseRegion(
                    onEnter: (_) => {},
                    onExit: (_) => {},
                    child: InkWell(
                      onTap: () {
                        // Navigator.pop(context);
                      },
                      child: Text(
                        'Reading',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color.fromARGB(255, 72, 76, 81),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    ' / ',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(255, 158, 157, 164),
                    ),
                  ),
                  Text(
                    getFirstThreeWordsWithEllipsis(title),
                    style: TextStyle(
                      fontSize: 14,
                      color: Color.fromARGB(255, 158, 157, 164),
                    ),
                  ),
                ],
              ),
              Container(
                width: 984,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: Column(
                    children: [
                      Text(
                        'Event',
                        style: TextStyle(
                          color: Color.fromARGB(255, 240, 106, 106),
                        ),
                      ),
                      if (title.contains('–'))
                        ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: 1000),
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: getWords(title)[0],
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
                                  text: getWords(title)[1],
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
                      if (!title.contains('–'))
                        ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: 1000),
                          child: Text(
                            title,
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
                            'Music uniquely syncs with your brain, slowing your heart rate and reducing cortisol - the stress hormone.',
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
      ),
    );
  }
}
