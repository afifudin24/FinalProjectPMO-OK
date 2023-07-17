import 'package:cloud_firestore/cloud_firestore.dart';

import '../Class/BarangSupplierClass.dart';

class BarangSupplierService {
  final CollectionReference barangSupplierCollection =
      FirebaseFirestore.instance.collection('barangSupplier');

  Future<List<BarangSupplier>> getItems(String id) async {
    List<BarangSupplier> barangSupplierList = [];

    QuerySnapshot snapshot =
        await barangSupplierCollection.where("idtoko", isEqualTo: id).get();

    snapshot.docs.forEach((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      barangSupplierList.add(BarangSupplier.fromMap(data));
    });
    return barangSupplierList.toList();
  }

  Future<List<BarangSupplier>> getData(String kd) async {
    List<BarangSupplier> barangData = [];

    QuerySnapshot snapshot =
        await barangSupplierCollection.where("kodebarang", isEqualTo: kd).get();

    snapshot.docs.forEach((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      barangData.add(BarangSupplier.fromMap(data));
    });
    return barangData.toList();
  }

  Future<List<String>> getDocumentIds() async {
    final querySnapshot = await barangSupplierCollection.get();
    final documentIds = querySnapshot.docs.map((doc) => doc.id).toList();
    return documentIds;
  }

  Future<List<String>> getDocumentDataIds(String kd) async {
    final querySnapshot =
        await barangSupplierCollection.where("kdbarang", isEqualTo: kd).get();
    final documentIds = querySnapshot.docs.map((doc) => doc.id).toList();
    return documentIds;
  }

  Future<void> addItem(String id, BarangSupplier item) {
    return barangSupplierCollection.doc(id).set(item.toMap());
  }

  Future<void> updateItem(String id, item) {
    return barangSupplierCollection.doc(id).update(item.toMap());
  }

  Future<void> deleteItem(String id) {
    return barangSupplierCollection.doc(id).delete();
  }
}
