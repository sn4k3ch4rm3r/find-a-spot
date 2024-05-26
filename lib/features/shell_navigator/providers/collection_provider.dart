import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_a_spot/features/shell_navigator/models/collection_model.dart';
import 'package:find_a_spot/shared/data/firestore/models/database_record.dart';
import 'package:find_a_spot/shared/data/firestore/repositories/firestore_repository.dart';
import 'package:flutter/material.dart';

class CollectionProvider with ChangeNotifier {
  List<CollectionModel> _spots = [];

  final FirestoreRepository _firestore = FirestoreRepository(service: FirebaseFirestore.instance);

  Future<void> loadSpots() async {
    List<DatabaseRecord> records = await _firestore.getSpots();
    _spots = records.map((record) {
      return CollectionModel(
        caption: record.caption,
        coordinates: record.coordinates,
        imageUrl: record.imageUrl,
        name: "Todo",
      );
    }).toList();
    notifyListeners();
  }

  List<CollectionModel> get spots => _spots;
}
