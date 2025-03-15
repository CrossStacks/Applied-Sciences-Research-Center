import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../services/firebase_firestore/database.dart';

class EventPageController {
  List<DocumentSnapshot> events = [];
  DocumentSnapshot? lastDocument;
  bool isLoading = false;
  bool hasMore = true;
  final int limit = 2;

  final FirestoreDatabaseMethods _dbMethods = FirestoreDatabaseMethods();

  Future<void> fetchEvents() async {
    if (!hasMore) return;

    isLoading = true;
    try {
      QuerySnapshot snapshot = await _dbMethods.fetchEventsPaginated(
        lastDocument: lastDocument,
        limit: limit,
      );

      if (snapshot.docs.isNotEmpty) {
        lastDocument = snapshot.docs.last;
        events.addAll(snapshot.docs);
      }

      if (snapshot.docs.length < limit) {
        hasMore = false;
      }
    } catch (e) {
      debugPrint("Error in controller fetching events: $e");
    }
    isLoading = false;
  }

  String formatTimestamp1(Timestamp timestamp) {
    final DateTime dt = timestamp.toDate();
    return "${dt.day} ${getMonthAbbr(dt.month)}, ${dt.year}";
  }

  String formatTimestamp2(Timestamp timestamp) {
    final DateTime dt = timestamp.toDate();
    return "${getMonthName(dt.month)} ${dt.day}, ${dt.year}";
  }

  String getMonthAbbr(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months[month - 1];
  }

  String getMonthName(int month) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return months[month - 1];
  }
}
