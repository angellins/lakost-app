import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

class LaporanKendalaScreen extends StatefulWidget {
  const LaporanKendalaScreen({super.key});

  @override
  State<LaporanKendalaScreen> createState() => _LaporanKendalaScreenState();
}

class _LaporanKendalaScreenState extends State<LaporanKendalaScreen> {
  final _deskripsiController = TextEditingController();
  bool _fotoAdded = false;

  @override
  void dispose() {
    _deskripsiController.dispose();
    super.dispose();
  }

  void _kirimLaporan() {
    if (_deskripsiController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Mohon jelaskan kendala kamu terlebih dahulu.',
            style: GoogleFonts.poppins(color: AppTheme.white),
          ),
          backgroundColor: Colors.red.shade600,
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          'Laporan Terkirim',
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.w700, color: AppTheme.textDark),
        ),
        content: Text(
          'Laporan kendala kamu sudah kami terima. Tim kami akan segera menindaklanjuti.',
          style: GoogleFonts.poppins(color: AppTheme.textGrey, fontSize: 13),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryBlue,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            child: Text(
              'OK',
              style: GoogleFonts.poppins(
                  color: AppTheme.white, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
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
                      'Laporan Kendala',
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Detail Kost Card ──
                  Text(
                    'Detail Kost',
                    style: GoogleFonts.poppins(
                      color: AppTheme.textDark,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: AppTheme.white,
                      borderRadius: BorderRadius.circular(14),
                      border:
                          Border.all(color: Colors.grey.shade200),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            width: 70,
                            height: 60,
                            color: AppTheme.primaryBlue.withOpacity(0.15),
                            child: Icon(
                              Icons.home_rounded,
                              color: AppTheme.primaryBlue,
                              size: 32,
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Kost Asri Putra',
                                style: GoogleFonts.poppins(
                                  color: AppTheme.textDark,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                'Putra - kamar 01',
                                style: GoogleFonts.poppins(
                                  color: AppTheme.textGrey,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Booking : 3 April 2026',
                                style: GoogleFonts.poppins(
                                  color: AppTheme.textGrey,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // ── Deskripsi Kendala ──
                  Text(
                    'Deskripsi Kedala',
                    style: GoogleFonts.poppins(
                      color: AppTheme.textDark,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      color: AppTheme.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: TextField(
                      controller: _deskripsiController,
                      maxLines: 6,
                      style: GoogleFonts.poppins(
                          color: AppTheme.textDark, fontSize: 13),
                      decoration: InputDecoration(
                        hintText: 'Jelaskan Kendala Anda di sini...',
                        hintStyle: GoogleFonts.poppins(
                            color: AppTheme.textGrey, fontSize: 13),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.all(14),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // ── Upload Foto ──
                  Text(
                    'Upload Foto Kendala',
                    style: GoogleFonts.poppins(
                      color: AppTheme.textDark,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () => setState(() => _fotoAdded = !_fotoAdded),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      height: 130,
                      decoration: BoxDecoration(
                        color: _fotoAdded
                            ? AppTheme.accentCyan.withOpacity(0.08)
                            : Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: _fotoAdded
                              ? AppTheme.accentCyan
                              : Colors.grey.shade300,
                          style: BorderStyle.solid,
                        ),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              _fotoAdded
                                  ? Icons.check_circle_rounded
                                  : Icons.add_rounded,
                              size: 36,
                              color: _fotoAdded
                                  ? AppTheme.accentCyan
                                  : Colors.grey.shade500,
                            ),
                            const SizedBox(height: 6),
                            Text(
                              _fotoAdded ? 'Foto Ditambahkan' : 'Tambah Foto',
                              style: GoogleFonts.poppins(
                                color: _fotoAdded
                                    ? AppTheme.accentCyan
                                    : Colors.grey.shade500,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  // ── Kirim Laporan Button ──
                  GestureDetector(
                    onTap: _kirimLaporan,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        gradient: AppTheme.primaryGradient,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.primaryBlue.withOpacity(0.3),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Text(
                        'Kirim Laporan',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          color: AppTheme.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
