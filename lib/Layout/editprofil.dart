import 'package:flutter/material.dart';

class EditProfil extends StatefulWidget {
  const EditProfil({Key? key}) : super(key: key);

  @override
  _EditProfilState createState() => _EditProfilState();
}

class _EditProfilState extends State<EditProfil> {
  TextEditingController _namaController = TextEditingController();
  TextEditingController _alamatController = TextEditingController();
  TextEditingController _visiController = TextEditingController();
  TextEditingController _misiController = TextEditingController();
  TextEditingController _contactController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profil'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
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
              controller: _visiController,
              decoration: InputDecoration(
                labelText: 'Visi',
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _misiController,
              decoration: InputDecoration(
                labelText: 'Misi',
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _contactController,
              decoration: InputDecoration(
                labelText: 'Contact',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Simpan perubahan profil
                String nama = _namaController.text;
                String alamat = _alamatController.text;
                String visi = _visiController.text;
                String misi = _misiController.text;
                String contact = _contactController.text;

                // Lakukan sesuatu dengan data yang telah disimpan
                // ...

                // Tampilkan snackbar atau pindah ke halaman lain
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Profil berhasil diperbarui'),
                  ),
                );
              },
              child: Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}
