import 'package:cloud_firestore/cloud_firestore.dart';

import '../Class/LaporanPenjualanClass.dart';

class LaporanPenjualanService {
  final CollectionReference laporanPenjualan =
      FirebaseFirestore.instance.collection('laporanPenjualan');

  Future<List<LaporanPenjualan>> getItems() async {
    List<LaporanPenjualan> laporanpenjualanList = [];

    QuerySnapshot snapshot = await laporanPenjualan.get();

    snapshot.docs.forEach((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      laporanpenjualanList.add(LaporanPenjualan.fromMap(data));
    });
    return laporanpenjualanList;
  }

  Future<List<String>> getDocumentIds() async {
    final querySnapshot = await laporanPenjualan.get();
    final documentIds = querySnapshot.docs.map((doc) => doc.id).toList();
    return documentIds;
  }

  Future<List<LaporanPenjualan>> getData(String kd) async {
    List<LaporanPenjualan> laporanpenjualanListData = [];

    QuerySnapshot snapshot =
        await laporanPenjualan.where("idToko", isEqualTo: kd).get();

    snapshot.docs.forEach((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      laporanpenjualanListData.add(LaporanPenjualan.fromMap(data));
    });
    return laporanpenjualanListData.toList();
  }

  Future<void> addItem(LaporanPenjualan item) {
    String randomId =
        FirebaseFirestore.instance.collection('laporanpemasukan').doc().id;
    return laporanPenjualan.doc(randomId).set(item.toMap());
  }

  Future<void> updateItem(String id, item) {
    return laporanPenjualan.doc(id).update(item.toMap());
  }

  Future<void> deleteItem(String id) {
    return laporanPenjualan.doc(id).delete();
  }
}
