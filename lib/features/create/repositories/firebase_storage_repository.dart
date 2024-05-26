import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageRepository {
  Future<void> uploadImage(File image) async {
    try {
      Reference storageReference = FirebaseStorage.instance.ref().child('images/1.png');
      UploadTask uploadTask = storageReference.putFile(image);
      await uploadTask.whenComplete(() async {
        print(await storageReference.getDownloadURL());
      });
    } catch (e) {
      // Failed to upload
    }
  }
}
