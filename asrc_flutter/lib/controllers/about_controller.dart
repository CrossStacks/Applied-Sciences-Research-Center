import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/firebase/database.dart';

class AboutController {
  Future<List<Map<String, dynamic>>> fetchTeamMembers() async {
    QuerySnapshot snapshot = await DatabaseMethods().getAllUsers();
    List<Map<String, dynamic>> members =
        snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    return members;
  }
}
