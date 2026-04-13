import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

class PaymentHistoryScreen extends StatelessWidget {
  const PaymentHistoryScreen({super.key});

  static const List<Map<String, dynamic>> _riwayat = [
    {
      'nama': 'Kost Asri Putra',
      'metode': 'Transfer Bank',
      'tanggal': '3 April 2026',
      'nominal': '500.000',
      'status': 'Berhasil',
      'invoice': 'INV-20260403-001',
    },
    {
      'nama': 'Kost Asri Putra',
      'metode': 'QRIS',
      'tanggal': '3 Maret 2026',
      'nominal': '500.000',
      'status': 'Berhasil',
      'invoice': 'INV-20260303-001',
    },
    {
      'nama': 'Kost Melati Putri',
      'metode': 'E-Wallet',
      'tanggal': '1 Februari 2026',
      'nominal': '450.000',
      'status': 'Berhasil',
      'invoice': 'INV-20260201-002',
    },
    {
      'nama': 'Kost Barokah',
      'metode': 'Transfer Bank',
      'tanggal': '15 April 2026',
      'nominal': '400.000',
      'status': 'Dikembalikan',
      'invoice': 'INV-20260415-003',
    },
  ];

  Color _statusColor(String status) {
    switch (status) {
      case 'Berhasil':
        return const Color(0xFF43A047);
      case 'Dikembalikan':
        return Colors.orange.shade600;
      case 'Gagal':
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
                      'Riwayat Pembayaran',
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

          // ── Summary card ──
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              decoration: BoxDecoration(
                gradient: AppTheme.primaryGradient,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total Pembayaran',
                        style: GoogleFonts.poppins(
                          color: AppTheme.white.withOpacity(0.8),
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        'Rp 1.850.000',
                        style: GoogleFonts.poppins(
                          color: AppTheme.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppTheme.white.withOpacity(0.15),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.account_balance_wallet_outlined,
                        color: AppTheme.white, size: 24),
                  ),
                ],
              ),
            ),
          ),

          // ── List ──
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 100),
              itemCount: _riwayat.length,
              itemBuilder: (_, i) {
                final item = _riwayat[i];
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: AppTheme.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                item['nama'],
                                style: GoogleFonts.poppins(
                                  color: AppTheme.textDark,
                                  fontSize: 13,
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
                        const SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              item['invoice'],
                              style: GoogleFonts.poppins(
                                color: AppTheme.textGrey,
                                fontSize: 11,
                              ),
                            ),
                            Text(
                              item['tanggal'],
                              style: GoogleFonts.poppins(
                                color: AppTheme.textGrey,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Divider(height: 1, color: Colors.grey.shade100),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.payment_outlined,
                                    size: 14, color: AppTheme.accentCyan),
                                const SizedBox(width: 4),
                                Text(
                                  item['metode'],
                                  style: GoogleFonts.poppins(
                                    color: AppTheme.textGrey,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              'Rp ${item['nominal']}',
                              style: GoogleFonts.poppins(
                                color: AppTheme.primaryBlue,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
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
