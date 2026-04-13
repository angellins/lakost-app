import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

class BookingHistoryScreen extends StatelessWidget {
  const BookingHistoryScreen({super.key});

  static const List<Map<String, dynamic>> _riwayat = [
    {
      'nama': 'Kost Asri Putra',
      'tipe': 'Putra',
      'kamar': 'Kamar 01',
      'tanggal': '3 April 2026',
      'status': 'Aktif',
      'harga': '500.000',
    },
    {
      'nama': 'Kost Melati Putri',
      'tipe': 'Putri',
      'kamar': 'Kamar 03',
      'tanggal': '1 Februari 2026',
      'status': 'Selesai',
      'harga': '450.000',
    },
    {
      'nama': 'Kost Barokah',
      'tipe': 'Campur',
      'kamar': 'Kamar 05',
      'tanggal': '15 April 2026',
      'status': 'Dibatalkan',
      'harga': '400.000',
    },
  ];

  Color _statusColor(String status) {
    switch (status) {
      case 'Aktif':
        return const Color(0xFF43A047);
      case 'Selesai':
        return AppTheme.accentCyan;
      case 'Dibatalkan':
        return Colors.red.shade400;
      default:
        return AppTheme.textGrey;
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
                      'Riwayat Booking',
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

          // ── List ──
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
              itemCount: _riwayat.length,
              itemBuilder: (_, i) {
                final item = _riwayat[i];
                return Container(
                  margin: const EdgeInsets.only(bottom: 14),
                  decoration: BoxDecoration(
                    color: AppTheme.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Icon kost
                        Container(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            color: AppTheme.primaryBlue.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(Icons.home_rounded,
                              color: AppTheme.primaryBlue, size: 28),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      item['nama'],
                                      style: GoogleFonts.poppins(
                                        color: AppTheme.textDark,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 3),
                                    decoration: BoxDecoration(
                                      color: _statusColor(item['status'])
                                          .withOpacity(0.12),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      item['status'],
                                      style: GoogleFonts.poppins(
                                        color: _statusColor(item['status']),
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${item['tipe']} · ${item['kamar']}',
                                style: GoogleFonts.poppins(
                                  color: AppTheme.textGrey,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    item['tanggal'],
                                    style: GoogleFonts.poppins(
                                      color: AppTheme.textGrey,
                                      fontSize: 11,
                                    ),
                                  ),
                                  Text(
                                    'Rp ${item['harga']}/bln',
                                    style: GoogleFonts.poppins(
                                      color: AppTheme.primaryBlue,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
