import 'package:cloud_firestore/cloud_firestore.dart';

import '../Class/TokoClass.dart';

class TokoService {
  final CollectionReference tokoCollection =
      FirebaseFirestore.instance.collection('toko');

  Future<List<Toko>> getItems() async {
    List<Toko> tokoList = [];

    QuerySnapshot snapshot = await tokoCollection.get();

    snapshot.docs.forEach((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      tokoList.add(Toko.fromMap(data));
    });
    return tokoList;
  }

  Future<List<Toko>> getDataItems(String id) async {
    List<Toko> tokoList = [];

    QuerySnapshot snapshot =
        await tokoCollection.where("idtoko", isEqualTo: id).get();

    snapshot.docs.forEach((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      tokoList.add(Toko.fromMap(data));
    });
    return tokoList;
  }

  Future<List<String>> getDocumentIds() async {
    final querySnapshot = await tokoCollection.get();
    final documentIds = querySnapshot.docs.map((doc) => doc.id).toList();
    return documentIds;
  }

  Future<void> addItem(Toko item) {
    String randomId = FirebaseFirestore.instance.collection('toko').doc().id;
    return tokoCollection.doc(randomId).set(item.toMap());
  }

  Future<void> updateItem(String id, Toko item) {
    return tokoCollection.doc(id).update(item.toMap());
  }

  Future<void> deleteItem(String id) {
    return tokoCollection.doc(id).delete();
  }
}
