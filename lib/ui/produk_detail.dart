import 'package:flutter/material.dart';
import 'package:tokokita/model/produk.dart';
import 'package:tokokita/ui/produk_form.dart';

class ProdukDetail extends StatefulWidget {
  final Produk? produk; // Gunakan final

  const ProdukDetail({Key? key, this.produk}) : super(key: key);

  @override
  _ProdukDetailState createState() => _ProdukDetailState();
}

class _ProdukDetailState extends State<ProdukDetail> {
  // Palette Warna Spotify
  final Color _spotifyBlack = const Color(0xFF121212);
  final Color _spotifyDarkGrey = const Color(0xFF282828);
  final Color _spotifyGreen = const Color(0xFF1DB954);
  final Color _spotifyTextGrey = const Color(0xFFB3B3B3);

  @override
  Widget build(BuildContext context) {
    // Pencegahan error jika data null
    if (widget.produk == null) {
      return Scaffold(
        backgroundColor: _spotifyBlack,
        appBar: AppBar(backgroundColor: _spotifyBlack),
        body: const Center(child: Text("Data tidak ditemukan", style: TextStyle(color: Colors.white))),
      );
    }

    return Scaffold(
      backgroundColor: _spotifyBlack, // Background Hitam
      appBar: AppBar(
        title: const Text("Detail Produk", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: _spotifyBlack, // AppBar transparan/hitam
        iconTheme: const IconThemeData(color: Colors.white), // Panah back putih
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center, // Tengah secara horizontal
            children: [
              _buildCoverArt(), // Visualisasi Produk ala Album Art
              const SizedBox(height: 30),
              _buildProductInfo(), // Judul, Harga, Kode
              const SizedBox(height: 40),
              _tombolHapusEdit() // Tombol Aksi
            ],
          ),
        ),
      ),
    );
  }

  // Widget Visualisasi Produk (Kotak Gradasi)
  Widget _buildCoverArt() {
    return Container(
      height: 250,
      width: 250,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [_spotifyDarkGrey, Colors.black],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
        borderRadius: BorderRadius.circular(12), // Sedikit rounded
      ),
      child: Icon(
        Icons.inventory_2_outlined, // Ikon Produk
        size: 100,
        color: _spotifyTextGrey.withOpacity(0.5),
      ),
    );
  }

  // Widget Informasi Teks
  Widget _buildProductInfo() {
    return Column(
      children: [
        // Nama Produk (Judul Lagu)
        Text(
          widget.produk!.namaProduk!,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        // Harga Produk (Artis - Warna Hijau)
        Text(
          "Rp. ${widget.produk!.hargaProduk.toString()}",
          style: TextStyle(
            fontSize: 20.0,
            color: _spotifyGreen,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        // Kode Produk (Info Tambahan - Abu-abu)
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: _spotifyDarkGrey,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            "CODE: ${widget.produk!.kodeProduk}",
            style: TextStyle(
              fontSize: 12.0,
              color: _spotifyTextGrey,
              letterSpacing: 1.5,
            ),
          ),
        ),
      ],
    );
  }

  Widget _tombolHapusEdit() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Tombol Edit (Primary - Hijau)
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: _spotifyGreen,
              foregroundColor: Colors.black, // Teks Hitam
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: const StadiumBorder(),
            ),
            child: const Text("EDIT", style: TextStyle(fontWeight: FontWeight.bold)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProdukForm(
                    produk: widget.produk!,
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(width: 16), // Jarak antar tombol
        
        // Tombol Delete (Secondary - Outline Merah/Putih)
        Expanded(
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.redAccent, // Teks Merah
              side: const BorderSide(color: Colors.redAccent), // Border Merah
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: const StadiumBorder(),
            ),
            child: const Text("DELETE", style: TextStyle(fontWeight: FontWeight.bold)),
            onPressed: () => confirmHapus(),
          ),
        ),
      ],
    );
  }

  void confirmHapus() {
    // Dialog Tema Gelap
    AlertDialog alertDialog = AlertDialog(
      backgroundColor: _spotifyDarkGrey, // Background dialog abu-abu gelap
      title: const Text("Hapus Produk?", style: TextStyle(color: Colors.white)),
      content: Text(
        "Yakin ingin menghapus '${widget.produk!.namaProduk}'? Tindakan ini tidak dapat dibatalkan.",
        style: TextStyle(color: _spotifyTextGrey),
      ),
      actions: [
        // Tombol Batal
        TextButton(
          child: const Text("Batal", style: TextStyle(color: Colors.white)),
          onPressed: () => Navigator.pop(context),
        ),
        // Tombol Ya (Hapus)
        TextButton(
          child: const Text("Hapus", style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold)),
          onPressed: () {
            Navigator.pop(context); // Tutup dialog
            
            // Tampilkan notifikasi
            ScaffoldMessenger.of(context).showSnackBar(
               SnackBar(
                content: const Text("Data berhasil dihapus (Simulasi)"),
                backgroundColor: _spotifyGreen, // Snackbar hijau
                behavior: SnackBarBehavior.floating,
              ),
            );
            
            Navigator.pop(context); // Kembali ke list
          },
        ),
      ],
    );

    showDialog(builder: (context) => alertDialog, context: context);
  }
}