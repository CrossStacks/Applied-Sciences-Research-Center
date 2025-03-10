import 'dart:typed_data';
import 'package:asrc_flutter/components/add_contributors.dart';
import 'package:asrc_flutter/components/custom_button_widget.dart';
import 'package:asrc_flutter/components/custom_input_widget.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../components/date_picker.dart';
import '../services/app/image_picker.dart';
import '../utils/constants.dart';

class AddOrModifyEvent extends StatefulWidget {
  const AddOrModifyEvent({super.key});

  @override
  State<AddOrModifyEvent> createState() => _AddOrModifyEventState();
}

class _AddOrModifyEventState extends State<AddOrModifyEvent> {
  final TextEditingController title = TextEditingController();

  final TextEditingController eventType = TextEditingController();

  final TextEditingController metaDescription = TextEditingController();

  final TextEditingController readingTime = TextEditingController();

  final TextEditingController body = TextEditingController();

  Uint8List? coverImage;

  void onSelectImage() async {
    Uint8List? img = await PickImage().pickImage(ImageSource.gallery);
    setState(() {
      coverImage = img;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        width: 760,
        height: 86,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(
            50,
          ),
          border: Border.all(
            color: Color.fromARGB(255, 219, 219, 220),
          ),
        ),
        child: Row(
          children: [
            CustomButtonWidget(
              text: 'Back',
              textStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              initialColor: Colors.white,
              initialTextColor: Color.fromARGB(255, 13, 15, 17),
              hoverColor: Colors.white,
              hoverTextColor: Color.fromARGB(255, 13, 15, 17),
              onTap: () {},
              initialBorderColor: Color.fromARGB(255, 219, 219, 220),
              hoverBorderColor: Color.fromARGB(255, 158, 157, 164),
            ),
            Spacer(),
            CustomButtonWidget(
              text: 'Submit',
              textStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              initialColor: Color.fromARGB(255, 13, 15, 17),
              initialTextColor: Colors.white,
              hoverColor: Colors.white,
              hoverTextColor: Colors.black,
              onTap: () {},
              hoverBorderColor: Color.fromARGB(255, 13, 15, 17),
            ),
          ],
        ),
      ),
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
                  spacing: 56,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      spacing: 16,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Organizer’s and Contributor’s Information',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 13, 15, 17),
                          ),
                        ),
                        Text(
                          'Name of Organizer’s and Contributor’s',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 50, 53, 62),
                          ),
                        ),
                        ContributorsForm(),
                      ],
                    ),
                    Divider(
                      color: Color.fromARGB(255, 219, 219, 220),
                      thickness: 1,
                    ),
                    Column(
                      spacing: 16,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Upload Cover Image',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 13, 15, 17),
                          ),
                        ),
                        Text(
                          'Supported Formats: png, jpg, pdf. Max: 25MB.',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 50, 53, 62),
                          ),
                        ),
                        InkWell(
                          borderRadius: BorderRadius.circular(24),
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onTap: onSelectImage,
                          child: DottedBorder(
                            color: Colors.black,
                            strokeWidth: 1,
                            dashPattern: const [4, 2],
                            borderType: BorderType.RRect,
                            radius: const Radius.circular(24),
                            child: SizedBox(
                              height: 126,
                              width: double.infinity,
                              child: coverImage == null
                                  ? _buildEmptyState(context)
                                  : _buildImagePreview(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      color: Color.fromARGB(255, 219, 219, 220),
                      thickness: 1,
                    ),
                    Column(
                      spacing: 16,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Event Information',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 13, 15, 17),
                          ),
                        ),
                        Text(
                          'Please provide the event details below:',
                          style: TextStyle(
                            color: Color.fromARGB(255, 50, 53, 62),
                            fontSize: 16,
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.circle_outlined,
                              color: Color.fromARGB(255, 252, 137, 95),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4),
                              child: Text(
                                'Event Type: e.g., Conference, Workshop, Panel Discussion, etc.',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 13, 15, 17),
                                    fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.circle_outlined,
                              color: Color.fromARGB(255, 252, 137, 95),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4),
                              child: Text(
                                'Meta Description: Provide a brief 1-2 sentence overview of the event.',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 13, 15, 17),
                                    fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.circle_outlined,
                              color: Color.fromARGB(255, 252, 137, 95),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4),
                              child: Text(
                                'Reading Time: Specify an estimated duration (e.g., "5 min read" or "10 min read").',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 13, 15, 17),
                                    fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                        CustomInputWidget(
                          hintText: 'Enter the title...',
                          controller: title,
                          label: 'Title',
                          width: 728,
                          keyboardType: TextInputType.text,
                        ),
                        DatePicker(),
                        CustomInputWidget(
                          hintText: 'Enter the event type...',
                          controller: eventType,
                          label: 'Event Type',
                          width: 728,
                          keyboardType: TextInputType.text,
                        ),
                        CustomInputWidget(
                          hintText: 'Enter the meta description...',
                          controller: metaDescription,
                          label: 'Meta Description',
                          width: 728,
                          keyboardType: TextInputType.text,
                        ),
                        CustomInputWidget(
                          hintText: 'Enter the reading time...',
                          controller: readingTime,
                          label: 'Reading Time',
                          width: 728,
                          keyboardType: TextInputType.text,
                        ),
                        CustomInputWidget(
                          hintText: 'Content of the event...',
                          controller: body,
                          label: 'Body',
                          maxLines: 10,
                          width: 728,
                          keyboardType: TextInputType.text,
                        ),
                      ],
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

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.file_upload_outlined,
            size: 40,
            color: Colors.grey[700],
          ),
          const SizedBox(height: 8),
          RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 16,
                    color: Colors.black,
                  ),
              children: [
                TextSpan(
                  text: 'Browse files',
                  style: const TextStyle(
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const TextSpan(text: ' or drag-and-drop'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImagePreview() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: Image.memory(
        coverImage!,
        fit: BoxFit.cover,
        width: double.infinity,
        height: 126,
      ),
    );
  }
}
