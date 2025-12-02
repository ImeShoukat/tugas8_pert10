import 'package:flutter/material.dart';
import 'package:tokokita/bloc/registrasi_bloc.dart';
import 'package:tokokita/widget/success_dialog.dart';
import 'package:tokokita/widget/warning_dialog.dart';

class RegistrasiPage extends StatefulWidget {
  const RegistrasiPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RegistrasiPageState createState() => _RegistrasiPageState();
}

class _RegistrasiPageState extends State<RegistrasiPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  
  final _namaTextboxController = TextEditingController();
  final _emailTextboxController = TextEditingController();
  final _passwordTextboxController = TextEditingController();
  // Controller untuk konfirmasi password tidak perlu disimpan di state global jika hanya validasi,
  // tapi untuk konsistensi pembersihan memori, boleh kita buatkan controller juga kalau mau.
  // Di sini saya pakai logic validator langsung akses controller password utama.

  @override
  void dispose() {
    _namaTextboxController.dispose();
    _emailTextboxController.dispose();
    _passwordTextboxController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // --- WARNA BACKGROUND (HITAM) ---
      backgroundColor: const Color(0xFF121212),
      
      // AppBar Transparan biar Back Button warna putih kelihatan elegan
      appBar: AppBar(
        title: const Text("Sign Up", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white), // Panah Back warna putih
      ),
      
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    "Create account",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 40),

                  // --- FORM INPUT ---
                  _namaTextField(),
                  const SizedBox(height: 16),
                  _emailTextField(),
                  const SizedBox(height: 16),
                  _passwordTextField(),
                  const SizedBox(height: 16),
                  _passwordKonfirmasiTextField(),
                  
                  const SizedBox(height: 40),
                  
                  // --- TOMBOL REGISTRASI ---
                  _buttonRegistrasi(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // --- STYLE INPUT SERAGAM (DARK MODE) ---
  InputDecoration _customInputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.grey),
      filled: true,
      fillColor: const Color(0xFF282828), // Abu gelap
      contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(color: Color(0xFF1DB954), width: 2.0), // Hijau Spotify
      ),
      errorStyle: const TextStyle(color: Colors.redAccent),
    );
  }

  Widget _namaTextField() {
    return TextFormField(
      style: const TextStyle(color: Colors.white),
      decoration: _customInputDecoration('Nama'),
      keyboardType: TextInputType.text,
      controller: _namaTextboxController,
      validator: (value) {
        if (value == null || value.trim().length < 3) {
          return 'Nama harus diisi minimal 3 karakter';
        }
        return null;
      },
    );
  }

  Widget _emailTextField() {
    return TextFormField(
      style: const TextStyle(color: Colors.white),
      decoration: _customInputDecoration('Email'),
      keyboardType: TextInputType.emailAddress,
      controller: _emailTextboxController,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Email harus diisi';
        }
        final email = value.trim();
        final regex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}");
        if (!regex.hasMatch(email)) {
          return 'Email tidak valid';
        }
        return null;
      },
    );
  }

  Widget _passwordTextField() {
    return TextFormField(
      style: const TextStyle(color: Colors.white),
      decoration: _customInputDecoration('Password'),
      keyboardType: TextInputType.text,
      obscureText: true,
      controller: _passwordTextboxController,
      validator: (value) {
        if (value == null || value.length < 6) {
          return 'Password harus diisi minimal 6 karakter';
        }
        return null;
      },
    );
  }

  Widget _passwordKonfirmasiTextField() {
    return TextFormField(
      style: const TextStyle(color: Colors.white),
      decoration: _customInputDecoration('Konfirmasi Password'),
      keyboardType: TextInputType.text,
      obscureText: true,
      validator: (value) {
        if (value == null || value != _passwordTextboxController.text) {
          return 'Konfirmasi Password tidak sama';
        }
        return null;
      },
    );
  }

  Widget _buttonRegistrasi() {
    return SizedBox(
      height: 55,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1DB954), // Hijau Spotify
          shape: const StadiumBorder(),
          elevation: 0,
        ),
        child: _isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : const Text(
                "SIGN UP",
                style: TextStyle(
                  color: Colors.black, // Teks Hitam Kontras
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  letterSpacing: 1.5,
                ),
              ),
        onPressed: () {
          var validate = _formKey.currentState!.validate();
          if (validate) {
            if (!_isLoading) _submit();
          }
        },
      ),
    );
  }

  void _submit() {
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });

    RegistrasiBloc.registrasi(
      nama: _namaTextboxController.text,
      email: _emailTextboxController.text,
      password: _passwordTextboxController.text,
    ).then(
      (value) {
        if (value.code == 200 || value.status == true) { // Cek status sukses
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) => SuccessDialog(
              description: "Registrasi berhasil, silahkan login",
              okClick: () {
                Navigator.pop(context); // Tutup dialog
                Navigator.pop(context); // Kembali ke halaman Login
              },
            ),
          );
        } else {
            // Tangkap error dari API (misal email duplikat)
            showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) => WarningDialog(
              description: value.data ?? "Registrasi gagal, silahkan coba lagi",
            ),
          );
        }
      },
      onError: (error) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => const WarningDialog(
            description: "Registrasi gagal, silahkan coba lagi",
          ),
        );
      },
    ).whenComplete(() {
      // Matikan loading SETELAH proses selesai
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }
}