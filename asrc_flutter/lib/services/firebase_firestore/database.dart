import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class FirestoreDatabaseMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addUserDetails(
      Map<String, dynamic> userInfoMap, String id) async {
    try {
      await _firestore.collection("users").doc(id).set(userInfoMap);
      debugPrint("User added successfully!");
    } catch (e) {
      debugPrint("Error adding user details: $e");
      rethrow;
    }
  }

  Future<DocumentSnapshot> getUserDetails(String id) async {
    try {
      final userSnapshot = await _firestore.collection("users").doc(id).get();
      if (userSnapshot.exists) {
        return userSnapshot;
      } else {
        debugPrint("User details not found for ID: $id");
        throw Exception("User details not found.");
      }
    } catch (e) {
      debugPrint("Error fetching user details: $e");
      rethrow;
    }
  }

  Future<QuerySnapshot> getUserByEmail(String email) async {
    try {
      final queries = await _firestore
          .collection("users")
          .where("Email", isEqualTo: email)
          .get();
      if (queries.docs.isEmpty) {
        debugPrint("No user found with the specified email.");
        throw Exception("No user found with the specified email.");
      }
      return queries;
    } catch (e) {
      debugPrint("Error fetching user by email: $e");
      rethrow;
    }
  }

  Future<void> updateUserDetails(
      String id, Map<String, dynamic> updatedData) async {
    try {
      final userRef = _firestore.collection("users").doc(id);
      await userRef.update(updatedData);
      debugPrint("User updated successfully!");
    } catch (e) {
      debugPrint("Error updating user details: $e");
      rethrow;
    }
  }

  Future<void> deleteUser(String id) async {
    try {
      await _firestore.collection("users").doc(id).delete();
      debugPrint("User deleted successfully!");
    } catch (e) {
      debugPrint("Error deleting user: $e");
      rethrow;
    }
  }

  Future<void> deleteUserByEmail(String email) async {
    try {
      final userQuerySnapshot = await _firestore
          .collection("users")
          .where("Email", isEqualTo: email)
          .get();

      if (userQuerySnapshot.docs.isEmpty) {
        debugPrint("No user found with the specified email.");
        throw Exception("No user found with the specified email.");
      }

      String userId = userQuerySnapshot.docs.first.id;

      await _firestore.collection("users").doc(userId).delete();
      debugPrint("User with email $email deleted successfully!");
    } catch (e) {
      debugPrint("Error deleting user by email: $e");
      rethrow;
    }
  }

  Future<QuerySnapshot> getAllUsers() async {
    try {
      final allUsersSnapshot = await _firestore.collection("users").get();
      return allUsersSnapshot;
    } catch (e) {
      debugPrint("Error fetching all users: $e");
      rethrow;
    }
  }

  Future<void> addEvent(Map<String, dynamic> eventInfoMap) async {
    try {
      DocumentReference docRef = _firestore.collection("events").doc();
      eventInfoMap['EventId'] = docRef.id;
      await docRef.set(eventInfoMap);
      debugPrint("Event added successfully with ID: ${docRef.id}");
    } catch (e) {
      debugPrint("Error adding event: $e");
      rethrow;
    }
  }

  Future<DocumentSnapshot> getEventById(String id) async {
    try {
      DocumentSnapshot docSnapshot =
          await _firestore.collection("events").doc(id).get();
      if (docSnapshot.exists) {
        return docSnapshot;
      } else {
        throw Exception("Event with ID $id does not exist.");
      }
    } catch (e) {
      debugPrint("Error getting event by ID: $e");
      rethrow;
    }
  }

  Future<QuerySnapshot> getEventByName(String name) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection("events")
          .where("Title", isEqualTo: name)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot;
      } else {
        throw Exception("No event found with name: $name");
      }
    } catch (e) {
      debugPrint("Error getting event by name: $e");
      rethrow;
    }
  }

  Future<void> updateEvent(String id, Map<String, dynamic> updatedData) async {
    try {
      DocumentReference docRef = _firestore.collection("events").doc(id);
      await docRef.update(updatedData);
      debugPrint("Event with ID $id updated successfully.");
    } catch (e) {
      debugPrint("Error updating event: $e");
      rethrow;
    }
  }

  Future<void> deleteEvent(String id) async {
    try {
      await _firestore.collection("events").doc(id).delete();
      debugPrint("Event with ID $id deleted successfully.");
    } catch (e) {
      debugPrint("Error deleting event: $e");
      rethrow;
    }
  }

  Future<QuerySnapshot> getAllEvents() async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection("events").get();
      return querySnapshot;
    } catch (e) {
      debugPrint("Error getting all events: $e");
      rethrow;
    }
  }

  Future<QuerySnapshot> fetchEventsPaginated(
      {DocumentSnapshot? lastDocument, required int limit}) async {
    try {
      Query query = _firestore
          .collection("events")
          .orderBy("EventDate", descending: true)
          .limit(limit);
      if (lastDocument != null) {
        query = query.startAfterDocument(lastDocument);
      }
      return await query.get();
    } catch (e) {
      debugPrint("Error fetching paginated events: $e");
      rethrow;
    }
  }
}
