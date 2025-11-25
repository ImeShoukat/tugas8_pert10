import 'package:flutter/material.dart';
import 'package:tokokita/model/produk.dart';
import 'package:tokokita/ui/produk_detail.dart';
import 'package:tokokita/ui/produk_form.dart';

class ProdukPage extends StatefulWidget {
  const ProdukPage({Key? key}) : super(key: key);

  @override
  _ProdukPageState createState() => _ProdukPageState();
}

class _ProdukPageState extends State<ProdukPage> {
  final Color _spotifyBlack = const Color(0xFF121212);
  final Color _spotifyDarkGrey = const Color(0xFF282828);
  final Color _spotifyGreen = const Color(0xFF1DB954);
  final Color _spotifyLightGrey = const Color(0xFFB3B3B3);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _spotifyBlack, 
      appBar: AppBar(
        backgroundColor: _spotifyBlack, 
        elevation: 0,
        title: const Text(
          'List Produk - Ime',
          style: TextStyle(
            color: Colors.white, 
            fontWeight: FontWeight.bold,
            fontSize: 24
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white), 
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              child: Icon(Icons.add_circle_outline, size: 30.0, color: _spotifyGreen), 
              onTap: () async {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProdukForm()));
              },
            ),
          )
        ],
      ),
      drawer: Drawer(
        backgroundColor: _spotifyBlack,
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: _spotifyDarkGrey),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                   Icon(Icons.account_circle, size: 50, color: _spotifyLightGrey),
                   const SizedBox(height: 10),
                   const Text(
                     "Ime ayee",
                     style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                   ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.logout, color: _spotifyLightGrey),
              title: const Text('Logout', style: TextStyle(color: Colors.white)),
              onTap: () async {
              },
            )
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            "Recently Added",
            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          ItemProduk(
            produk: Produk(
              id: '1',
              kodeProduk: 'A001',
              namaProduk: 'Kamera DSLR',
              hargaProduk: 5000000,
            ),
          ),
          ItemProduk(
            produk: Produk(
              id: '2',
              kodeProduk: 'A002',
              namaProduk: 'Kulkas 2 Pintu',
              hargaProduk: 2500000,
            ),
          ),
          ItemProduk(
            produk: Produk(
              id: '3',
              kodeProduk: 'A003',
              namaProduk: 'Mesin Cuci',
              hargaProduk: 2000000,
            ),
          ),
        ],
      ),
    );
  }
}

class ItemProduk extends StatelessWidget {
  final Produk produk;
  const ItemProduk({Key? key, required this.produk}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color _cardColor = const Color(0xFF282828);
    final Color _greenColor = const Color(0xFF1DB954);
    final Color _textColor = const Color(0xFFFFFFFF);
    final Color _subTextColor = const Color(0xFFB3B3B3);

    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProdukDetail(
                      produk: produk,
                    )));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12), 
        decoration: BoxDecoration(
          color: _cardColor, 
          borderRadius: BorderRadius.circular(8), 
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
         
          leading: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.grey[800], 
              borderRadius: BorderRadius.circular(4),
              gradient: LinearGradient(
                colors: [Colors.grey[800]!, Colors.black],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight
              )
            ),
            child: const Icon(Icons.inventory_2, color: Colors.white70),
          ),
          title: Text(
            produk.namaProduk!,
            style: TextStyle(
              color: _textColor, 
              fontWeight: FontWeight.w600,
              fontSize: 16
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Text(
              "Rp. ${produk.hargaProduk.toString()}",
              style: TextStyle(
                color: _greenColor, 
                fontWeight: FontWeight.w500
              ),
            ),
          ),
          trailing: Icon(Icons.more_vert, color: _subTextColor), 
        ),
      ),
    );
  }
}