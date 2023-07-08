import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool visibilitas = false;
  var statusLog = " ";
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _errorMessage = '';
  String gagal = " ";
  String keteranganGagal = " ";

  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
        // title: Text('Login'),
      // ),
      body: 
      Container(
        color: Color.fromRGBO(33, 64, 100, 1),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  transformAlignment: Alignment.center,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      //color: Color.fromRGBO(33, 64, 100, 1)
                      ),
                  child: Visibility(
                      visible: visibilitas,
                      child: SizedBox(
                        height: 50,
                        width: 300,
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                statusLog,
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      )),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text('LOGIN',
                
              style: TextStyle(
                fontSize: 50,
                color: Colors.white,
              ),
              ),
              SizedBox(height: 70.0),
              Image.asset(
                "assets/image/kasir.png",
                height: 150,
                width: 150,
                ),
                SizedBox(height: 30.0),

              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  fillColor: Colors.white, 
                  // Mengubah warna latar belakang TextField
                  filled: true,
                  border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)), 
                  ),
                  labelText: 'E-mail',
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  fillColor: Colors.white, 
                  // Mengubah warna latar belakang TextField
                  filled: true,
                  border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)), 
                  ),
                  labelText: 'Password',
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _login,
                child: Text('Login'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(150, 50),
                  primary: Colors.amber,
                )
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(onTap: (){
                   Navigator.pushReplacementNamed(context, '/register');
              },
              child: Text(
                "Belum punya akun?",
                
              style: TextStyle(
                color: Colors.white,
              ),
              ),
              )
            ],
          ),
        ),
      ),
    );
  }

  //simpan status login

  Future<void> _saveLoginStatus(bool isLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', isLoggedIn);
  }

  //validasi Login
  Future<bool> _performLoginValidation() async {
    // Lakukan validasi login sesuai dengan kebutuhan aplikasi Anda
    // Misalnya, periksa username dan password dengan panggilan API atau dalam basis data
    // String email = _usernameController.text;
    // String password = _passwordController.text;

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _usernameController.text,
        password: _passwordController.text,
      );
      User? user = userCredential.user;
      return true;
      // Login berhasil, lakukan tindakan yang diperlukan setelah login sukses
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.message.toString() ==
          'An unknown error occurred: FirebaseError: Firebase: The email address is badly formatted. (auth/invalid-email).') {
        setState(() {
          _errorMessage = 'User not found';
          gagal = "Email belum terdaftar";
          keteranganGagal = "Coba pastikan email benar";
        });
      } else if (e.message.toString() ==
          'An unknown error occurred: FirebaseError: Firebase: The password is invalid or the user does not have a password. (auth/wrong-password).') {
        setState(() {
          gagal = "Password Salah";
          keteranganGagal = "Cek password kembali";
          _errorMessage = 'Wrong password';
        });
      } else if (_usernameController.text == " ") {
        statusLog = "Username Wajib Diisi";
        visibilitas = true;
      }
      return false;
    }
  }

  //fungsi login

  Future<void> _login() async {
    // Simulasikan proses validasi login
    if (_usernameController.text != "" && _passwordController.text != "") {
      setState(() {
        visibilitas = false;
      });
      bool isLoggedIn = await _performLoginValidation();
      if (isLoggedIn) {
        // Simpan status login jika berhasil
        await _saveLoginStatus(true);
        // Navigasi ke halaman beranda
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Login Berhasil"),
              content: Text("Mantap Kak"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(gagal),
              content: Text(keteranganGagal),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } else if (_usernameController.text == "" &&
        _passwordController.text != "") {
      setState(() {
        statusLog = "Username Wajib Diisi";
        visibilitas = true;
      });
    } else if (_passwordController.text == "" &&
        _usernameController.text != "") {
      setState(() {
        statusLog = "Password Wajib Diisi";
        visibilitas = true;
      });
    } else if (_usernameController.text == "" &&
        _passwordController.text == "") {
      setState(() {
        statusLog = "Username & Password Wajib Diisi";
        visibilitas = true;
      });
    }
  }
}
