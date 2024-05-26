import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_a_spot/features/shell_navigator/models/collection_model.dart';
import 'package:find_a_spot/shared/data/firestore/repositories/firestore_repository.dart';
import 'package:flutter/material.dart';

class CollectionProvider with ChangeNotifier {
  final FirestoreRepository _firestore = FirestoreRepository(service: FirebaseFirestore.instance);

  Stream<List<CollectionModel>> get spotStream {
    return _firestore.getSpotsStream().map((records) {
      return records.map((record) {
        return CollectionModel(
          caption: record.caption,
          coordinates: record.coordinates,
          imageUrl: record.imageUrl,
          name: "Todo",
        );
      }).toList();
    });
  }
}
