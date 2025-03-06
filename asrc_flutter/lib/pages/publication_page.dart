import 'package:asrc_flutter/components/newsletter_widget.dart';
import 'package:flutter/material.dart';

import '../components/grid_builder.dart';

class PublicationPage extends StatelessWidget {
  const PublicationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(64.0),
            child: GridB(),
          ),
          NewsletterWidget(),
        ],
      ),
    );
  }
}
