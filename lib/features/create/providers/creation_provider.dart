import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_a_spot/features/create/models/location.dart';
import 'package:find_a_spot/features/create/repositories/firebase_storage_repository.dart';
import 'package:find_a_spot/features/create/repositories/location_repository.dart';
import 'package:find_a_spot/shared/data/firestore/models/database_record.dart';
import 'package:find_a_spot/shared/data/firestore/repositories/firestore_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class CreationProvider with ChangeNotifier {
  Location? _location;
  late File _imageFile;
  late String _caption;
  late List<Location> _serachResult;

  UploadState _uploadState = UploadState.none;

  final LocationRepository _locationRepository = LocationRepository();
  final FirestoreRepository _firestoreRepository = FirestoreRepository(service: FirebaseFirestore.instance);
  final FirebaseStorageRepository _firebaseStorageRepository = FirebaseStorageRepository(service: FirebaseStorage.instance);

  Location? get location => _location;
  set location(Location? value) {
    _location = value;
    notifyListeners();
  }

  File get imageFile => _imageFile;
  set imageFile(File value) {
    _imageFile = value;
    notifyListeners();
  }

  String get caption => _caption;
  set caption(String value) {
    _caption = value;
    notifyListeners();
  }

  void initializeCreation(File imageFile) {
    _imageFile = imageFile;
    _location = null;
    _caption = "";
    _serachResult = [];
    _uploadState = UploadState.none;
    notifyListeners();
  }

  List<Location> get searchResult => _serachResult;
  set searchResult(List<Location> value) {
    _serachResult = value;
    notifyListeners();
  }

  UploadState get uploadState => _uploadState;
  set uploadState(UploadState value) {
    _uploadState = value;
    notifyListeners();
  }

  Future<void> search(String query) async {
    searchResult = await _locationRepository.search(query);
  }

  Future<void> submit() async {
    uploadState = UploadState.uploading;
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null && _location != null) {
      String? imageUrl = await _firebaseStorageRepository.uploadImage(_imageFile);
      if (imageUrl != null) {
        DatabaseRecord data = DatabaseRecord(
          userId: user.uid,
          coordinates: _location!.coordinates,
          imageUrl: imageUrl,
          osmId: _location?.osmId,
          caption: _caption,
        );
        await _firestoreRepository.save(data);
        uploadState = UploadState.done;
        return;
      }
    }
    uploadState = UploadState.error;
  }
}

enum UploadState {
  none,
  uploading,
  done,
  error,
}
