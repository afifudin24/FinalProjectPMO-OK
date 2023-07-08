import 'package:cloud_firestore/cloud_firestore.dart';

import '../Class/BarangClass.dart';

class BarangService {
  final CollectionReference barangCollection =
      FirebaseFirestore.instance.collection('barang');

  Future<List<Barang>> getItems(String id) async {
    List<Barang> barangList = [];

    QuerySnapshot snapshot =
        await barangCollection.where("idtoko", isEqualTo: id).get();

    snapshot.docs.forEach((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      barangList.add(Barang.fromMap(data));
    });
    return barangList.toList();
  }

  Future<List<Barang>> getData(String kd) async {
    List<Barang> barangData = [];

    QuerySnapshot snapshot =
        await barangCollection.where("kdbarang", isEqualTo: kd).get();

    snapshot.docs.forEach((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      barangData.add(Barang.fromMap(data));
    });
    return barangData.toList();
  }

  Future<List<String>> getDocumentIds() async {
    final querySnapshot = await barangCollection.get();
    final documentIds = querySnapshot.docs.map((doc) => doc.id).toList();
    return documentIds;
  }

  Future<List<String>> getDocumentDataIds(String kd) async {
    final querySnapshot =
        await barangCollection.where("kdbarang", isEqualTo: kd).get();
    final documentIds = querySnapshot.docs.map((doc) => doc.id).toList();
    return documentIds;
  }

  Future<void> addItem(String id, Barang item) {
  
    return barangCollection.doc(id).set(item.toMap());
  }

  Future<void> updateItem(String id, item) {
    return barangCollection.doc(id).update(item.toMap());
  }

  Future<void> deleteItem(String id) {
    return barangCollection.doc(id).delete();
  }
}
