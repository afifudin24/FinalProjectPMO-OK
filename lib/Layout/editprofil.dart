import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kasir_euy/Layout/komposisi.dart';
import '../Class/TokoClass.dart';
import '../ClassService.dart/TokoService.dart';
import '../main.dart';
import 'HomeScreen.dart';

class EditProfil extends StatefulWidget {
  const EditProfil({Key? key}) : super(key: key);

  @override
  _EditProfilState createState() => _EditProfilState();
}

class _EditProfilState extends State<EditProfil> {
  TextEditingController _namaController = TextEditingController();
  TextEditingController _alamatController = TextEditingController();
  TextEditingController _mottoController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _adminController = TextEditingController();

  TokoService controller = TokoService();
  File? imageFile;
  String namatoko = "";
  String alamat = "";
  String mottotoko = "";
  String emailtoko = "";
  String admintoko = "";
  double? saldoku;
  String urlGambar = " ";
  void initState() {
    super.initState();
    _loadUsers();

    print("OK");
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        // imageFile = File(pickedImage.path);
        urlGambar = pickedImage.path;
      });
    }
  }

  Future<void> _loadUsers() async {
    print("lah");
    List<Toko> tokos =
        await controller.getDataItems(currentUser!.uid.toString());
    setState(() {
      namatoko = tokos[0].namatoko;
      alamat = tokos[0].alamat;
      mottotoko = tokos[0].mottotoko;
      emailtoko = tokos[0].email;
      admintoko = tokos[0].adminToko;
      _namaController.text = namatoko;
      _alamatController.text = alamat;
      _mottoController.text = mottotoko;
      _emailController.text = emailtoko;
      _adminController.text = admintoko;
      saldoku = tokos[0].saldo;
      urlGambar = tokos[0].urlImage;
      // urlImage = tokos[0].urlImage;
      print(tokos[0].urlImage);

      print(tokos[0].adminToko);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Edit Profil'),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                height: 200,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 150,
                      width: 150,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: FileImage(File(urlGambar)),
                      ),
                    ),
                    Positioned(
                        bottom: 15,
                        right: 1,
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: primaryColor,
                          ),
                          child: IconButton(
                              onPressed: () {
                                pickImage();
                              },
                              icon: Icon(
                                Icons.edit,
                                size: 15,
                                color: Colors.white,
                              )),
                        ))
                  ],
                ),
              ),
              Container(
                height: 700,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: ListView(
                    children: [
                      TextFormField(
                        controller: _namaController,
                        decoration: InputDecoration(
                          labelText: 'Nama',
                        ),
                      ),
                      SizedBox(height: 16.0),
                      TextFormField(
                        controller: _alamatController,
                        decoration: InputDecoration(
                          labelText: 'Alamat',
                        ),
                      ),
                      SizedBox(height: 16.0),
                      TextFormField(
                        controller: _mottoController,
                        decoration: InputDecoration(
                          labelText: 'Motto',
                        ),
                      ),
                      SizedBox(height: 16.0),
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                        ),
                      ),
                      SizedBox(height: 16.0),
                      TextFormField(
                        controller: _adminController,
                        decoration: InputDecoration(
                          labelText: 'Admin Toko',
                        ),
                      ),
                      SizedBox(height: 16.0),
                      ElevatedButton(
                        style: ButtonStyle(
                            padding:
                                MaterialStatePropertyAll(EdgeInsets.all(10)),
                            backgroundColor:
                                MaterialStatePropertyAll(primaryColor)),
                        onPressed: () async {
                          // Simpan perubahan profil
                          String nama = _namaController.text;
                          String alamat = _alamatController.text;
                          String motto = _mottoController.text;
                          String email = _emailController.text;
                          String admin = _adminController.text;
                          String id = currentUser!.uid.toString();
                          print(id);
                          final collectionRef =
                              FirebaseFirestore.instance.collection('toko');

                          // Melakukan pembaruan data menggunakan klausa 'where'
                          await collectionRef
                              .where('idtoko',
                                  isEqualTo: currentUser!.uid.toString())
                              .get()
                              .then((QuerySnapshot querySnapshot) {
                            querySnapshot.docs
                                .forEach((DocumentSnapshot docSnapshot) {
                              // Mendapatkan referensi ke dokumen yang ingin diperbarui
                              final documentRef =
                                  collectionRef.doc(docSnapshot.id);

                              // Melakukan pembaruan data
                              documentRef.update({
                                'namatoko': nama,
                                'alamat': alamat,
                                'mottotoko': motto,
                                'email': email,
                                'adminToko': admin,
                                'urlImage': urlGambar
                              }).then((value) {
                                print('Data berhasil diperbarui!');
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Profil berhasil diperbarui'),
                                  ),
                                );

                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomePage(
                                            laman: 3,
                                          )),
                                );
                                // Navigator.pop(context);
                              }).catchError((error) {
                                print(
                                    'Terjadi kesalahan saat memperbarui data: $error');
                              });
                            });
                          });

                          // Lakukan sesuatu dengan data yang telah disimpan
                          // ...

                          // Tampilkan snackbar atau pindah ke halaman lain
                        },
                        child: Text('Simpan'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
