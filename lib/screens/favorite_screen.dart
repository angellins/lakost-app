import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../widgets/kost_card.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  static const List<Map<String, dynamic>> _favoriteKost = [
    {
      'name': 'Kost Mewah Surabaya',
      'address': 'Jl. Raya Darmo No. 12, Surabaya',
      'price': '1.500.000',
      'type': 'Putra',
      'rating': 4.8,
      'image': 'house_bg',
      'facilities': ['WiFi', 'AC', 'Parkir'],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.softWhite,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
              decoration: const BoxDecoration(
                gradient: AppTheme.headerGradient,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(28),
                  bottomRight: Radius.circular(28),
                ),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.favorite_rounded,
                    color: Colors.redAccent,
                    size: 26,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Favorit Saya',
                    style: GoogleFonts.poppins(
                      color: AppTheme.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),

            // List
            Expanded(
              child: _favoriteKost.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.favorite_border_rounded,
                            size: 64,
                            color: AppTheme.textGrey.withOpacity(0.4),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Belum ada favorit',
                            style: GoogleFonts.poppins(
                              color: AppTheme.textGrey,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
                      itemCount: _favoriteKost.length,
                      itemBuilder: (_, i) => KostCard(data: _favoriteKost[i]),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
