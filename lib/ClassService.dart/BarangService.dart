import 'package:cloud_firestore/cloud_firestore.dart';

import '../Class/BarangClass.dart';

class BarangService {
  final CollectionReference barangCollection =
      FirebaseFirestore.instance.collection('barang');

  Future<List<Barang>> getItems() async {
    List<Barang> barangList = [];

    QuerySnapshot snapshot = await barangCollection.get();

    snapshot.docs.forEach((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      barangList.add(Barang.fromMap(data));
    });
    return barangList.toList();
  }

  Future<List<String>> getDocumentIds() async {
    final querySnapshot = await barangCollection.get();
    final documentIds = querySnapshot.docs.map((doc) => doc.id).toList();
    return documentIds;
  }

  Future<void> addItem(Barang item) {
    String randomId = FirebaseFirestore.instance.collection('barang').doc().id;
    return barangCollection.doc(randomId).set(item.toMap());
  }

  Future<void> updateItem(Barang item) {
    return barangCollection.doc(item.kdbarang).update(item.toMap());
  }

  Future<void> deleteItem(String id) {
    return barangCollection.doc(id).delete();
  }


  }

