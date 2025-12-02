import 'package:flutter/material.dart';
import 'package:tokokita/model/produk.dart';
import 'package:tokokita/bloc/produk_bloc.dart';
import 'package:tokokita/ui/produk_page.dart';
import 'package:tokokita/widget/warning_dialog.dart';

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

  // Warna Dark Mode (Spotify Style)
  final Color _spotifyGreen = const Color(0xFF1DB954);
  final Color _darkBackground = const Color(0xFF121212);
  final Color _inputFillColor = const Color(0xFF282828);

  @override
  void initState() {
    super.initState();
    isUpdate();
  }

  void isUpdate() {
    if (widget.produk != null) {
      setState(() {
        judul = "UBAH PRODUK";
        tombolSubmit = "UPDATE";
        _kodeProdukTextboxController.text = widget.produk!.kodeProduk ?? '';
        _namaProdukTextboxController.text = widget.produk!.namaProduk ?? '';
        _hargaProdukTextboxController.text = widget.produk!.hargaProduk != null 
            ? widget.produk!.hargaProduk.toString() 
            : '';
      });
    } else {
      judul = "TAMBAH PRODUK";
      tombolSubmit = "SIMPAN";
    }
  }

  @override
  void dispose() {
    _kodeProdukTextboxController.dispose();
    _namaProdukTextboxController.dispose();
    _hargaProdukTextboxController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _darkBackground,
      appBar: AppBar(
        title: Text(judul, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _kodeProdukTextField(),
                const SizedBox(height: 16),
                _namaProdukTextField(),
                const SizedBox(height: 16),
                _hargaProdukTextField(),
                const SizedBox(height: 40),
                _buttonSubmit(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _customInputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.grey),
      filled: true,
      fillColor: _inputFillColor,
      contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide(color: _spotifyGreen, width: 2.0)),
    );
  }

  Widget _kodeProdukTextField() {
    return TextFormField(
      style: const TextStyle(color: Colors.white),
      decoration: _customInputDecoration('Kode Produk'),
      keyboardType: TextInputType.text,
      controller: _kodeProdukTextboxController,
      validator: (value) {
        // PERBAIKAN PENTING: Cek null dulu biar gak error TypeError di Web
        if (value == null || value.trim().isEmpty) {
          return 'Kode Produk harus diisi';
        }
        return null;
      },
    );
  }

  Widget _namaProdukTextField() {
    return TextFormField(
      style: const TextStyle(color: Colors.white),
      decoration: _customInputDecoration('Nama Produk'),
      keyboardType: TextInputType.text,
      controller: _namaProdukTextboxController,
      validator: (value) {
        // PERBAIKAN PENTING
        if (value == null || value.trim().isEmpty) {
          return 'Nama Produk harus diisi';
        }
        return null;
      },
    );
  }

  Widget _hargaProdukTextField() {
    return TextFormField(
      style: const TextStyle(color: Colors.white),
      decoration: _customInputDecoration('Harga (Rp)'),
      keyboardType: TextInputType.number,
      controller: _hargaProdukTextboxController,
      validator: (value) {
        // PERBAIKAN PENTING
        if (value == null || value.trim().isEmpty) {
          return 'Harga harus diisi';
        }
        if (int.tryParse(value) == null) {
          return 'Harga harus berupa angka';
        }
        return null;
      },
    );
  }

  Widget _buttonSubmit() {
    return SizedBox(
      height: 55,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: _spotifyGreen,
          shape: const StadiumBorder(),
          elevation: 0,
        ),
        child: _isLoading 
          ? const CircularProgressIndicator(color: Colors.white)
          : Text(
              tombolSubmit,
              style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
            ),
        onPressed: () {
          var validate = _formKey.currentState!.validate();
          if (validate) {
            if (!_isLoading) {
              if (widget.produk != null) {
                ubah();
              } else {
                simpan();
              }
            }
          }
        },
      ),
    );
  }

  void simpan() {
    setState(() { _isLoading = true; });
    
    Produk createProduk = Produk(id: null);
    createProduk.kodeProduk = _kodeProdukTextboxController.text;
    createProduk.namaProduk = _namaProdukTextboxController.text;
    createProduk.hargaProduk = int.parse(_hargaProdukTextboxController.text);
    
    ProdukBloc.addProduk(produk: createProduk).then((value) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => const ProdukPage()),
          (Route<dynamic> route) => false,
        );
      }, onError: (error) {
        showDialog(
          context: context,
          builder: (BuildContext context) => const WarningDialog(description: "Simpan gagal, silahkan coba lagi"),
        );
      },
    ).whenComplete(() {
      if (mounted) setState(() { _isLoading = false; });
    });
  }

  void ubah() {
    setState(() { _isLoading = true; });
    
    Produk updateProduk = Produk(id: widget.produk!.id!);
    updateProduk.kodeProduk = _kodeProdukTextboxController.text;
    updateProduk.namaProduk = _namaProdukTextboxController.text;
    updateProduk.hargaProduk = int.parse(_hargaProdukTextboxController.text);
    
    ProdukBloc.updateProduk(produk: updateProduk).then((value) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => const ProdukPage()),
           (Route<dynamic> route) => false,
        );
      }, onError: (error) {
        showDialog(
          context: context,
          builder: (BuildContext context) => const WarningDialog(description: "Permintaan ubah data gagal, silahkan coba lagi"),
        );
      },
    ).whenComplete(() {
      if (mounted) setState(() { _isLoading = false; });
    });
  }
}