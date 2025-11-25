import 'package:flutter/material.dart';

class RegistrasiPage extends StatefulWidget {
  const RegistrasiPage({Key? key}) : super(key: key);
  @override
  _RegistrasiPageState createState() => _RegistrasiPageState();
}

class _RegistrasiPageState extends State<RegistrasiPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  
  final _namaTextboxController = TextEditingController();
  final _emailTextboxController = TextEditingController();
  final _passwordTextboxController = TextEditingController();
  final _passwordKonfirmasiTextboxController = TextEditingController(); 

  final Color _spotifyBlack = const Color(0xFF121212);
  final Color _spotifyDarkGrey = const Color(0xFF282828);
  final Color _spotifyGreen = const Color(0xFF1DB954);
  final Color _spotifyTextGrey = const Color(0xFFB3B3B3);

  InputDecoration _spotifyDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: _spotifyTextGrey),
      filled: true,
      fillColor: _spotifyDarkGrey, 
      
      contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(30),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: _spotifyGreen, width: 2),
        borderRadius: BorderRadius.circular(30),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.redAccent),
        borderRadius: BorderRadius.circular(30),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.redAccent),
        borderRadius: BorderRadius.circular(30),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _spotifyBlack, 
      appBar: AppBar(
        title: const Text(
          "Buat Akun - Ime",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: _spotifyBlack,
        iconTheme: const IconThemeData(color: Colors.white), 
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                const Text(
                  "Sign up for free to start listening.",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                
                _namaTextField(),
                const SizedBox(height: 16),
                _emailTextField(),
                const SizedBox(height: 16),
                _passwordTextField(),
                const SizedBox(height: 16),
                _passwordKonfirmasiTextField(),
                const SizedBox(height: 40),
                _buttonRegistrasi(),
                
                const SizedBox(height: 30),
                // Text login option
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Udah punya Akun? ", style: TextStyle(color: _spotifyTextGrey)),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Text("Log in", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _namaTextField() {
    return TextFormField(
      style: const TextStyle(color: Colors.white),
      decoration: _spotifyDecoration("Nama Lengkap"),
      cursorColor: _spotifyGreen,
      keyboardType: TextInputType.text,
      controller: _namaTextboxController,
      validator: (value) {
        if (value!.length < 3) {
          return "Nama harus diisi minimal 3 karakter";
        }
        return null;
      },
    );
  }

  Widget _emailTextField() {
    return TextFormField(
      style: const TextStyle(color: Colors.white),
      decoration: _spotifyDecoration("Email"),
      cursorColor: _spotifyGreen,
      keyboardType: TextInputType.emailAddress,
      controller: _emailTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Email harus diisi';
        }
        Pattern pattern =
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
        RegExp regex = RegExp(pattern.toString());
        if (!regex.hasMatch(value)) {
          return "Email tidak valid";
        }
        return null;
      },
    );
  }

  Widget _passwordTextField() {
    return TextFormField(
      style: const TextStyle(color: Colors.white),
      decoration: _spotifyDecoration("Password"),
      cursorColor: _spotifyGreen,
      keyboardType: TextInputType.text,
      obscureText: true,
      controller: _passwordTextboxController,
      validator: (value) {
        if (value!.length < 6) {
          return "Password harus diisi minimal 6 karakter";
        }
        return null;
      },
    );
  }

  Widget _passwordKonfirmasiTextField() {
    return TextFormField(
      style: const TextStyle(color: Colors.white),
      decoration: _spotifyDecoration("Konfirmasi Password"),
      cursorColor: _spotifyGreen,
      keyboardType: TextInputType.text,
      obscureText: true,
      controller: _passwordKonfirmasiTextboxController, 
      validator: (value) {
        if (value != _passwordTextboxController.text) {
          return "Konfirmasi Password tidak sama";
        }
        return null;
      },
    );
  }

  Widget _buttonRegistrasi() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: _spotifyGreen,
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: const StadiumBorder(),
        ),
        child: _isLoading 
          ? const SizedBox(
              height: 20, width: 20, 
              child: CircularProgressIndicator(color: Colors.black, strokeWidth: 2)
            )
          : const Text(
              "SIGN UP",
              style: TextStyle(
                color: Colors.black, 
                fontWeight: FontWeight.bold,
                fontSize: 16,
                letterSpacing: 1.2
              ),
            ),
        onPressed: () {
          var validate = _formKey.currentState!.validate();
          if (validate && !_isLoading) {
            setState(() {
              _isLoading = true;
            });

            Future.delayed(const Duration(seconds: 2), () {
              if (!mounted) return;
              setState(() {
                _isLoading = false;
              });
            
              ScaffoldMessenger.of(context).showSnackBar(
                 SnackBar(
                  content: const Text("Registrasi Berhasil! Silakan Login."),
                  backgroundColor: _spotifyGreen,
                  behavior: SnackBarBehavior.floating,
                ),
              );
              Navigator.pop(context); 
            });
          }
        },
      ),
    );
  }
}