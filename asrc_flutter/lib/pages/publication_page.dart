import 'package:asrc_flutter/components/newsletter_widget.dart';
import 'package:flutter/material.dart';

class PublicationPage extends StatelessWidget {
  const PublicationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: NewsletterWidget(),
      ),
    );
  }
}
