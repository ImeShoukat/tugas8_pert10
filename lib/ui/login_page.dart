import 'package:flutter/material.dart';
import 'package:tokokita/ui/registrasi_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  final _emailTextboxController = TextEditingController();
  final _passwordTextboxController = TextEditingController();

  // Warna Khas Spotify
  final Color _spotifyGreen = const Color(0xFF1DB954);
  final Color _spotifyBlack = const Color(0xFF121212);
  final Color _spotifyDarkGrey = const Color(0xFF282828);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _spotifyBlack, // Background Hitam
      appBar: AppBar(
        title: const Text(
          'Login',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: _spotifyBlack, // AppBar Hitam
        elevation: 0, // Hilangkan bayangan
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 20),
                // Logo Icon (Opsional, biar makin mirip)
                Icon(Icons.music_note, size: 80, color: _spotifyGreen),
                const SizedBox(height: 40),
                
                _emailTextField(),
                const SizedBox(height: 16),
                _passwordTextField(),
                const SizedBox(height: 40),
                _buttonLogin(),
                const SizedBox(height: 30),
                _menuRegistrasi()
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Styles untuk Input Field agar rounded dan gelap
  InputDecoration _spotifyInputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.grey), // Label abu-abu
      filled: true,
      fillColor: _spotifyDarkGrey, // Background kolom input abu-abu gelap
      contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide.none, // Hilangkan garis border saat diam
        borderRadius: BorderRadius.circular(30), // Rounded banget
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: _spotifyGreen, width: 2), // Garis hijau saat diklik
        borderRadius: BorderRadius.circular(30),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.red),
        borderRadius: BorderRadius.circular(30),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.red),
        borderRadius: BorderRadius.circular(30),
      ),
    );
  }

  // Membuat Textbox email
  Widget _emailTextField() {
    return TextFormField(
      style: const TextStyle(color: Colors.white), // Teks input putih
      decoration: _spotifyInputDecoration("Email"),
      cursorColor: _spotifyGreen, // Kursor warna hijau
      keyboardType: TextInputType.emailAddress,
      controller: _emailTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Email harus diisi';
        }
        return null;
      },
    );
  }

  // Membuat Textbox password
  Widget _passwordTextField() {
    return TextFormField(
      style: const TextStyle(color: Colors.white),
      decoration: _spotifyInputDecoration("Password"),
      cursorColor: _spotifyGreen,
      keyboardType: TextInputType.text,
      obscureText: true,
      controller: _passwordTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Password harus diisi";
        }
        return null;
      },
    );
  }

  // Membuat Tombol Login
  Widget _buttonLogin() {
    return SizedBox(
      width: double.infinity, // Lebar full
      child: ElevatedButton(
        child: const Text(
          "LOG IN",
          style: TextStyle(
            color: Colors.black, // Teks tombol hitam agar kontras dengan hijau
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: _spotifyGreen, // Warna Hijau Spotify
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: const StadiumBorder(), // Bentuk kapsul (Rounded)
        ),
        onPressed: () {
          var validate = _formKey.currentState!.validate();
          if (validate) {
            // Logika login nanti di sini
          }
        },
      ),
    );
  }

  // Membuat menu untuk membuka halaman registrasi
  Widget _menuRegistrasi() {
    return Center(
      child: Column(
        children: [
          const Text(
            "Don't have an account?",
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 5),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RegistrasiPage()));
            },
            child: Text(
              "SIGN UP FOR TOKOKITA",
              style: TextStyle(
                color: Colors.white, // Teks putih terang
                fontWeight: FontWeight.bold,
                letterSpacing: 1.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}