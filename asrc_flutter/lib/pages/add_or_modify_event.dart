import 'package:asrc_flutter/components/add_contributors.dart';
import 'package:asrc_flutter/components/custom_input_widget.dart';
import 'package:flutter/material.dart';
import '../utils/constants.dart';

class AddOrModifyEvent extends StatelessWidget {
  const AddOrModifyEvent({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController title = TextEditingController();
    TextEditingController eventType = TextEditingController();
    TextEditingController metaDescription = TextEditingController();
    TextEditingController readingTime = TextEditingController();
    TextEditingController body = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 244, 241, 237),
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(50),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          Constants.appName,
                          style: TextStyle(fontSize: 16),
                        ),
                        Spacer(),
                        InkWell(
                          onTap: () {},
                          borderRadius: BorderRadius.circular(50),
                          customBorder: Border.all(
                            width: 5,
                            color: Color.fromARGB(255, 219, 219, 220),
                          ),
                          child: Container(
                            height: 48,
                            width: 48,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(
                                width: 0.5,
                                color: Color.fromARGB(255, 219, 219, 220),
                              ),
                            ),
                            child: Icon(
                              Icons.close,
                              color: Color.fromARGB(255, 72, 76, 81),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 80.0),
                      child: SizedBox(
                        width: 728,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Edit / Add new event',
                              style: TextStyle(
                                color: Color.fromARGB(255, 13, 15, 17),
                                fontWeight: FontWeight.bold,
                                fontSize: 40,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 16.0),
                              child: Text(
                                'Great job on adding your event! Excited to see the impact it’ll have. Keep up the amazing work, and don’t hesitate to add more events — the community will love it!',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 50, 53, 62),
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 56.0, bottom: 164),
              child: SizedBox(
                width: 728,
                child: Column(
                  spacing: 14,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ContributorsForm(),
                    Divider(
                      color: Color.fromARGB(255, 219, 219, 220),
                      thickness: 1,
                    ),
                    CustomInputWidget(
                      hintText: 'Enter the title...',
                      controller: title,
                      label: 'Title',
                      width: 728,
                      keyboardType: TextInputType.text,
                    ),
                    CustomInputWidget(
                      hintText:
                          'Enter the event type...  i.e. Conference / Workshop / Panel Talk e.t.c.',
                      controller: eventType,
                      label: 'Event Type',
                      width: 728,
                      keyboardType: TextInputType.text,
                    ),
                    CustomInputWidget(
                      hintText:
                          'Enter the meta description...  i.e. A 1-2 line description of the event',
                      controller: metaDescription,
                      label: 'Meta Description',
                      width: 728,
                      keyboardType: TextInputType.text,
                    ),
                    CustomInputWidget(
                      hintText:
                          'Enter the reading time...  i.e. 5 min read / 10 min read',
                      controller: readingTime,
                      label: 'Reading Time',
                      width: 728,
                      keyboardType: TextInputType.text,
                    ),
                    CustomInputWidget(
                      hintText: 'Enter the main content of the event',
                      controller: body,
                      label: 'Body',
                      maxLines: 10,
                      width: 728,
                      keyboardType: TextInputType.text,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
