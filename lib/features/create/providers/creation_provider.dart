import 'dart:io';

import 'package:find_a_spot/features/create/models/location.dart';
import 'package:find_a_spot/features/create/repositories/location_repository.dart';
import 'package:flutter/material.dart';

class CreationProvider with ChangeNotifier {
  Location? _location;
  late File _imageFile;
  late String _caption;
  late List<Location> _serachResult;

  UploadState _uploadState = UploadState.none;

  LocationRepository service = LocationRepository();

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
    searchResult = await service.search(query);
  }

  Future<void> submit() async {
    uploadState = UploadState.uploading;
    await Future.delayed(const Duration(seconds: 2));
    uploadState = UploadState.done;
  }
}

enum UploadState {
  none,
  uploading,
  done
}
