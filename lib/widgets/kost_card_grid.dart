import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

class KostCardGrid extends StatelessWidget {
  final Map<String, dynamic> data;

  const KostCardGrid({super.key, required this.data});

  Color _typeColor(String type) {
    switch (type) {
      case 'Putra':
        return const Color(0xFF1E88E5);
      case 'Putri':
        return const Color(0xFFD81B60);
      case 'Campur':
        return const Color(0xFF43A047);
      default:
        return AppTheme.accentCyan;
    }
  }

  @override
  Widget build(BuildContext context) {
    final type = data['type'] ?? 'Putra';

    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppTheme.primaryBlue.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            Expanded(
              flex: 5,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                    child: Image.asset(
                      'assets/images/house_bg.png',
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Type badge
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: _typeColor(type),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        type,
                        style: GoogleFonts.poppins(
                          color: AppTheme.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Info
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      data['name'] ?? '',
                      style: GoogleFonts.poppins(
                        color: AppTheme.textDark,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      'Rp ${data['price']} /bulan',
                      style: GoogleFonts.poppins(
                        color: AppTheme.primaryBlue,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on_rounded,
                          size: 11,
                          color: AppTheme.accentCyan,
                        ),
                        const SizedBox(width: 2),
                        Expanded(
                          child: Text(
                            data['address'] ?? '',
                            style: GoogleFonts.poppins(
                              color: AppTheme.textGrey,
                              fontSize: 10,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
