import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../widgets/kost_card_grid.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  String _query = '';
  int _selectedFilter = 0;

  final List<String> _filters = ['Tersedia', 'Putri', 'Campuran'];

  final List<Map<String, dynamic>> _allKost = [
    {'name': 'Kos Asri Putra', 'address': 'Jl. Pelajar, Lamongan', 'price': '500.000', 'type': 'Putra'},
    {'name': 'Kos Asri Putra', 'address': 'Jl. Pelajar, Lamongan', 'price': '500.000', 'type': 'Putri'},
    {'name': 'Kos Asri Putra', 'address': 'Jl. Pelajar, Lamongan', 'price': '500.000', 'type': 'Campur'},
    {'name': 'Kos Asri Putra', 'address': 'Jl. Pelajar, Lamongan', 'price': '500.000', 'type': 'Putra'},
    {'name': 'Kos Asri Putra', 'address': 'Jl. Pelajar, Lamongan', 'price': '500.000', 'type': 'Putri'},
    {'name': 'Kos Asri Putra', 'address': 'Jl. Pelajar, Lamongan', 'price': '500.000', 'type': 'Campur'},
  ];

  List<Map<String, dynamic>> get _filtered {
    List<Map<String, dynamic>> result = _allKost;

    // Filter by search query
    if (_query.isNotEmpty) {
      result = result
          .where((k) =>
              k['name'].toLowerCase().contains(_query.toLowerCase()) ||
              k['address'].toLowerCase().contains(_query.toLowerCase()))
          .toList();
    }

    // Filter by chip
    if (_selectedFilter == 1) {
      result = result.where((k) => k['type'] == 'Putri').toList();
    } else if (_selectedFilter == 2) {
      result = result.where((k) => k['type'] == 'Campur').toList();
    }

    return result;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      'Cari Kost',
                      style: GoogleFonts.poppins(
                        color: AppTheme.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Search field
                    Container(
                      decoration: BoxDecoration(
                        color: AppTheme.white,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 12,
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: _controller,
                        onChanged: (val) => setState(() => _query = val),
                        style: GoogleFonts.poppins(
                          color: AppTheme.textDark,
                          fontSize: 14,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Cari kos di Lamongan...',
                          hintStyle: GoogleFonts.poppins(
                            color: AppTheme.textGrey,
                            fontSize: 14,
                          ),
                          prefixIcon: const Icon(
                            Icons.search_rounded,
                            color: AppTheme.accentCyan,
                          ),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Filter chips
                    Wrap(
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
                  ],
                ),
              ),
            ),
          ),

          // ── Results ──
          Expanded(
            child: _filtered.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search_off_rounded,
                            size: 64,
                            color: AppTheme.textGrey.withOpacity(0.35)),
                        const SizedBox(height: 12),
                        Text(
                          'Kost tidak ditemukan',
                          style: GoogleFonts.poppins(
                            color: AppTheme.textGrey,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 20, 16, 100),
                    physics: const BouncingScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.82,
                    ),
                    itemCount: _filtered.length,
                    itemBuilder: (_, i) => KostCardGrid(data: _filtered[i]),
                  ),
          ),
        ],
      ),
    );
  }
}
