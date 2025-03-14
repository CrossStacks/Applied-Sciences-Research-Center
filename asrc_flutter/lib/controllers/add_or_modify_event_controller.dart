import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../services/app/image_picker.dart';
import '../services/firebase_storage/database.dart';
import '../services/firebase_firestore/database.dart';
import '../components/add_contributors.dart';

class AddOrModifyEventController {
  bool isLoading = false;
  Uint8List? coverImage;
  DateTime? selectedEventDate;

  final TextEditingController title = TextEditingController();
  final TextEditingController eventType = TextEditingController();
  final TextEditingController metaDescription = TextEditingController();
  final TextEditingController readingTime = TextEditingController();
  final TextEditingController body = TextEditingController();

  final GlobalKey<ContributorsFormState> contributorsFormKey =
      GlobalKey<ContributorsFormState>();

  void toggleLoading(VoidCallback updateUI) {
    isLoading = !isLoading;
    updateUI();
  }

  Future<void> onSelectImage(VoidCallback updateUI) async {
    Uint8List? img = await PickImage().pickImage(ImageSource.gallery);
    if (img != null) {
      coverImage = img;
      updateUI();
    }
  }

  void setEventDate(DateTime date, VoidCallback updateUI) {
    selectedEventDate = date;
    updateUI();
  }

  Future<void> submitEvent(VoidCallback updateUI) async {
    toggleLoading(updateUI);

    // String? coverImageUrl = await FirebaseStorageDatabase.uploadImage(
    //     coverImage, 'events/cover_images/${title.text.trim()}');
    String coverImageUrl = 'coverImageUrl_placeholder';

    List<Map<String, dynamic>> contributorsData = [];
    var contributorsList = contributorsFormKey.currentState?.contributors ?? [];
    for (var contributor in contributorsList) {
      String? imageUrl;
      if (contributor.image != null) {
        // imageUrl = await FirebaseStorageDatabase.uploadImage(
        //   contributor.image,
        //   'events/contributors/${contributor.firstNameController.text.trim()}${contributor.lastNameController.text.trim()}'
        // );
        imageUrl = 'contributorImageUrl_placeholder';
      }
      contributorsData.add({
        'FirstName': contributor.firstNameController.text.trim(),
        'LastName': contributor.lastNameController.text.trim(),
        'ImageUrl': imageUrl ?? '',
      });
    }

    Map<String, dynamic> eventData = {
      'Title': title.text.trim(),
      'EventType': eventType.text.trim(),
      'MetaDescription': metaDescription.text.trim(),
      'ReadingTime': readingTime.text.trim(),
      'Body': body.text.trim(),
      'CoverImageUrl': coverImageUrl,
      'Contributors': contributorsData,
      'EventDate': selectedEventDate,
    };

    await FirestoreDatabaseMethods().addEvent(eventData);
    toggleLoading(updateUI);
  }

  void dispose() {
    title.dispose();
    eventType.dispose();
    metaDescription.dispose();
    readingTime.dispose();
    body.dispose();
  }
}
