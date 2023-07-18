import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kasir_euy/Layout/PenyaluranDonasi.dart';

import '../Class/PenyaluranDonasiClass.dart';



class PenyaluranDonasiService {
  final CollectionReference penyaluranDonasiCollection =
      FirebaseFirestore.instance.collection('penyalurandonasi');

  Future<List<PenyaluranDonasiClass>> getItems() async {
    List<PenyaluranDonasiClass> penyaluranDonasiList = [];

    QuerySnapshot snapshot = await penyaluranDonasiCollection.get();

    snapshot.docs.forEach((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      penyaluranDonasiList.add(PenyaluranDonasiClass.fromMap(data));
    });
    return penyaluranDonasiList;
  }
  Future<List<PenyaluranDonasiClass>> getPilihItems(String kd) async {
    List<PenyaluranDonasiClass> penyaluranDonasiList = [];

    QuerySnapshot snapshot = await penyaluranDonasiCollection.where('kdsalur', isEqualTo: kd).get();

    snapshot.docs.forEach((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      penyaluranDonasiList.add(PenyaluranDonasiClass.fromMap(data));
    });
    return penyaluranDonasiList;
  }

  Future<List<PenyaluranDonasiClass>> getDataItems(String id) async {
    List<PenyaluranDonasiClass> penyaluranDonasiList = [];

    QuerySnapshot snapshot = await penyaluranDonasiCollection
        .where("idtoko", isEqualTo: id)
        .get();

    snapshot.docs.forEach((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      penyaluranDonasiList.add(PenyaluranDonasiClass.fromMap(data));
    });
    return penyaluranDonasiList;
  }

  Future<List<String>> getDocumentIds() async {
    final querySnapshot = await penyaluranDonasiCollection.get();
    final documentIds = querySnapshot.docs.map((doc) => doc.id).toList();
    return documentIds;
  }

  Future<void> addItem(PenyaluranDonasiClass item) {
    String randomId =
        FirebaseFirestore.instance.collection('penyalurandonasi').doc().id;
    return penyaluranDonasiCollection.doc(randomId).set(item.toMap());
  }

  Future<void> updateItem(PenyaluranDonasiClass item) {
    return penyaluranDonasiCollection
        .doc(item.tujuan)
        .update(item.toMap());
  }

  Future<void> deleteItem(String id) {
    return penyaluranDonasiCollection.doc(id).delete();
  }
}
