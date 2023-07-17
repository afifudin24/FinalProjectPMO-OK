import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kasir_euy/Class/MemberClass.dart';
import 'package:kasir_euy/ClassService.dart/MemberService.dart';
import 'package:kasir_euy/ClassService.dart/MemberService.dart';
import 'package:kasir_euy/Layout/komposisi.dart';

import '../Class/TokoClass.dart';
import '../main.dart';

class CrudMemberClass extends StatefulWidget {
  const CrudMemberClass({super.key});

  @override
  State<CrudMemberClass> createState() => _CrudMemberClass();
}

class _CrudMemberClass extends State<CrudMemberClass> {
  TextEditingController idcon = TextEditingController();
  TextEditingController emailcon = TextEditingController();
  TextEditingController nama= TextEditingController();
  TextEditingController alamat = TextEditingController();
  TextEditingController telepon = TextEditingController();
  MemberService controller = MemberService();
  List<Member> _member = [];
  List<Member> _memberpilih = [];
  List<String> _id = [];

  @override
  void initState() {
    super.initState();
    _loadUsers();
    // _loadID();
    print("OK");
    print(_member);
  }

  Future<void> _loadUsers() async {
    print("lah");
    List<Member> members = await controller.getMembersData(currentUser!.uid.toString());
    setState(() {
      _member = members;
    });
  }



  int getItemCount() {
    return _member.length; // Mengembalikan panjang data sebagai jumlah item
  }

