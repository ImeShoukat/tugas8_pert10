# Toko Kita
```
Imedia Sholem Shoukat
H1D023088
Shift KRS   : Shift C
Shift Baru  : Shift D
```

## Pages
### 1. Login Page `login_page.dart`
Halaman autentikasi pengguna.

#### Penjelasan Kode
- Menggunakan `GlobalKey<FormState>` untuk memvalidasi input sebelum memproses login.
- `TextFormField` dikustomisasi menggunakan `InputDecoration` agar memiliki background abu-abu gelap dan border hijau saat aktif (fokus).
![Login page](asset/login.png)


### 2. Registrasi Page `registrasi.dart`
Halaman untuk pendaftar [pengguna baru]

#### Penjelasan Kode
- Menggunakan logika `if (value != _passwordTextboxController.text)` pada validator konfirmasi password.
- Menggunakan setState untuk mengubah status tombol menjadi indikator `loading (CircularProgressIndicator)` saat ditekan.
![Registrasi Page](asset/registrasi.png)

### 3. Produk Page `produk_page.dart`
Halaman utama (Dashboard) yang menampilkan daftar semua produk.

#### Penjelasan Kode
- Menggunakan widget `GestureDetector` pada setiap item list untuk mendeteksi ketukan (tap) yang akan mengarahkan user ke halaman Detail Produk.

![list produk](asset/home.png)
![side bar](asset/home-sidebar.png)


### 4. Detail Page `produk_detail.dart`
Halaman yang menampilkan informasi lengkap dari satu produk yang dipilih.

#### Penjelasan Kode
- Menerapkan pengecekan `if (widget.produk == null)` untuk mencegah aplikasi crash (layar merah) jika data produk gagal dimuat.
- Menggunakan `Navigator.pop` berulang untuk menutup dialog dan kembali ke halaman list setelah penghapusan.

![detail page](asset/detail.png)
![hapus produk page](asset/apus%20produk.png)

### 5. Produk Form `produk_form.dart`
Halaman formulir yang bersifat reusable (dapat digunakan kembali) untuk dua fungsi: Menambah Produk Baru dan Mengedit Produk Lama.

#### Penjelasan Kode
- Menggunakan widget `GestureDetector` pada setiap item list untuk mendeteksi ketukan (tap) yang akan mengarahkan user ke halaman Detail Produk.

![form tambah](asset/form%20tambah.png)
![form ubah](asset/form%20ubah%20prduk.png)
