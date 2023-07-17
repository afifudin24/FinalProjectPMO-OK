import 'package:cloud_firestore/cloud_firestore.dart';

import '../Class/LaporanPengeluaran.dart';

class LaporanPengeluaranService {
  final CollectionReference laporanPenjualan =
      FirebaseFirestore.instance.collection('laporanPengeluaran');

  Future<List<LaporanPengeluaran>> getItems() async {
    List<LaporanPengeluaran> laporanpenjualanList = [];

    QuerySnapshot snapshot = await laporanPenjualan.get();

    snapshot.docs.forEach((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      laporanpenjualanList.add(LaporanPengeluaran.fromMap(data));
    });
    return laporanpenjualanList;
  }

  Future<List<String>> getDocumentIds() async {
    final querySnapshot = await laporanPenjualan.get();
    final documentIds = querySnapshot.docs.map((doc) => doc.id).toList();
    return documentIds;
  }

  Future<List<LaporanPengeluaran>> getData(String kd) async {
    List<LaporanPengeluaran> laporanpenjualanListData = [];

    QuerySnapshot snapshot =
        await laporanPenjualan.where("idToko", isEqualTo: kd).get();

    snapshot.docs.forEach((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      laporanpenjualanListData.add(LaporanPengeluaran.fromMap(data));
    });
    return laporanpenjualanListData.toList();
  }

  Future<void> addItem(String id, LaporanPengeluaran item) {
    return laporanPenjualan.doc(id).set(item.toMap());
  }

  Future<void> updateItem(String id, item) {
    return laporanPenjualan.doc(id).update(item.toMap());
  }

  Future<void> deleteItem(String id) {
    return laporanPenjualan.doc(id).delete();
  }
}
