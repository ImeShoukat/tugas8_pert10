import 'package:flutter/material.dart';
import 'package:tokokita/bloc/produk_bloc.dart';
import 'package:tokokita/model/produk.dart';
import 'package:tokokita/ui/produk_form.dart';
import 'package:tokokita/ui/produk_page.dart';
import 'package:tokokita/widget/warning_dialog.dart';

// ignore: must_be_immutable
class ProdukDetail extends StatefulWidget {
  Produk? produk;

  ProdukDetail({Key? key, this.produk}) : super(key: key);

  @override
  _ProdukDetailState createState() => _ProdukDetailState();
}

class _ProdukDetailState extends State<ProdukDetail> {
  // Warna Tema
  final Color _spotifyGreen = const Color(0xFF1DB954);
  final Color _darkBackground = const Color(0xFF121212);
  final Color _cardColor = const Color(0xFF282828);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _darkBackground,
      appBar: AppBar(
        title: const Text("Detail Produk", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // --- 1. ICON PRODUK (Ala Cover Album) ---
                _produkIcon(),
                const SizedBox(height: 32),

                // --- 2. INFORMASI PRODUK ---
                Text(
                  widget.produk!.namaProduk ?? "Nama Produk",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Kode: ${widget.produk!.kodeProduk}",
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  "Rp ${widget.produk!.hargaProduk.toString()}", // Pastikan di Model namanya hargaProduk atau harga
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                    color: _spotifyGreen, // Warna Hijau Nyala
                  ),
                ),

                const SizedBox(height: 50),

                // --- 3. TOMBOL AKSI ---
                _tombolHapusEdit(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _produkIcon() {
    return Container(
      height: 180,
      width: 180,
      decoration: BoxDecoration(
        color: _cardColor, // Kotak abu gelap
        borderRadius: BorderRadius.circular(20), // Sudut tumpul
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Icon(
        Icons.inventory_2_outlined, // Ikon barang
        size: 80,
        color: _spotifyGreen,
      ),
    );
  }

  Widget _tombolHapusEdit() {
    return Column(
      children: [
        // Tombol Edit (Hijau Lebar)
        SizedBox(
          width: double.infinity,
          height: 55,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: _spotifyGreen,
              shape: const StadiumBorder(),
            ),
            child: const Text(
              "EDIT PRODUK",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProdukForm(produk: widget.produk!),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        
        // Tombol Hapus (Merah/Outline Lebar)
        SizedBox(
          width: double.infinity,
          height: 55,
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.redAccent, width: 2),
              shape: const StadiumBorder(),
            ),
            child: const Text(
              "DELETE PRODUK",
              style: TextStyle(
                color: Colors.redAccent,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            onPressed: () => confirmHapus(),
          ),
        ),
      ],
    );
  }

  void confirmHapus() {
    // Dialog kustom biar gelap (Dark Mode)
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: _cardColor, // Background Dialog Abu Gelap
        title: const Text("Hapus Produk", style: TextStyle(color: Colors.white)),
        content: const Text(
          "Yakin ingin menghapus data ini? Tindakan ini tidak bisa dibatalkan.",
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            child: const Text("Batal", style: TextStyle(color: Colors.grey)),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: const Text("Hapus", style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold)),
            onPressed: () {
              // Tutup dialog dulu
              Navigator.pop(context); 
              
              // Proses Hapus
              // Pastikan ID dikonversi ke int dengan aman
              int? idHapus;
              if (widget.produk!.id != null) {
                 idHapus = int.tryParse(widget.produk!.id.toString());
              }

              if (idHapus == null) {
                  print("Error: ID Produk null atau tidak valid");
                  return;
              }

              ProdukBloc.deleteProduk(id: idHapus).then((value) {
                  if (!mounted) return;
                  
                  // Kembali ke halaman list (ProdukPage) dan refresh
                  // Menggunakan pushReplacement agar halaman detail hilang dari stack
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const ProdukPage()),
                  );
                },
              ).catchError((error) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => const WarningDialog(
                    description: "Hapus gagal, silahkan coba lagi",
                  ),
                );
              });
            },
          ),
        ],
      ),
    );
  }
}