import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageDatabase {
  static final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  static Future<String?> uploadImage(Uint8List? image, String path) async {
    if (image == null) return 'No image selected';
    try {
      final ref = _firebaseStorage.ref(path);
      await ref.putData(image);
      return await ref.getDownloadURL();
    } catch (e) {
      rethrow;
    }
  }

  // Future<void> deleteFile(String path) async {
  //   try {
  //     final ref = _firebaseStorage.ref(path);
  //     await ref.delete();
  //   } catch (e) {
  //     rethrow;
  //   }
  // }
}
