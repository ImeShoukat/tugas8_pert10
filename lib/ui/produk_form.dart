import 'package:flutter/material.dart';
import 'package:tokokita/model/produk.dart';

// ignore: must_be_immutable
class ProdukForm extends StatefulWidget {
  Produk? produk;
  ProdukForm({Key? key, this.produk}) : super(key: key);

  @override
  _ProdukFormState createState() => _ProdukFormState();
}

class _ProdukFormState extends State<ProdukForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String judul = "TAMBAH PRODUK";
  String tombolSubmit = "SIMPAN";

  final _kodeProdukTextboxController = TextEditingController();
  final _namaProdukTextboxController = TextEditingController();
  final _hargaProdukTextboxController = TextEditingController();

  // Warna Khas Spotify
  final Color _spotifyBlack = const Color(0xFF121212);
  final Color _spotifyDarkGrey = const Color(0xFF282828);
  final Color _spotifyGreen = const Color(0xFF1DB954);
  final Color _spotifyTextGrey = const Color(0xFFB3B3B3);

  @override
  void initState() {
    super.initState();
    isUpdate();
  }

  isUpdate() {
    if (widget.produk != null) {
      setState(() {
        judul = "UBAH PRODUK";
        tombolSubmit = "UBAH";
        _kodeProdukTextboxController.text = widget.produk!.kodeProduk!;
        _namaProdukTextboxController.text = widget.produk!.namaProduk!;
        _hargaProdukTextboxController.text =
            widget.produk!.hargaProduk.toString();
      });
    } else {
      judul = "TAMBAH PRODUK";
      tombolSubmit = "SIMPAN";
    }
  }

  // Helper untuk styling Input Field ala Spotify
  InputDecoration _spotifyDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: _spotifyTextGrey),
      filled: true,
      fillColor: _spotifyDarkGrey, // Background input abu-abu
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(8),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: _spotifyGreen, width: 2), // Hijau saat aktif
        borderRadius: BorderRadius.circular(8),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.redAccent),
        borderRadius: BorderRadius.circular(8),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.redAccent),
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _spotifyBlack, // Background Hitam
      appBar: AppBar(
        backgroundColor: _spotifyBlack,
        title: Text(
          judul,
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _kodeProdukTextField(),
                const SizedBox(height: 16), // Jarak antar elemen
                _namaProdukTextField(),
                const SizedBox(height: 16),
                _hargaProdukTextField(),
                const SizedBox(height: 30),
                _buttonSubmit()
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Membuat Textbox Kode Produk
  Widget _kodeProdukTextField() {
    return TextFormField(
      style: const TextStyle(color: Colors.white), // Teks putih
      decoration: _spotifyDecoration("Kode Produk"),
      cursorColor: _spotifyGreen,
      keyboardType: TextInputType.text,
      controller: _kodeProdukTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Kode Produk harus diisi";
        }
        return null;
      },
    );
  }

  // Membuat Textbox Nama Produk
  Widget _namaProdukTextField() {
    return TextFormField(
      style: const TextStyle(color: Colors.white),
      decoration: _spotifyDecoration("Nama Produk"),
      cursorColor: _spotifyGreen,
      keyboardType: TextInputType.text,
      controller: _namaProdukTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Nama Produk harus diisi";
        }
        return null;
      },
    );
  }

  // Membuat Textbox Harga Produk
  Widget _hargaProdukTextField() {
    return TextFormField(
      style: const TextStyle(color: Colors.white),
      decoration: _spotifyDecoration("Harga"),
      cursorColor: _spotifyGreen,
      keyboardType: TextInputType.number,
      controller: _hargaProdukTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Harga harus diisi";
        }
        return null;
      },
    );
  }

  // Membuat Tombol Simpan/Ubah
  Widget _buttonSubmit() {
    return SizedBox(
      width: double.infinity, // Tombol selebar layar
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: _spotifyGreen, // Warna Hijau Spotify
          foregroundColor: Colors.black, // Teks Hitam (Kontras)
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: const StadiumBorder(), // Bentuk kapsul
        ),
        child: _isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(color: Colors.black),
              )
            : Text(
                tombolSubmit,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
        onPressed: () {
          var validate = _formKey.currentState!.validate();
          if (validate && !_isLoading) {
            // Logika Simpan (Simulasi)
            setState(() {
              _isLoading = true;
            });

            // Simulasi delay jaringan 2 detik
            Future.delayed(const Duration(seconds: 2), () {
              if (!mounted) return; // Cek widget masih aktif
              
              Navigator.pop(context); // Kembali ke halaman sebelumnya
              
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("$judul Berhasil (Simulasi)"),
                  backgroundColor: _spotifyGreen,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            });
          }
        },
      ),
    );
  }
}