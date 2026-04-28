import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../widgets/kost_card_grid.dart';
import 'kost_list_screen.dart';
import '../services/api_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {

  late AnimationController _headerAnimController;
  late Animation<double> _headerFade;
  late Animation<Offset> _headerSlide;

  List<Map<String, dynamic>> _kostTerdekat = [];
  List<Map<String, dynamic>> _kostRekomendasi = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    _headerAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _headerFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _headerAnimController, curve: Curves.easeOut),
    );

    _headerSlide = Tween<Offset>(
      begin: const Offset(0, -0.12),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _headerAnimController, curve: Curves.easeOut),
    );

    _headerAnimController.forward();

    _fetchKost(); // 🔥 ambil data dari Laravel
  }

  Future<void> _fetchKost() async {
    try {
      final data = await ApiService.getKost();

      setState(() {
        _kostTerdekat = List<Map<String, dynamic>>.from(data);
        _kostRekomendasi = List<Map<String, dynamic>>.from(data);
        isLoading = false;
      });
    } catch (e) {
      print("ERROR API: $e");
      setState(() => isLoading = false);
    }
  }

  @override
  void dispose() {
    _headerAnimController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.softWhite,

      body: isLoading
          ? const Center(child: CircularProgressIndicator())

          // 🔥 INI YANG KAMU TANYA → DIBUNGKUS DI SINI
          : RefreshIndicator(
              onRefresh: _fetchKost,
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [

                  SliverToBoxAdapter(child: _buildHeader()),

                  SliverToBoxAdapter(
                    child: _buildSectionHeader('Kos Terdekat', onTap: () {
                      _goToList(context, 'Kos Terdekat', _kostTerdekat);
                    }),
                  ),

                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                    sliver: SliverGrid(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 0.82,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final k = _kostTerdekat[index];

                          final mapped = {
                            'name': k['nama_kost'],
                            'address': k['wilayah']?['nama_kecamatan'] ?? '-',
                            'price': k['harga'].toString(),
                            'type': k['kategori']?['nama_kategori'] ?? '-',
                          };

                          return KostCardGrid(data: mapped);
                        },
                        childCount: _kostTerdekat.length,
                      ),
                    ),
                  ),

                  SliverToBoxAdapter(
                    child: _buildSectionHeader('Rekomendasi Kos', onTap: () {
                      _goToList(context, 'Rekomendasi Kos', _kostRekomendasi);
                    }),
                  ),

                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
                    sliver: SliverGrid(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 0.82,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final k = _kostRekomendasi[index];

                          final mapped = {
                            'name': k['nama_kost'],
                            'address': k['wilayah']?['nama_kecamatan'] ?? '-',
                            'price': k['harga'].toString(),
                            'type': k['kategori']?['nama_kategori'] ?? '-',
                          };

                          return KostCardGrid(data: mapped);
                        },
                        childCount: _kostRekomendasi.length,
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  void _goToList(
      BuildContext context,
      String title,
      List<Map<String, dynamic>> list) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            KostListScreen(title: title, kostList: list),
        transitionsBuilder:
            (context, animation, secondaryAnimation, child) {
          final slide = Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).animate(
            CurvedAnimation(
                parent: animation, curve: Curves.easeInOut),
          );
          return SlideTransition(position: slide, child: child);
        },
        transitionDuration: const Duration(milliseconds: 350),
      ),
    );
  }

  Widget _buildSectionHeader(String title,
      {required VoidCallback onTap}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              color: AppTheme.textDark,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          GestureDetector(
            onTap: onTap,
            child: Text(
              'Lihat Semua',
              style: GoogleFonts.poppins(
                color: AppTheme.accentCyan,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return FadeTransition(
      opacity: _headerFade,
      child: SlideTransition(
        position: _headerSlide,
        child: Container(
          height: 230,
          decoration:
              const BoxDecoration(gradient: AppTheme.headerGradient),
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  'assets/images/house_bg.png',
                  fit: BoxFit.cover,
                  color: AppTheme.primaryBlue.withOpacity(0.65),
                  colorBlendMode: BlendMode.multiply,
                ),
              ),
              Positioned(
                bottom: 0, left: 0, right: 0, height: 56,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.transparent, AppTheme.softWhite],
                    ),
                  ),
                ),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset('assets/images/logo.png', height: 44),
                      const SizedBox(height: 26),
                      Text(
                        'Hallo! 👋',
                        style: GoogleFonts.poppins(
                          color: AppTheme.white,
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Cari kost terbaik untukmu hari ini',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
