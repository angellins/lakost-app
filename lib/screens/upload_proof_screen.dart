import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart'; // Untuk format tanggal Indonesia
import '../theme/app_theme.dart';

class UploadProofScreen extends StatefulWidget {
  const UploadProofScreen({super.key});

  @override
  State<UploadProofScreen> createState() => _UploadProofScreenState();
}

class _UploadProofScreenState extends State<UploadProofScreen> {
  // Variabel untuk menyimpan gambar (Mobile & Web)
  File? _imageFile; // Untuk Mobile/Android
  Uint8List? _webImage; // Untuk Web (Edge/Chrome)
  String? _fileName; // Nama file untuk ditampilkan

  // Fungsi untuk mengambil gambar dari galeri
  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80, // Kompres sedikit agar tidak terlalu berat
    );

    if (pickedFile != null) {
      if (kIsWeb) {
        // Logika khusus Web
        final bytes = await pickedFile.readAsBytes();
        setState(() {
          _webImage = bytes;
          _imageFile = null; // Pastikan file mobile kosong
          _fileName = pickedFile.name;
        });
      } else {
        // Logika khusus Mobile
        setState(() {
          _imageFile = File(pickedFile.path);
          _webImage = null; // Pastikan data web kosong
          _fileName = pickedFile.name;
        });
      }
    }
  }

  // Fungsi untuk menghapus gambar yang dipilih
  void _removeImage() {
    setState(() {
      _imageFile = null;
      _webImage = null;
      _fileName = null;
    });
  }

  // Fungsi saat tombol "Upload Bukti Sekarang" diklik
  void _submitData() {
    if (_imageFile == null && _webImage == null) {
      // Validasi jika belum ada gambar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Mohon upload bukti transfer terlebih dahulu",
            style: GoogleFonts.poppins(fontSize: 12),
          ),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(20),
        ),
      );
      return;
    }

    // JIKA BERHASIL: Tampilkan Pop-up (Dialog) Sukses sesuai Figma
    _showSuccessDialog();
  }

  // ===== WIDGET POP-UP (DIALOG) SUKSES SESUAI FIGMA =====
  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false, // User tidak bisa klik luar untuk menutup
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          elevation: 0,
          backgroundColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
            child: Column(
              mainAxisSize: MainAxisSize.min, // Dialog mengikuti tinggi konten
              children: [
                // Ikon Ceklis Hijau Besar
                Container(
                  width: 100,
                  height: 100,
                  decoration: const BoxDecoration(
                    color: Color(0xFFE8F5E9), // Hijau sangat muda
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.check_circle,
                      color: Color(0xFF4CAF50), // Hijau Sukses
                      size: 80,
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                // Teks "Pembayaran Berhasil!"
                Text(
                  "Pembayaran Berhasil!",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 10),

                // Teks Keterangan
                Text(
                  "Pembayaran kostmu sudah berhasil",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 35),

                // Tombol "Selesai" (Gradient sesuai standard)
                Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    gradient: AppTheme.headerGradient, // Gradient Blue
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF1e3a8a).withOpacity(0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      )
                    ],
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(); // tutup dialog

                      Navigator.of(context).popUntil((route) => route.isFirst);
                    },
                    child: Text(
                      "Selesai",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Format tanggal hari ini (Dummy, sesuaikan jika perlu data transaksi asli)
    String formattedDate =
        DateFormat('dd MMM yyyy | HH:mm:ss', 'id').format(DateTime.now());

    return Scaffold(
      backgroundColor: AppTheme.softWhite,
      // Gunakan SafeArea agar konten tidak tertutup status bar di mobile,
      // tapi tetap full screen di web.
      body: SafeArea(
        top: kIsWeb ? false : true, // Di web jangan pakai safearea top
        bottom: false,
        child: Column(
          children: [
            // ===== HEADER GRADIENT SESUAI FIGMA =====
            _buildHeader(context),

            // ===== CONTENT AREA (SCROLLABLE & FULL WIDTH) =====
            Expanded(
              child: SingleChildScrollView(
                // Padding luar container putih
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 30),
                child: Container(
                  width: double.infinity, // Paksa lebar penuh
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Judul Status
                      Center(
                        child: Text(
                          "Pembayaran Menunggu Konfirmasi",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),

                      // ===== BOX AREA UPLOAD =====
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.grey.shade200),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "Kirim Bukti Transfer",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 15),

                            // Dropzone / Preview Area
                            GestureDetector(
                              onTap: _pickImage,
                              child: Container(
                                height:
                                    200, // Sedikit lebih tinggi agar preview jelas
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.blue.shade50.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color:
                                        AppTheme.primaryBlue.withOpacity(0.3),
                                    style: BorderStyle
                                        .solid, // Bisa diganti Dashed jika pakai package ekstra
                                    width: 2,
                                  ),
                                ),
                                child: _buildImagePreview(),
                              ),
                            ),

                            const SizedBox(height: 12),

                            // Nama File & Tombol Hapus (Jika sudah upload)
                            if (_fileName != null)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                        color: Colors.grey.shade200)),
                                child: Row(
                                  children: [
                                    const Icon(Icons.description_outlined,
                                        size: 16, color: Colors.grey),
                                    const SizedBox(width: 6),
                                    Expanded(
                                      child: Text(
                                        _fileName!,
                                        style: GoogleFonts.poppins(
                                            fontSize: 11,
                                            color: Colors.grey.shade700),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: _removeImage,
                                      icon: const Icon(Icons.cancel,
                                          color: Colors.redAccent, size: 18),
                                      padding: EdgeInsets.zero,
                                      constraints: const BoxConstraints(),
                                    )
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 25),

                      // Teks Keterangan Waktu Validasi
                      Center(
                        child: Text(
                          "Admin akan memvalidasi pembayaran Anda dalam waktu maksimal 24 jam",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Colors.black54,
                            height: 1.5,
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),

                      // ===== TOMBOL AKSI DI BAWAH KONTEN =====
                      _buildActionButton(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- WIDGET HELPER ---

  // Header Gradient + Tombol Back
  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: AppTheme.headerGradient, // Gunakan gradient biru standard
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
            8, 20, 16, 25), // Sesuaikan padding agar full screen
        child: Row(
          children: [
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios_rounded,
                  color: Colors.white, size: 20),
            ),
            Expanded(
              child: Text(
                "Konfirmasi & Bukti Transfer",
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Preview Gambar (Logika Hybrid Web/Mobile)
  Widget _buildImagePreview() {
    if (kIsWeb && _webImage != null) {
      // Tampilan Preview di Web (Edge)
      return ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.memory(_webImage!, fit: BoxFit.cover),
      );
    } else if (_imageFile != null) {
      // Tampilan Preview di Mobile (Android/iOS)
      return ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.file(_imageFile!, fit: BoxFit.cover),
      );
    } else {
      // Tampilan Awal (Belum Upload)
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.cloud_upload_outlined,
              size: 48, color: AppTheme.primaryBlue),
          const SizedBox(height: 10),
          Text(
            "Upload Bukti Transfer",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: AppTheme.primaryBlue,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "Pilih file (JPG, PNG, maks 5MB)",
            style: GoogleFonts.poppins(
              fontSize: 11,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      );
    }
  }

  // Tombol Utama (Gradient) & Tombol Batal
  Widget _buildActionButton() {
    return Column(
      children: [
        // Tombol Upload (Gradient)
        Container(
          width: double.infinity,
          height: 55,
          decoration: BoxDecoration(
            gradient: AppTheme.headerGradient, // Gradient Blue standard
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF1e3a8a).withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 4),
              )
            ],
          ),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            onPressed: _submitData, // Panggil fungsi submit
            child: Text(
              "Upload Bukti Sekarang",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w700,
                fontSize: 15,
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        // Tombol Batal (Abu-abu)
        SizedBox(
          width: double.infinity,
          height: 55,
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.grey.shade200, // Abu-abu sesuai Figma
              side: BorderSide.none, // Tanpa border
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            onPressed: () => Navigator.pop(context),
            child: Text(
              "Batal",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 15,
                color: Colors.black87,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
