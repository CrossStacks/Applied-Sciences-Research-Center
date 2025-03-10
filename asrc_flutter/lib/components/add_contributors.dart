import 'package:flutter/material.dart';

import '../models/contributors.dart';
import 'custom_input_widget.dart';

class AddContributors extends StatelessWidget {
  final TextEditingController firstName;
  final TextEditingController lastName;
  const AddContributors({
    super.key,
    required this.firstName,
    required this.lastName,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Author’s Information',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 13, 15, 17),
          ),
        ),
        Text(
          'Name of Author’s and Contributors',
          style: TextStyle(
            fontSize: 16,
            color: Color.fromARGB(255, 50, 53, 62),
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
        SizedBox(height: 16), // Spacing between rows.
      ],
    );
  }
}

// A stateful widget to manage multiple contributor rows.
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
    // Initialize with one contributor row.
    addContributor();
  }

  // Adds a new contributor row.
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

  @override
  void dispose() {
    // Dispose of all controllers to prevent memory leaks.
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
        // Render a row for each contributor.
        ...contributors.map((contributor) => AddContributors(
              firstName: contributor.firstNameController,
              lastName: contributor.lastNameController,
            )),
        // Plus button to add another author.
        IconButton(
          icon: Icon(Icons.add),
          onPressed: addContributor,
          tooltip: 'Add another author',
        ),
      ],
    );
  }
}
