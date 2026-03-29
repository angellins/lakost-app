import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../widgets/kost_card_grid.dart';

class KostListScreen extends StatefulWidget {
  final String title;
  final List<Map<String, dynamic>> kostList;

  const KostListScreen({
    super.key,
    required this.title,
    required this.kostList,
  });

  @override
  State<KostListScreen> createState() => _KostListScreenState();
}

class _KostListScreenState extends State<KostListScreen> {
  int _selectedFilter = 0;
  final List<String> _filters = ['Semua', 'Putra', 'Putri', 'Campur'];

  List<Map<String, dynamic>> get _filtered {
    if (_selectedFilter == 0) return widget.kostList;
    final typeMap = {1: 'Putra', 2: 'Putri', 3: 'Campur'};
    return widget.kostList
        .where((k) => k['type'] == typeMap[_selectedFilter])
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.softWhite,
      body: Column(
        children: [
          // ── Header ──────────────────────────────────────────
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Back button + title
                    Row(
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(
                            Icons.arrow_back_ios_rounded,
                            color: AppTheme.white,
                            size: 20,
                          ),
                        ),
                        Text(
                          widget.title,
                          style: GoogleFonts.poppins(
                            color: AppTheme.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 14),

                    // Filter chips
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Wrap(
                        spacing: 10,
                        children: List.generate(_filters.length, (index) {
                          final isSelected = index == _selectedFilter;
                          return GestureDetector(
                            onTap: () =>
                                setState(() => _selectedFilter = index),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 220),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 18, vertical: 8),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppTheme.white
                                    : AppTheme.white.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(
                                  color: isSelected
                                      ? AppTheme.white
                                      : AppTheme.white.withOpacity(0.35),
                                ),
                              ),
                              child: Text(
                                _filters[index],
                                style: GoogleFonts.poppins(
                                  color: isSelected
                                      ? AppTheme.primaryBlue
                                      : AppTheme.white,
                                  fontSize: 13,
                                  fontWeight: isSelected
                                      ? FontWeight.w700
                                      : FontWeight.w500,
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // ── Jumlah hasil ──
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
            child: Row(
              children: [
                Text(
                  '${_filtered.length} kost ditemukan',
                  style: GoogleFonts.poppins(
                    color: AppTheme.textGrey,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          // ── Grid List ──
          Expanded(
            child: _filtered.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.home_work_outlined,
                          size: 64,
                          color: AppTheme.textGrey.withOpacity(0.35),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Tidak ada kost untuk filter ini',
                          style: GoogleFonts.poppins(
                            color: AppTheme.textGrey,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
                    physics: const BouncingScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.82,
                    ),
                    itemCount: _filtered.length,
                    itemBuilder: (_, i) =>
                        KostCardGrid(data: _filtered[i]),
                  ),
          ),
        ],
      ),
    );
  }
}