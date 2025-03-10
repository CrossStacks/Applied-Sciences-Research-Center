import 'package:flutter/material.dart';
import 'custom_input_widget.dart';
import '../models/contributors.dart';

class AddContributors extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomInputWidget(
              hintText: 'Your first name...',
              keyboardType: TextInputType.name,
              controller: firstName,
              label: 'First Name',
              width: 344,
            ),
            CustomInputWidget(
              hintText: 'Your last name...',
              keyboardType: TextInputType.name,
              controller: lastName,
              label: 'Last Name',
              width: 344,
            ),
          ],
        ),
      ],
    );
  }
}

class ContributorsForm extends StatefulWidget {
  const ContributorsForm({super.key});

  @override
  State<ContributorsForm> createState() => _ContributorsFormState();
}

class _ContributorsFormState extends State<ContributorsForm> {
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
      contributors.removeLast();
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
      spacing: 16,
      children: [
        ...contributors.asMap().entries.map((entry) {
          int index = entry.key;
          Contributor contributor = entry.value;
          String label =
              index == 0 ? 'Main Author' : '${ordinal(index)} Co Author';
          return AddContributors(
            label: label,
            firstName: contributor.firstNameController,
            lastName: contributor.lastNameController,
          );
        }),
        Row(
          spacing: 10,
          children: [
            InkWell(
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              customBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              onTap: addContributor,
              child: Container(
                height: 48,
                width: 48,
                padding: EdgeInsets.all(13),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 0.5,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.add,
                  size: 20,
                ),
              ),
            ),
            if (contributors.length == 1) Text('Add Co Author'),
            if (contributors.length > 1)
              InkWell(
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                customBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                onTap: reduceContributor,
                child: Container(
                  height: 48,
                  width: 48,
                  padding: EdgeInsets.all(13),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 0.5,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
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
