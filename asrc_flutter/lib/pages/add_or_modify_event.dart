import 'dart:typed_data';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import '../components/add_contributors.dart';
import '../components/custom_button_widget.dart';
import '../components/custom_input_widget.dart';
import '../components/date_picker.dart';
import '../controllers/add_or_modify_event_controller.dart';
import '../utils/constants.dart';

class AddOrModifyEvent extends StatefulWidget {
  const AddOrModifyEvent({super.key});

  @override
  State<AddOrModifyEvent> createState() => _AddOrModifyEventState();
}

class _AddOrModifyEventState extends State<AddOrModifyEvent> {
  final AddOrModifyEventController controller = AddOrModifyEventController();

  Widget _buildInfoRow(String text) {
    return Row(
      children: [
        const Icon(
          Icons.circle_outlined,
          color: Color.fromARGB(255, 252, 137, 95),
        ),
        Padding(
          padding: const EdgeInsets.all(4),
          child: Text(
            text,
            style: const TextStyle(
              color: Color.fromARGB(255, 13, 15, 17),
              fontSize: 16,
            ),
          ),
        ),
      ],
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
                const TextSpan(
                  text: 'Browse files',
                  style: TextStyle(
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

  Widget _buildImagePreview(Uint8List coverImage) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: Image.memory(
        coverImage,
        fit: BoxFit.cover,
        width: double.infinity,
        height: 126,
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        width: 760,
        height: 90,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
            color: const Color.fromARGB(255, 219, 219, 220),
          ),
        ),
        child: controller.isLoading
            ? const Center(child: CircularProgressIndicator())
            : Row(
                children: [
                  CustomButtonWidget(
                    text: 'Back',
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    initialColor: Colors.white,
                    initialTextColor: const Color.fromARGB(255, 13, 15, 17),
                    hoverColor: Colors.white,
                    hoverTextColor: const Color.fromARGB(255, 13, 15, 17),
                    onTap: () => Navigator.pop(context),
                    initialBorderColor:
                        const Color.fromARGB(255, 219, 219, 220),
                    hoverBorderColor: const Color.fromARGB(255, 158, 157, 164),
                  ),
                  const Spacer(),
                  CustomButtonWidget(
                    text: 'Submit',
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    initialColor: const Color.fromARGB(255, 13, 15, 17),
                    initialTextColor: Colors.white,
                    hoverColor: Colors.white,
                    hoverTextColor: Colors.black,
                    onTap: () async {
                      await controller.submitEvent(() {
                        setState(() {});
                      });

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Submission done")),
                      );
                      Navigator.pop(context);
                    },
                    hoverBorderColor: const Color.fromARGB(255, 13, 15, 17),
                  ),
                ],
              ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
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
                          style: const TextStyle(fontSize: 16),
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () => Navigator.pop(context),
                          borderRadius: BorderRadius.circular(50),
                          customBorder: Border.all(
                            width: 5,
                            color: const Color.fromARGB(255, 219, 219, 220),
                          ),
                          child: Container(
                            height: 48,
                            width: 48,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(
                                width: 0.5,
                                color: const Color.fromARGB(255, 219, 219, 220),
                              ),
                            ),
                            child: const Icon(
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
                          children: const [
                            Text(
                              'Edit / Add new event',
                              style: TextStyle(
                                color: Color.fromARGB(255, 13, 15, 17),
                                fontWeight: FontWeight.bold,
                                fontSize: 40,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 16.0),
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
                        const Text(
                          'Organizer’s and Contributor’s Information',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 13, 15, 17),
                          ),
                        ),
                        const Text(
                          'Name of Organizer’s and Contributor’s',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 50, 53, 62),
                          ),
                        ),
                        ContributorsForm(key: controller.contributorsFormKey),
                      ],
                    ),
                    const Divider(
                      color: Color.fromARGB(255, 219, 219, 220),
                      thickness: 1,
                    ),
                    Column(
                      spacing: 16,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Upload Cover Image',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 13, 15, 17),
                          ),
                        ),
                        const Text(
                          'Supported Formats: png, jpg, pdf. Max: 25MB.',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 50, 53, 62),
                          ),
                        ),
                        InkWell(
                          borderRadius: BorderRadius.circular(24),
                          hoverColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () {
                            controller.onSelectImage(() {
                              setState(() {});
                            });
                          },
                          child: DottedBorder(
                            color: Colors.black,
                            strokeWidth: 1,
                            dashPattern: const [4, 2],
                            borderType: BorderType.RRect,
                            radius: const Radius.circular(24),
                            child: SizedBox(
                              height: 126,
                              width: double.infinity,
                              child: controller.coverImage == null
                                  ? _buildEmptyState(context)
                                  : _buildImagePreview(controller.coverImage!),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Divider(
                      color: Color.fromARGB(255, 219, 219, 220),
                      thickness: 1,
                    ),
                    Column(
                      spacing: 16,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Event Information',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 13, 15, 17),
                          ),
                        ),
                        const Text(
                          'Please provide the event details below:',
                          style: TextStyle(
                            color: Color.fromARGB(255, 50, 53, 62),
                            fontSize: 16,
                          ),
                        ),
                        _buildInfoRow(
                          'Event Type: e.g., Conference, Workshop, Panel Discussion, etc.',
                        ),
                        _buildInfoRow(
                          'Meta Description: Provide a brief 1-2 sentence overview of the event.',
                        ),
                        _buildInfoRow(
                          'Reading Time: Specify an estimated duration (e.g., "5 min read" or "10 min read").',
                        ),
                        CustomInputWidget(
                          hintText: 'Enter the title...',
                          controller: controller.title,
                          label: 'Title',
                          width: 728,
                          keyboardType: TextInputType.text,
                        ),
                        DatePicker(
                          onDateSelected: (date) {
                            controller.setEventDate(date, () {
                              setState(() {});
                            });
                          },
                        ),
                        CustomInputWidget(
                          hintText: 'Enter the event type...',
                          controller: controller.eventType,
                          label: 'Event Type',
                          width: 728,
                          keyboardType: TextInputType.text,
                        ),
                        CustomInputWidget(
                          hintText: 'Enter the meta description...',
                          controller: controller.metaDescription,
                          label: 'Meta Description',
                          width: 728,
                          keyboardType: TextInputType.text,
                        ),
                        CustomInputWidget(
                          hintText: 'Enter the reading time...',
                          controller: controller.readingTime,
                          label: 'Reading Time',
                          width: 728,
                          keyboardType: TextInputType.text,
                        ),
                        CustomInputWidget(
                          minLines: 10,
                          expandable: true,
                          hintText: 'Content of the event...',
                          controller: controller.body,
                          label: 'Body',
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
}
