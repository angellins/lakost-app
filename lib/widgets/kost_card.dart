import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

class KostCard extends StatelessWidget {
  final Map<String, dynamic> data;

  const KostCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final List<String> facilities =
        List<String>.from(data['facilities'] ?? []);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryBlue.withOpacity(0.08),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {},
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              child: Stack(
                children: [
                  Image.asset(
                    'assets/images/house_bg.png',
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  // Type badge
                  Positioned(
                    top: 12,
                    left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 5),
                      decoration: BoxDecoration(
                        gradient: AppTheme.accentGradient,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        data['type'] ?? '',
                        style: GoogleFonts.poppins(
                          color: AppTheme.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  // Favorite button
                  Positioned(
                    top: 10,
                    right: 12,
                    child: InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: const EdgeInsets.all(7),
                        decoration: BoxDecoration(
                          color: AppTheme.white.withOpacity(0.9),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.favorite_border_rounded,
                          color: Colors.redAccent,
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Info
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name + rating
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          data['name'] ?? '',
                          style: GoogleFonts.poppins(
                            color: AppTheme.textDark,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Row(
                        children: [
                          const Icon(
                            Icons.star_rounded,
                            color: AppTheme.accentGold,
                            size: 16,
                          ),
                          const SizedBox(width: 3),
                          Text(
                            '${data['rating']}',
                            style: GoogleFonts.poppins(
                              color: AppTheme.textDark,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 5),

                  // Address
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_rounded,
                        color: AppTheme.accentCyan,
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          data['address'] ?? '',
                          style: GoogleFonts.poppins(
                            color: AppTheme.textGrey,
                            fontSize: 12,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // Facilities
                  Wrap(
                    spacing: 8,
                    runSpacing: 6,
                    children: facilities
                        .map((f) => Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: AppTheme.accentCyan.withOpacity(0.10),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                f,
                                style: GoogleFonts.poppins(
                                  color: AppTheme.accentCyan,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ))
                        .toList(),
                  ),

                  const SizedBox(height: 14),

                  // Price + CTA
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Mulai dari',
                            style: GoogleFonts.poppins(
                              color: AppTheme.textGrey,
                              fontSize: 11,
                            ),
                          ),
                          Text(
                            'Rp ${data['price']}/bln',
                            style: GoogleFonts.poppins(
                              color: AppTheme.primaryBlue,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {},
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18, vertical: 10),
                          decoration: BoxDecoration(
                            gradient: AppTheme.primaryGradient,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: AppTheme.primaryBlue.withOpacity(0.3),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Text(
                            'Lihat Detail',
                            style: GoogleFonts.poppins(
                              color: AppTheme.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
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
  }
}
