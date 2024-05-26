import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:uuid/v4.dart';

class FirebaseStorageRepository {
  FirebaseStorage service;
  final UuidV4 _uuidV4 = const UuidV4();

  FirebaseStorageRepository({required this.service});

  final Map<String, String> _imageTypes = {
    '.jpg': 'image/jpeg',
    '.jpeg': 'image/jpeg',
    '.png': 'image/png',
    '.gif': 'image/gif'
  };

  Future<String?> uploadImage(File image, {String? name}) async {
    try {
      String fileName = name ?? "${_uuidV4.generate()}${extension(image.path)}";
      Reference storageReference = service.ref().child('images/$fileName');
      UploadTask uploadTask = storageReference.putFile(
        image,
        SettableMetadata(
          contentType: _imageTypes[extension(image.path)],
        ),
      );
      TaskSnapshot snapshot = await uploadTask.whenComplete(() => {});
      return snapshot.ref.getDownloadURL();
    } catch (e) {
      // Failed to upload
    }
    return null;
  }
}
