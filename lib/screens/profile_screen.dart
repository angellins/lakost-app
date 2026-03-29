import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.softWhite,
      body: Column(
        children: [
          // Header with avatar
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(bottom: 32),
            decoration: const BoxDecoration(
              gradient: AppTheme.headerGradient,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(32),
                bottomRight: Radius.circular(32),
              ),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  // Avatar
                  Container(
                    width: 88,
                    height: 88,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: AppTheme.accentGradient,
                      border: Border.all(
                        color: AppTheme.accentCyan,
                        width: 3,
                      ),
                    ),
                    child: const Icon(
                      Icons.person_rounded,
                      color: AppTheme.white,
                      size: 44,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Pengguna laKost',
                    style: GoogleFonts.poppins(
                      color: AppTheme.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'pengguna@email.com',
                    style: GoogleFonts.poppins(
                      color: AppTheme.accentCyan.withOpacity(0.9),
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Menu items
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                _buildMenuItem(Icons.person_outline_rounded, 'Edit Profil'),
                _buildMenuItem(Icons.history_rounded, 'Riwayat Pencarian'),
                _buildMenuItem(Icons.notifications_outlined, 'Notifikasi'),
                _buildMenuItem(Icons.help_outline_rounded, 'Bantuan'),
                _buildMenuItem(Icons.info_outline_rounded, 'Tentang Aplikasi'),
                const SizedBox(height: 8),
                _buildMenuItem(
                  Icons.logout_rounded,
                  'Keluar',
                  isDestructive: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String label,
      {bool isDestructive = false}) {
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
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isDestructive
                      ? Colors.red.withOpacity(0.08)
                      : AppTheme.accentCyan.withOpacity(0.10),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  icon,
                  color: isDestructive ? Colors.red : AppTheme.accentCyan,
                  size: 20,
                ),
              ),
              const SizedBox(width: 14),
              Text(
                label,
                style: GoogleFonts.poppins(
                  color: isDestructive ? Colors.red : AppTheme.textDark,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              Icon(
                Icons.chevron_right_rounded,
                color: AppTheme.textGrey.withOpacity(0.4),
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
