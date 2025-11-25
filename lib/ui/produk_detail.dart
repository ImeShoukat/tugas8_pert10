import 'package:flutter/material.dart';
import 'package:tokokita/model/produk.dart';
import 'package:tokokita/ui/produk_form.dart';

class ProdukDetail extends StatefulWidget {
  final Produk? produk; 

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
    if (widget.produk == null) {
      return Scaffold(
        backgroundColor: _spotifyBlack,
        appBar: AppBar(backgroundColor: _spotifyBlack),
        body: const Center(child: Text("Data tidak ditemukan", style: TextStyle(color: Colors.white))),
      );
    }

    return Scaffold(
      backgroundColor: _spotifyBlack, 
      appBar: AppBar(
        title: const Text("Detail Produk - Ime", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: _spotifyBlack,
        iconTheme: const IconThemeData(color: Colors.white), 
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center, 
            children: [
              _buildCoverArt(), 
              const SizedBox(height: 30),
              _buildProductInfo(), 
              const SizedBox(height: 40),
              _tombolHapusEdit() 
            ],
          ),
        ),
      ),
    );
  }

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
        borderRadius: BorderRadius.circular(12), 
      ),
      child: Icon(
        Icons.inventory_2_outlined, // Ikon Produk
        size: 100,
        color: _spotifyTextGrey.withOpacity(0.5),
      ),
    );
  }

  Widget _buildProductInfo() {
    return Column(
      children: [
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
        Text(
          "Rp. ${widget.produk!.hargaProduk.toString()}",
          style: TextStyle(
            fontSize: 20.0,
            color: _spotifyGreen,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
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
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: _spotifyGreen,
              foregroundColor: Colors.black, 
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: const StadiumBorder(),
            ),
            child: const Text("Edit", style: TextStyle(fontWeight: FontWeight.bold)),
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
        const SizedBox(width: 16),

        Expanded(
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.redAccent, 
              side: const BorderSide(color: Colors.redAccent), 
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: const StadiumBorder(),
            ),
            child: const Text("Hapus", style: TextStyle(fontWeight: FontWeight.bold)),
            onPressed: () => confirmHapus(),
          ),
        ),
      ],
    );
  }

  void confirmHapus() {
    AlertDialog alertDialog = AlertDialog(
      backgroundColor: _spotifyDarkGrey, 
      title: const Text("Hapus Produk?", style: TextStyle(color: Colors.white)),
      content: Text(
        "Yakin ingin menghapus '${widget.produk!.namaProduk}'? Tindakan ini tidak dapat dibatalkan.",
        style: TextStyle(color: _spotifyTextGrey),
      ),
      actions: [
        
        TextButton(
          child: const Text("Batal", style: TextStyle(color: Colors.white)),
          onPressed: () => Navigator.pop(context),
        ),
        
        TextButton(
          child: const Text("Hapus", style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold)),
          onPressed: () {
            Navigator.pop(context); 
            
            ScaffoldMessenger.of(context).showSnackBar(
               SnackBar(
                content: const Text("Data berhasil dihapus (Simulasi)"),
                backgroundColor: _spotifyGreen,
                behavior: SnackBarBehavior.floating,
              ),
            );
            
            Navigator.pop(context); 
          },
        ),
      ],
    );

    showDialog(builder: (context) => alertDialog, context: context);
  }
}