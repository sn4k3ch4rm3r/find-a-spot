import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_a_spot/shared/data/firestore/models/database_record.dart';

class FirestoreRepository {
  FirebaseFirestore service;

  FirestoreRepository({required this.service});

  Future<void> save(DatabaseRecord data) async {
    await service.collection('spots').add(data.toJson());
  }

  Future<List<DatabaseRecord>> getSpots() async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await service.collection('spots').get();

    return snapshot.docs.where((document) {
      return document.data()['userId'] != null && document.exists;
    }).map((document) {
      return DatabaseRecord.fromJson(document.data());
    }).toList();
  }
}
