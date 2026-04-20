import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart'; // <--- Pastikan library ini sudah di pub get
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_theme.dart';
import 'booking_screen.dart';

class DetailKostScreen extends StatefulWidget {
  final Map<String, dynamic> data;
  const DetailKostScreen({super.key, required this.data});

  @override
  State<DetailKostScreen> createState() => _DetailKostScreenState();
}

class _DetailKostScreenState extends State<DetailKostScreen> {
  int currentIndex = 0;

  final List<String> images = [
    'assets/images/house_bg.png',
    'assets/images/house_bg.png',
    'assets/images/house_bg.png',
  ];

  // Inisialisasi koordinat
  late LatLng location;

  @override
  void initState() {
    super.initState();
    // Ambil data lat lng dari widget.data, atau gunakan default Lamongan
    final double lat = widget.data['latitude'] ?? -7.1147; 
    final double lng = widget.data['longitude'] ?? 112.4168;
    location = LatLng(lat, lng);
  }

  void openWA() async {
    final url = Uri.parse("https://wa.me/6281330799798");
    if (!await launchUrl(url)) {
      debugPrint("Gagal membuka WhatsApp");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.softWhite,
      body: Column(
        children: [
          // Header
          _buildHeader(context),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
              child: Container(
                decoration: BoxDecoration(
                  color: AppTheme.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 12),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildImageSlider(),
                      const SizedBox(height: 20),
                      Text("Informasi Utama", style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 16)),
                      const SizedBox(height: 10),
                      _buildTypeChip(),
                      const SizedBox(height: 14),
                      _item("Harga", "Rp ${widget.data['price']}/Bulan"),
                      _item("Alamat", widget.data['address'] ?? "Alamat tidak tersedia"),
                      const SizedBox(height: 12),
                      Text("Fasilitas", style: GoogleFonts.poppins(fontWeight: FontWeight.w700)),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [_chip("Wi-Fi"), _chip("Kasur"), _chip("Meja"), _chip("Listrik")],
                      ),
                      const SizedBox(height: 14),
                      Text("Deskripsi", style: GoogleFonts.poppins(fontWeight: FontWeight.w700)),
                      const SizedBox(height: 6),
                      Text(
                        "Kost nyaman dan strategis di area Lamongan, dekat dengan kampus dan fasilitas umum.",
                        style: GoogleFonts.poppins(fontSize: 13, color: Colors.grey[700]),
                      ),
                      const SizedBox(height: 20),
                      
                      // MAP SECTION
                      Text("Lokasi kos", style: GoogleFonts.poppins(fontWeight: FontWeight.w700)),
                      const SizedBox(height: 8),
                      _buildMap(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNav(context),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: AppTheme.headerGradient,
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(28), bottomRight: Radius.circular(28)),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 16, 20),
          child: Row(
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.white, size: 20),
              ),
              Expanded(
                child: Text(
                  "Detail Kost - ${widget.data['name']}",
                  style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageSlider() {
    return Column(
      children: [
        SizedBox(
          height: 180,
          child: PageView.builder(
            itemCount: images.length,
            onPageChanged: (index) => setState(() => currentIndex = index),
            itemBuilder: (context, index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(images[index], fit: BoxFit.cover),
              );
            },
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(images.length, (i) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 3),
              width: currentIndex == i ? 16 : 6,
              height: 6,
              decoration: BoxDecoration(
                color: currentIndex == i ? AppTheme.primaryBlue : Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildMap() {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: FlutterMap(
          options: MapOptions(
            initialCenter: location,
            initialZoom: 15.0,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.lakost.app',
            ),
            MarkerLayer(
              markers: [
                Marker(
                  point: location,
                  width: 40,
                  height: 40,
                  child: const Icon(Icons.location_on_rounded, color: Colors.red, size: 40),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNav(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        color: AppTheme.white,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), offset: const Offset(0, -4), blurRadius: 10)],
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                side: const BorderSide(color: AppTheme.primaryBlue),
              ),
              onPressed: openWA,
              icon: const Icon(Icons.chat, size: 18, color: AppTheme.primaryBlue),
              label: Text("Tanya Pemilik", style: GoogleFonts.poppins(color: AppTheme.primaryBlue, fontWeight: FontWeight.w600)),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryBlue,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 0,
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => BookingScreen(data: widget.data)));
              },
              icon: const Icon(Icons.calendar_today, size: 18),
              label: Text("Booking", style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypeChip() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: AppTheme.primaryBlue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.primaryBlue),
      ),
      child: Text(
        widget.data['type'] ?? 'Putra',
        style: GoogleFonts.poppins(color: AppTheme.primaryBlue, fontWeight: FontWeight.w600, fontSize: 12),
      ),
    );
  }

  Widget _item(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 13, color: Colors.grey[600])),
          const SizedBox(height: 2),
          Text(value, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _chip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(color: Colors.blue[50], borderRadius: BorderRadius.circular(10)),
      child: Text(text, style: GoogleFonts.poppins(fontSize: 12, color: AppTheme.primaryBlue, fontWeight: FontWeight.w500)),
    );
  }
}