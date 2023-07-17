import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kasir_euy/Class/MemberClass.dart';
import 'package:kasir_euy/ClassService.dart/MemberService.dart';
import 'package:kasir_euy/ClassService.dart/MemberService.dart';
import 'package:kasir_euy/Layout/komposisi.dart';

import '../Class/TokoClass.dart';

class CrudMemberClass extends StatefulWidget {
  const CrudMemberClass({super.key});

  @override
  State<CrudMemberClass> createState() => _CrudMemberClass();
}

class _CrudMemberClass extends State<CrudMemberClass> {
  MemberService controller = MemberService();
  List<Member> _member = [];
  List<String> _id = [];

  @override
  void initState() {
    super.initState();
    _loadUsers();
    _loadID();
    print("OK");
  }

  Future<void> _loadUsers() async {
    print("lah");
    List<Member> members = await controller.getMembers();
    setState(() {
      _member = members;
    });
  }

  Future<void> _loadID() async {
    List<String> documentIds = await controller.getMemberDocumentIds();
    print('Document IDs: $documentIds');
    setState(() {
      _id = documentIds;
    });
    print(_id);
  }

  int getItemCount() {
    return _member.length; // Mengembalikan panjang data sebagai jumlah item
  }

  @override
  Widget build(BuildContext context) {
    String? nullableValue = null; // Replace `null` with your actual value
    String nonNullableValue = nullableValue != null ? nullableValue : '';
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Member'),
        backgroundColor: primaryColor,
        centerTitle: true,
      ),
      body: buildView(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          setState(() {
            Member newItem = Member(
                idMember: '128klk3gjh',
                email: 'Itemoojjlk 1hgjh',
                nama: 'Deslcr;kkiptjhgion 1',
                alamat: 'ok',
                telepon: '0');

            controller.addMember(newItem);
            print("okbng");
            _loadUsers();
            refreshPage();
          });
        },
      ),
    );
  }

  Widget buildView() {
    return ListView.builder(
      itemCount: _member.length,
      itemBuilder: (context, index) {
        Member member = _member[index];

        return ListTile(
          title: Text(_id[index]),
          subtitle: Text(member.nama),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              controller.deleteMember(_id[index]);
              _loadUsers();
              refreshPage();
            },
          ),
        );
      },
    );
  }

  void refreshPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => CrudMemberClass()),
    );
  }
}
