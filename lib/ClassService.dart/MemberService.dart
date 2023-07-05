import 'package:cloud_firestore/cloud_firestore.dart';

import '../Class/MemberClass.dart';

class MemberService {
  final CollectionReference memberCollection =
      FirebaseFirestore.instance.collection('member');

  Future<List<Member>> getMembers() async {
    List<Member> memberList = [];

    QuerySnapshot snapshot = await memberCollection.get();
    //ok
    snapshot.docs.forEach((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      memberList.add(Member.fromMap(data));
    });
    return memberList;
  }

  Future<List<Member>> getMembersData(String id) async {
    List<Member> memberList = [];
    QuerySnapshot snapshot =
        await memberCollection.where('idToko', isEqualTo: id).get();
    snapshot.docs.forEach((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      memberList.add(Member.fromMap(data));
    });
    return memberList;
  }

  Future<List<String>> getMemberDocumentIds() async {
    final querySnapshot = await memberCollection.get();
    final documentIds = querySnapshot.docs.map((doc) => doc.id).toList();
    return documentIds;
  }

  Future<void> addMember(Member member) {
    String randomId = FirebaseFirestore.instance.collection('member').doc().id;
    return memberCollection.doc(randomId).set(member.toMap());
  }

  Future<void> updateMember(Member member) {
    return memberCollection.doc(member.idMember).update(member.toMap());
  }

  Future<void> deleteMember(String id) {
    return memberCollection.doc(id).delete();
  }
}
