import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_a_spot/shared/data/firestore/models/database_record.dart';

class FirestoreRepository {
  FirebaseFirestore service;

  FirestoreRepository({required this.service});

  Future<void> save(DatabaseRecord data) async {
    await service.collection('spots').add(data.toJson());
  }

  Stream<List<DatabaseRecord>> getSpotsStream() {
    return service.collection('spots').snapshots().map((snapshot) {
      return snapshot.docs.map((document) {
        return DatabaseRecord.fromJson(document.data());
      }).toList();
    });
  }
}
