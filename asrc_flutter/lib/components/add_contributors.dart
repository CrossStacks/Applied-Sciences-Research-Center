import 'package:flutter/material.dart';
import 'custom_input_widget.dart';
import '../models/contributors.dart';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import '../services/app/image_picker.dart';

class AddContributors extends StatefulWidget {
  final TextEditingController firstName;
  final TextEditingController lastName;
  final String label;
  const AddContributors({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.label,
  });

  @override
  State<AddContributors> createState() => _AddContributorsState();
}

class _AddContributorsState extends State<AddContributors> {
  Uint8List? contributorImage;

  Future<void> pickContributorImage() async {
    Uint8List? img = await PickImage().pickImage(ImageSource.gallery);
    setState(() {
      contributorImage = img;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              GestureDetector(
                onTap: pickContributorImage,
                child: CircleAvatar(
                  radius: 30,
                  backgroundImage: contributorImage != null
                      ? MemoryImage(contributorImage!)
                      : null,
                  child: contributorImage == null
                      ? const Icon(Icons.camera_alt, size: 30)
                      : null,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Row(
                  children: [
                    CustomInputWidget(
                      hintText: 'Your first name...',
                      keyboardType: TextInputType.name,
                      controller: widget.firstName,
                      label: 'First Name',
                      width: 344,
                    ),
                    const SizedBox(width: 16),
                    CustomInputWidget(
                      hintText: 'Your last name...',
                      keyboardType: TextInputType.name,
                      controller: widget.lastName,
                      label: 'Last Name',
                      width: 344,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ContributorsForm extends StatefulWidget {
  const ContributorsForm({super.key});

  @override
  State<ContributorsForm> createState() => ContributorsFormState();
}

class ContributorsFormState extends State<ContributorsForm> {
  final List<Contributor> contributors = [];

  @override
  void initState() {
    super.initState();
    addContributor();
  }

  String ordinal(int number) {
    if (number == 1) return '1st';
    if (number == 2) return '2nd';
    if (number == 3) return '3rd';
    return '${number}th';
  }

  void addContributor() {
    setState(() {
      contributors.add(
        Contributor(
          firstNameController: TextEditingController(),
          lastNameController: TextEditingController(),
        ),
      );
    });
  }

  void reduceContributor() {
    setState(() {
      if (contributors.isNotEmpty) {
        contributors.removeLast();
      }
    });
  }

  @override
  void dispose() {
    for (var contributor in contributors) {
      contributor.firstNameController.dispose();
      contributor.lastNameController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...contributors.asMap().entries.map((entry) {
          int index = entry.key;
          Contributor contributor = entry.value;
          String label = index == 0
              ? 'Main Organizer'
              : '${ordinal(index)} Co Organizer / Contributor';
          return AddContributors(
            label: label,
            firstName: contributor.firstNameController,
            lastName: contributor.lastNameController,
          );
        }).toList(),
        Row(
          children: [
            InkWell(
              onTap: addContributor,
              child: Container(
                height: 48,
                width: 48,
                padding: const EdgeInsets.all(13),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 0.5,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.add,
                  size: 20,
                ),
              ),
            ),
            const SizedBox(width: 10),
            if (contributors.length == 1) const Text('Add Co Author'),
            if (contributors.length > 1)
              InkWell(
                onTap: reduceContributor,
                child: Container(
                  height: 48,
                  width: 48,
                  padding: const EdgeInsets.all(13),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 0.5,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.remove,
                    size: 20,
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
