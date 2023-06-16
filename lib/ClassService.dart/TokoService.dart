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

  Future<void> addItem(Toko item) {
    return tokoCollection.doc(item.idtoko).set(item.toMap());
  }

  Future<void> updateItem(Toko item) {
    return tokoCollection.doc(item.idtoko).update(item.toMap());
  }

  Future<void> deleteItem(String id) {
    return tokoCollection.doc(id).delete();
  }
}