  Future<void> _loadData(String kd) async {
    List<Member> memberList= await controller.getMembersDataPilih(kd);
    setState(() {
      _memberpilih = memberList;
      idcon.text = _memberpilih[0].idMember;
      emailcon.text = _memberpilih[0].email;
      nama.text = _memberpilih[0].nama;
      alamat.text = _memberpilih[0].alamat;
      telepon.text = _memberpilih[0].telepon;
    });
  }

// Future<void> _loadData(String kd) async {
//     List<Barang> barangPilih = await controller.getData(kd);
//     setState(() {
//       _barangdata = barangPilih;
//       conKodeBarang.text = _barangdata[0].kdbarang;
//       conHargaBarang.text = _barangdata[0].harga.toString();
//       conNamaBarang.text = _barangdata[0].namabarang;
//       conStokBarang.text = _barangdata[0].stok.toString();
//     });
//   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Member'),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      body:(){
        if(_member.length > 0){
          return buildView(context);
        }else{
          return Center(child: Text("Belum ada data"),);
        }
      } (),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        child: Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Tambah Member'),
        content:Container
        (height: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             TextField(
            decoration: InputDecoration(
              label: Text("ID Member"),
              border: OutlineInputBorder(           
              ),
            ),
            controller: idcon, 
          ),
          SizedBox(height: 10.0),
          TextField(
            decoration: InputDecoration(
              label: Text("Email"),
              border: OutlineInputBorder(           
              ),
            ),
            controller: emailcon, 
          ),
          SizedBox(height: 10.0),
          TextField(
            decoration: InputDecoration(
              label: Text("Nama"),
              border: OutlineInputBorder(           
              ),
            ),
            controller: nama, 
          ),
          SizedBox(height: 10.0),
          TextField(
            decoration: InputDecoration(
              label: Text("Alamat"),
              border: OutlineInputBorder(           
              ),
            ),
            controller: alamat, 
          ),
          SizedBox(height: 10.0),
          TextField(
            decoration: InputDecoration(
              label: Text("Telepon"),
              border: OutlineInputBorder(           
              ),
            ),
            controller: telepon, 
          ),
        ],),),

        actions: [
          ElevatedButton.icon(
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.green)
            ),
            onPressed: (){
            
              // String randomId = FirebaseFirestore.instance.collection('member').doc().id;
            Member newItem = Member(
              idtoko: currentUser!.uid.toString(),
                idMember: idcon.text,
                email: emailcon.text,
                nama: nama.text,
                alamat: alamat.text,
                telepon: telepon.text);

            controller.addMember(idcon.text, newItem).then((value) {
              refreshPage();
              Navigator.pop(context);
           
              print('Berhasil Tambah');
             
              showDialog(context: context, builder: (BuildContext context) { 
                return AlertDialog(
                  title: Text("Berhasil"),
                  content: Container(
                    height: 150,
                    width: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.check_circle_outline, color: Colors.blue, size: 50,)
                        ,
                        SizedBox(height: 20,),
                        Center(
                          child: Text("Berhasil Tambah Data"),
                        ),
                      ],
                    ),
                  ),
                );
               }, );
              print('ok');
            }).catchError((onError) {
              print("Gagal");
            });
            print("okey");
           
            // refreshPage();

        
          }, icon: Icon(Icons.add), label: Text("Tambah")),
          ElevatedButton.icon(
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.red)
            ),
            onPressed: (){
            Navigator.pop(context);
          }, icon: Icon(Icons.close_sharp), label: Text("Batal")),
        ],
      );
    },
  );
          // setState(() {
          //   Member newItem = Member(
          //       idMember: '128klk3gjh',
          //       email: 'Itemoojjlk 1hgjh',
          //       nama: 'Deslcr;kkiptjhgion 1',
          //       alamat: 'ok',
          //       telepon: '0');

          //   controller.addMember(newItem);
          //   print("okbng");
          //   _loadUsers();
          //   refreshPage();
          // });
        },
      ),
    );
  }

  Widget buildView(BuildContext context) {
    return ListView.builder(
      itemCount: _member.length,
      itemBuilder: (context, index) {
        Member member = _member[index];
        return ListTile(
          title: Text(member.idMember),
          subtitle: Text(member.nama),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.delete, color: Colors.red,),
                onPressed: () {
                 
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Yakin Ingin Menghapus Data?'),
                        // content: Text('Ya'),
                        // content: Text('Tidak'),
                        actions:[
                          TextButton(
                            child: Text('Ya'),
                            onPressed: () {
                              controller.deleteMember(member.idMember);
                  _loadUsers();
                    Navigator.of(context).pop(); 
                              },
                              ),
                          TextButton(
                            child: Text('Tidak'),
                            onPressed: () {
                              Navigator.of(context).pop(); // Menutup dialog
                              },
                              ),
                              ],
                              );
                              },
                              );
                  // refreshPage();
                },
              ),
              IconButton(
                icon: Icon(Icons.edit, color: Colors.green,),
                onPressed: () {
                  _loadData(member.idMember);
                    showDialog(
            context: context,
            builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Update Member'),
        content:Container
        (height: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          TextField(
            decoration: InputDecoration(
              label: Text("ID Member"),
              border: OutlineInputBorder(           
              ),
            ),
            controller: idcon, 
          ),
          SizedBox(height: 10.0),
          TextField(
            decoration: InputDecoration(
              label: Text("Email"),
              border: OutlineInputBorder(           
              ),
            ),
            controller: emailcon, 
          ),
          SizedBox(height: 10.0),
          TextField(
            decoration: InputDecoration(
              label: Text("Nama"),
              border: OutlineInputBorder(           
              ),
            ),
            controller: nama, 
          ),
          SizedBox(height: 10.0),
          TextField(
            decoration: InputDecoration(
              label: Text("Alamat"),
              border: OutlineInputBorder(           
              ),
            ),
            controller: alamat, 
          ),
          SizedBox(height: 10.0),
          TextField(
            decoration: InputDecoration(
              label: Text("Telepon"),
              border: OutlineInputBorder(           
              ),
            ),
            controller: telepon, 
          ),
        ],),),
    
        actions: [
          ElevatedButton.icon(
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.green)
            ),onPressed: (){
            
            Member newItem = Member(
              idtoko: currentUser!.uid.toString(),
                idMember: member.idMember,
                email: emailcon.text,
                nama: nama.text,
                alamat: alamat.text,
                telepon: telepon.text);
    
            controller.updateMember(member.idMember.toString(), newItem).then((value) {
              refreshPage();
              Navigator.pop(context);

              print('Berhasil Update');
              showDialog(context: context, builder: (BuildContext context) { 
                return AlertDialog(
                  title: Text("Berhasil"),
                  content: Container(
                    height: 100,
                    width: 100,
                    child: Center(
                      child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.check_circle_outline, color: Colors.blue, size: 50,)
                        ,
                        SizedBox(height: 20,),
                        Center(
                          child: Text("Berhasil Update Data"),
                        ),
                      ],
                    ),
                  ),
                  )
                );
               }, );

            }).catchError((onError) {
              print("Gagal");
            });
            print("okey");
           
            // refreshPage();
    
        
          }, icon: Icon(Icons.edit), label: Text("Update")),
          ElevatedButton.icon(
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.red)
            ),
            onPressed: (){
            Navigator.pop(context);
          }, icon: Icon(Icons.close_sharp), label: Text("Batal")),
        ],
      );
                 
                }
                    );
                }
              ),
            ],
          ),
        );
      },
    );
  }

  void refreshPage() {
       _loadUsers();
       setState(() {
       idcon.clear();
       emailcon.clear();
       nama.clear();
       alamat.clear();
       telepon.clear();
       });
       
  }
}


