import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

class PusatBantuanScreen extends StatefulWidget {
  const PusatBantuanScreen({super.key});

  @override
  State<PusatBantuanScreen> createState() => _PusatBantuanScreenState();
}

class _PusatBantuanScreenState extends State<PusatBantuanScreen> {
  final _searchController = TextEditingController();

  final List<String> _pertanyaanPopuler = [
    'Cara Booking Kos',
    'Masalah Pembayaran',
    'Kebijakan Pembatalan',
    'Hubungi Pemilik',
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onFaqTap(String item) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            Text(
              item,
              style: GoogleFonts.poppins(
                color: AppTheme.textDark,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              _getFaqContent(item),
              style: GoogleFonts.poppins(
                color: AppTheme.textGrey,
                fontSize: 13,
                height: 1.6,
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  String _getFaqContent(String item) {
    switch (item) {
      case 'Cara Booking Kos':
        return 'Untuk melakukan booking kos, pilih kos yang kamu inginkan, klik tombol "Lihat Detail", lalu tekan "Booking Sekarang". Isi data yang diperlukan dan lakukan pembayaran untuk mengkonfirmasi booking kamu.';
      case 'Masalah Pembayaran':
        return 'Jika mengalami masalah pembayaran, pastikan koneksi internet kamu stabil. Coba beberapa menit kemudian atau hubungi customer service kami melalui WhatsApp atau telepon.';
      case 'Kebijakan Pembatalan':
        return 'Pembatalan booking dapat dilakukan hingga 24 jam sebelum tanggal check-in. Pembatalan yang dilakukan lebih dari 24 jam sebelumnya akan mendapat pengembalian dana penuh.';
      case 'Hubungi Pemilik':
        return 'Kamu dapat menghubungi pemilik kos melalui fitur chat di halaman detail kos, atau menggunakan nomor kontak yang tersedia di profil pemilik.';
      default:
        return 'Informasi tidak tersedia saat ini. Silakan hubungi customer service kami.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.softWhite,
      body: Column(
        children: [
          // ── Header ──
          Container(
            decoration: const BoxDecoration(
              gradient: AppTheme.headerGradient,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(28),
                bottomRight: Radius.circular(28),
              ),
            ),
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(4, 8, 20, 20),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back_ios_rounded,
                          color: AppTheme.white, size: 20),
                    ),
                    Text(
                      'Pusat Bantuan',
                      style: GoogleFonts.poppins(
                        color: AppTheme.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // ── Content ──
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Container(
                decoration: BoxDecoration(
                  color: AppTheme.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Judul ──
                    Center(
                      child: Text(
                        'Punya keluhan?',
                        style: GoogleFonts.poppins(
                          color: AppTheme.textDark,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Center(
                      child: Text(
                        'Jangan Khawatir, kami siap membantu keluhan kamu.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          color: AppTheme.textGrey,
                          fontSize: 12,
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // ── Search bar ──
                    Container(
                      decoration: BoxDecoration(
                        gradient: AppTheme.primaryGradient,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 4),
                      child: Row(
                        children: [
                          const Icon(Icons.search_rounded,
                              color: AppTheme.white, size: 20),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextField(
                              controller: _searchController,
                              style: GoogleFonts.poppins(
                                  color: AppTheme.white, fontSize: 13),
                              decoration: InputDecoration(
                                hintText: 'Cari masalahmu...',
                                hintStyle: GoogleFonts.poppins(
                                  color: AppTheme.white.withOpacity(0.7),
                                  fontSize: 13,
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // ── Pertanyaan Populer ──
                    Text(
                      'Pertanyaan Populer',
                      style: GoogleFonts.poppins(
                        color: AppTheme.textDark,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ..._pertanyaanPopuler.map(
                      (item) => GestureDetector(
                        onTap: () => _onFaqTap(item),
                        child: Container(
                          width: double.infinity,
                          margin: const EdgeInsets.only(bottom: 8),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 12),
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            item,
                            style: GoogleFonts.poppins(
                              color: AppTheme.textDark,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // ── Pusat Bantuan Cepat ──
                    Text(
                      'Pusat Bantuan Cepat ?',
                      style: GoogleFonts.poppins(
                        color: AppTheme.textDark,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // WhatsApp button
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            vertical: 14, horizontal: 20),
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          gradient: AppTheme.primaryGradient,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: const Color(0xFF25D366),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.chat_rounded,
                                  color: Colors.white, size: 18),
                            ),
                            const SizedBox(width: 14),
                            Text(
                              'Chat Customer Service',
                              style: GoogleFonts.poppins(
                                color: AppTheme.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Telepon button
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            vertical: 14, horizontal: 20),
                        decoration: BoxDecoration(
                          gradient: AppTheme.primaryGradient,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: AppTheme.accentCyan,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.phone_rounded,
                                  color: Colors.white, size: 18),
                            ),
                            const SizedBox(width: 14),
                            Text(
                              'Panggil Customer Service',
                              style: GoogleFonts.poppins(
                                color: AppTheme.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
