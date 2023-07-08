import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kasir_euy/Class/LaporanPemasukanClass.dart';

class LaporanPemasukanService {
  final CollectionReference laporanPemasukan =
      FirebaseFirestore.instance.collection('laporanPemasukan');

  Future<List<LaporanPemasukan>> getItems() async {
    List<LaporanPemasukan> laporanpemasukanList = [];

    QuerySnapshot snapshot = await laporanPemasukan.get();

    snapshot.docs.forEach((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      laporanpemasukanList.add(LaporanPemasukan.fromMap(data));
    });
    return laporanpemasukanList;
  }

  Future<List<LaporanPemasukan>> getData(String id) async {
    List<LaporanPemasukan> laporanpemasukanList = [];

    QuerySnapshot snapshot = await laporanPemasukan.where("idToko", isEqualTo: id).get();

    snapshot.docs.forEach((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      laporanpemasukanList.add(LaporanPemasukan.fromMap(data));
    });
    return laporanpemasukanList;
  }

  Future<List<String>> getDocumentIds() async {
    final querySnapshot = await laporanPemasukan.get();
    final documentIds = querySnapshot.docs.map((doc) => doc.id).toList();
    return documentIds;
  }

  Future<void> addItem(String id, LaporanPemasukan item) {
    
    return laporanPemasukan.doc(id).set(item.toMap());
  }

  Future<void> updateItem(String id, item) {
    return laporanPemasukan.doc(id).update(item.toMap());
  }

  Future<void> deleteItem(String id) {
    return laporanPemasukan.doc(id).delete();
  }
}
