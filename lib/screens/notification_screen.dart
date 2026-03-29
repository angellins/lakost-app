import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  static const List<Map<String, dynamic>> _notifs = [
    {
      'title': 'Kost baru di Lamongan!',
      'body': 'Ada kost baru yang cocok dengan pencarianmu di Lamongan.',
      'time': '5 menit lalu',
      'read': false,
    },
    {
      'title': 'Promo Bulan Ini',
      'body': 'Dapatkan diskon 10% untuk kost pilihan bulan ini.',
      'time': '1 jam lalu',
      'read': false,
    },
    {
      'title': 'Pencarian tersimpan',
      'body': 'Pencarian "Kost Putri Lamongan" telah disimpan.',
      'time': 'Kemarin',
      'read': true,
    },
    {
      'title': 'Selamat datang di laKost!',
      'body': 'Temukan kost impianmu dengan mudah bersama laKost.',
      'time': '2 hari lalu',
      'read': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.softWhite,
      body: Column(
        children: [
          // Header
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
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                child: Row(
                  children: [
                    const Icon(Icons.notifications_rounded,
                        color: AppTheme.accentCyan, size: 26),
                    const SizedBox(width: 12),
                    Text(
                      'Notifikasi',
                      style: GoogleFonts.poppins(
                        color: AppTheme.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
              itemCount: _notifs.length,
              itemBuilder: (_, i) => _NotifItem(data: _notifs[i]),
            ),
          ),
        ],
      ),
    );
  }
}

class _NotifItem extends StatelessWidget {
  final Map<String, dynamic> data;
  const _NotifItem({required this.data});

  @override
  Widget build(BuildContext context) {
    final bool isRead = data['read'] as bool;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: isRead ? AppTheme.white : AppTheme.accentCyan.withOpacity(0.06),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isRead ? Colors.transparent : AppTheme.accentCyan.withOpacity(0.2),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: isRead
                      ? AppTheme.textGrey.withOpacity(0.08)
                      : AppTheme.accentCyan.withOpacity(0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.notifications_rounded,
                  color: isRead ? AppTheme.textGrey : AppTheme.accentCyan,
                  size: 20,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            data['title'],
                            style: GoogleFonts.poppins(
                              color: AppTheme.textDark,
                              fontSize: 13,
                              fontWeight: isRead ? FontWeight.w500 : FontWeight.w700,
                            ),
                          ),
                        ),
                        if (!isRead)
                          Container(
                            width: 8, height: 8,
                            decoration: const BoxDecoration(
                              color: AppTheme.accentCyan,
                              shape: BoxShape.circle,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      data['body'],
                      style: GoogleFonts.poppins(
                        color: AppTheme.textGrey,
                        fontSize: 12,
                        height: 1.4,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      data['time'],
                      style: GoogleFonts.poppins(
                        color: AppTheme.textGrey.withOpacity(0.6),
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
