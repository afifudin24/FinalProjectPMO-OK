import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'LoginPage.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  Future<void> registerUser(String email, String password) async {
  try {
    await Firebase.initializeApp();
    UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    User? user = userCredential.user;
    Navigator.pushReplacementNamed(context, '/login');
    // Registrasi berhasil, lakukan tindakan lanjutan seperti menyimpan data pengguna ke database, dll.
  } catch (e) {
    // Penanganan kesalahan saat registrasi
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Register"),
      // ),
      body: SingleChildScrollView(
        child: Container(
             color: Color.fromRGBO(33, 64, 100, 1),
             height: MediaQuery.of(context).size.height,
          child: Form(
            key: _formKey,
            child: Center(
              
              child: Container(  
           
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                       Text('REGISTER',
                    
                  style: TextStyle(
                    fontSize: 50,
                    color: Colors.white,
                  ),
                  ),
                  SizedBox(height: 30.0),
                  Center(
                  child: Image.asset(
                    "assets/image/registerr.png",
                    height: 150,
                    width: 150,
                    ),
                  ),
                  SizedBox(height: 40.0),
                      TextFormField(
                        style: TextStyle(
              
                          color: Colors.white,
                          ),
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8), 
                            borderSide: BorderSide(width: 2, style: BorderStyle.solid, color: Colors.white),
              
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8), 
                            borderSide: BorderSide(width: 8, style: BorderStyle.solid, color: Colors.white), // Warna border
                            ),
                          labelStyle: TextStyle(
                            color: Colors.white, // Mengubah warna teks label
                            ),
                            hintStyle: TextStyle(
                              color: Colors.blue, // Mengubah warna teks hint
                              ),
                              focusedBorder: OutlineInputBorder(
                                 borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(color: Colors.blue), // Mengubah warna garis tepi saat mendapatkan fokus
                                ),
                          labelText: 'Email',
                        ),
                      ),
                      SizedBox(height: 30.0),
                      TextFormField(
                        style: TextStyle(
              
                          color: Colors.white,
                          ),
                        controller: _passwordController,
                        obscureText: true,
                        // style: TextStyle(
                        //   color: Colors.white,
                        //   ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8), 
                            borderSide: BorderSide(width: 2, style: BorderStyle.solid, color: Colors.white),
              
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8), 
                            borderSide: BorderSide(width: 8, style: BorderStyle.solid, color: Colors.white), // Warna border
                            ),
                          labelStyle: TextStyle(
                            color: Colors.white, // Mengubah warna teks label
                            ),
                            hintStyle: TextStyle(
                              color: Colors.blue, // Mengubah warna teks hint
                              ),
                              focusedBorder: OutlineInputBorder(
                                 borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(color: Colors.blue), // Mengubah warna garis tepi saat mendapatkan fokus
                                ),
                          labelText: 'Password',
                        ),
                      ),
                      SizedBox(height: 30.0),
                      ElevatedButton(
                        onPressed: () {
                           registerUser(_emailController.text, _passwordController.text);
                        },
                        child: Text('Register'),
                        style: ElevatedButton.styleFrom(
                      minimumSize: Size(120, 50),
                      primary: Colors.amber.shade700,
                    )
                      ),
                      SizedBox(height: 30.0),
                      Center(
                        child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => LoginPage()),
                              );
                            },
                            child: Text("Sudah punya akun ?  Silahkan Login",
                            style: TextStyle(
                              color: Colors.white,
                              ),
                            )),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
    ;
  }
}
