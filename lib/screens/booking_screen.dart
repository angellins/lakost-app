import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart'; 
import '../theme/app_theme.dart';
import 'payment_screen.dart';

class BookingScreen extends StatefulWidget {
  final Map<String, dynamic> data;
  const BookingScreen({super.key, required this.data});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  int duration = 1; 
  String selectedRoom = "Kamar 1 (AC, Lemari, Kasur, dll)";
  DateTime selectedDate = DateTime.now().add(const Duration(days: 1));

  // Ambil harga dengan proteksi NULL agar tidak layar merah
  int get pricePerMonth {
    if (widget.data['price'] == null) return 0;
    // Menghapus titik jika ada (misal "1.500.000" -> "1500000")
    String cleanPrice = widget.data['price'].toString().replaceAll('.', '');
    return int.tryParse(cleanPrice) ?? 0;
  }

  int get totalPrice => pricePerMonth * duration;

  String formatRupiah(int number) {
    return NumberFormat.currency(locale: 'id', symbol: '', decimalDigits: 0)
        .format(number);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2027),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(primary: AppTheme.primaryBlue),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() => selectedDate = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.softWhite,
      body: Column(
        children: [
          // HEADER
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
                padding: const EdgeInsets.fromLTRB(8, 8, 16, 20),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.white, size: 20),
                    ),
                    Text("Booking", style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 18)),
                  ],
                ),
              ),
            ),
          ),

          // CONTENT
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 12)],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(widget.data['name'] ?? "Nama Kost", 
                            style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w700)),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset('assets/images/house_bg.png', width: 80, height: 60, fit: BoxFit.cover),
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    _label("Pilih nomor Kamar"),
                    _dropdownInput(["Kamar 1 (AC, Lemari, Kasur, dll)", "Kamar 2", "Kamar 3"], selectedRoom, (val) {
                      setState(() => selectedRoom = val!);
                    }),
                    const SizedBox(height: 16),
                    _label("Pilih Tanggal Masuk"),
                    _datePickerField(),
                    const SizedBox(height: 16),
                    _label("Pilih Durasi Sewa"),
                    _durationDropdown(),
                    const SizedBox(height: 16),
                    _label("Fasilitas"),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8, runSpacing: 8,
                      children: [_fChip(Icons.ac_unit, "AC"), _fChip(Icons.wifi, "Wi-Fi"), _fChip(Icons.bed, "Kasur")],
                    ),
                    const SizedBox(height: 24),
                    _label("Ringkasan Harga"),
                    const SizedBox(height: 10),
                    _priceSummary(),
                    const SizedBox(height: 30),
                    _buildButtons(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _label(String text) => Text(text, style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 13));

  Widget _dropdownInput(List<String> items, String value, Function(String?) onChanged) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(30)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value, isExpanded: true,
          items: items.map((e) => DropdownMenuItem(value: e, child: Text(e, style: const TextStyle(fontSize: 13)))).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _durationDropdown() {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(30)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<int>(
          value: duration, isExpanded: true,
          items: [1, 3, 6, 12].map((e) => DropdownMenuItem(value: e, child: Text("$e Bulan"))).toList(),
          onChanged: (val) => setState(() => duration = val!),
        ),
      ),
    );
  }

  Widget _datePickerField() {
    return InkWell(
      onTap: () => _selectDate(context),
      child: Container(
        margin: const EdgeInsets.only(top: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(30)),
        child: Row(
          children: [
            Expanded(child: Text(DateFormat('dd MMMM yyyy', 'id').format(selectedDate), style: const TextStyle(fontSize: 13))),
            const Icon(Icons.calendar_today_outlined, size: 18, color: Colors.black54)
          ],
        ),
      ),
    );
  }

  Widget _priceSummary() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Total Bayar :", style: TextStyle(fontSize: 12, color: Colors.black54)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Rp ${formatRupiah(pricePerMonth)} x $duration", style: const TextStyle(fontSize: 14)),
            Text("Rp ${formatRupiah(totalPrice)}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: AppTheme.primaryBlue)),
          ],
        ),
      ],
    );
  }

  Widget _buildButtons() {
    return Column(
      children: [
        Container(
          width: double.infinity, height: 50,
          decoration: BoxDecoration(gradient: AppTheme.headerGradient, borderRadius: BorderRadius.circular(15)),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent, shadowColor: Colors.transparent),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => PaymentScreen(data: widget.data, duration: duration, total: totalPrice))),
            child: const Text("Lanjutkan ke Pembayaran", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity, height: 50,
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(backgroundColor: Colors.grey.shade100, side: BorderSide.none, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
            onPressed: () => Navigator.pop(context),
            child: const Text("Batal", style: TextStyle(color: Colors.black87)),
          ),
        ),
      ],
    );
  }

  Widget _fChip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Row(mainAxisSize: MainAxisSize.min, children: [Icon(icon, size: 14), const SizedBox(width: 4), Text(label, style: const TextStyle(fontSize: 11))]),
    );
  }
}