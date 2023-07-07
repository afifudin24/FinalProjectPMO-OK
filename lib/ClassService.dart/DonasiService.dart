import 'package:cloud_firestore/cloud_firestore.dart';

import '../Class/DonasiClass.dart';

class DonasiService {
  final CollectionReference DonasiCollection =
      FirebaseFirestore.instance.collection('donasi');

  Future<List<Donasi>> getItems(String kd) async {
    List<Donasi> donasiList = [];

    QuerySnapshot snapshot = await DonasiCollection.where('idToko', isEqualTo: kd).get();

    snapshot.docs.forEach((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      donasiList.add(Donasi.fromMap(data));
    });
    return donasiList;
  }

  Future<List<String>> getDocumentIds() async {
    final querySnapshot = await DonasiCollection.get();
    final documentIds = querySnapshot.docs.map((doc) => doc.id).toList();
    return documentIds;
  }

  Future<void> addItem(String id, Donasi item) {
    String randomId = FirebaseFirestore.instance.collection('donasi').doc().id;
    return DonasiCollection.doc(randomId).set(item.toMap());
  }

  Future<void> updateItem(Donasi item) {
    return DonasiCollection.doc(item.namadonatur).update(item.toMap());
  }

  Future<void> deleteItem(String id) {
    return DonasiCollection.doc(id).delete();
  }
}
