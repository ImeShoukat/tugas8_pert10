import 'package:flutter/material.dart';
import 'package:tokokita/bloc/login_bloc.dart';
import 'package:tokokita/helpers/user_info.dart';
import 'package:tokokita/ui/produk_page.dart';
import 'package:tokokita/ui/registrasi_page.dart';
import 'package:tokokita/widget/warning_dialog.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // --- WARNA BACKGROUND (HITAM PEKAT) ---
      backgroundColor: const Color(0xFF121212), 
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
                  // --- JUDUL HALAMAN ---
                  const Text(
                    "Log in",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white, // Teks Putih
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -1.0,
                    ),
                  ),
                  const SizedBox(height: 40),
                  
                  // --- INPUT EMAIL ---
                  _emailTextField(),
                  const SizedBox(height: 16),
                  
                  // --- INPUT PASSWORD ---
                  _passwordTextField(),
                  const SizedBox(height: 32),
                  
                  // --- TOMBOL LOGIN (HIJAU) ---
                  _buttonLogin(),
                  const SizedBox(height: 24),
                  
                  // --- LINK REGISTRASI ---
                  _menuRegistrasi(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _emailTextField() {
    return TextFormField(
      style: const TextStyle(color: Colors.white), // Ketikan teks warna putih
      decoration: InputDecoration(
        labelText: "Email",
        labelStyle: const TextStyle(color: Colors.grey),
        filled: true,
        // Warna isian textbox (Abu Gelap)
        fillColor: const Color(0xFF282828), 
        contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        // Border saat diklik (Hijau)
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Color(0xFF1DB954), width: 2.0),
        ),
      ),
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

  Widget _passwordTextField() {
    return TextFormField(
      style: const TextStyle(color: Colors.white), // Ketikan teks warna putih
      decoration: InputDecoration(
        labelText: "Password",
        labelStyle: const TextStyle(color: Colors.grey),
        filled: true,
        // Warna isian textbox (Abu Gelap)
        fillColor: const Color(0xFF282828), 
        contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        // Border saat diklik (Hijau)
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Color(0xFF1DB954), width: 2.0),
        ),
      ),
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

  Widget _buttonLogin() {
    return SizedBox(
      height: 55,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          // --- WARNA TOMBOL (HIJAU SPOTIFY) ---
          backgroundColor: const Color(0xFF1DB954), 
          // Jika Flutter versi lama error di 'backgroundColor', ganti jadi 'primary'
          
          shape: const StadiumBorder(),
          elevation: 0,
        ),
        child: _isLoading 
          ? const CircularProgressIndicator(color: Colors.white)
          : const Text(
              "LOG IN",
              style: TextStyle(
                color: Colors.black, // Teks Hitam
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

    LoginBloc.login(
      email: _emailTextboxController.text,
      password: _passwordTextboxController.text,
    ).then((value) async {
        if (value.code == 200) {
          await UserInfo().setToken(value.token.toString());
          if (value.userId != null) {
            await UserInfo().setUserID(int.parse(value.userId.toString()));
          }

          if (!mounted) return;
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const ProdukPage()),
          );
        } else {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) => const WarningDialog(
              description: "Login gagal, silahkan coba lagi",
            ),
          );
        }
      },
      onError: (error) {
        print(error);
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => const WarningDialog(
            description: "Login gagal, silahkan coba lagi",
          ),
        );
      },
    ).whenComplete(() {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  Widget _menuRegistrasi() {
    return Center(
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const RegistrasiPage()),
          );
        },
        child: RichText(
          text: const TextSpan(
            text: "Don't have an account? ",
            style: TextStyle(color: Colors.grey),
            children: [
              TextSpan(
                text: "Sign up",
                style: TextStyle(
                  color: Colors.white, // Teks Link Putih
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}