import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kasir_euy/Class/LaporanPemasukanClass.dart';
import '../Class/LaporanPemasukanClass.dart';
import '../Class/LaporanPemasukanClass.dart';
import '../Class/LaporanPenjualanClass.dart';

class LaporanPenjualanService {
  final CollectionReference laporanPenjualan =
      FirebaseFirestore.instance.collection('laporanPemasukan');

  Future<List<LaporanPenjualan>> getItems() async {
    List<LaporanPenjualan> laporanpemasukanList = [];

    QuerySnapshot snapshot = await laporanPenjualan.get();

    snapshot.docs.forEach((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      laporanpemasukanList.add(LaporanPenjualan.fromMap(data));
    });
    return laporanpemasukanList;
  }

  Future<List<String>> getDocumentIds() async {
    final querySnapshot = await laporanPenjualan.get();
    final documentIds = querySnapshot.docs.map((doc) => doc.id).toList();
    return documentIds;
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
