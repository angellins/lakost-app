import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../theme/app_theme.dart';
import 'upload_proof_screen.dart';

class PaymentScreen extends StatefulWidget {
  final Map<String, dynamic> data;
  final int duration;
  final int total;

  const PaymentScreen({
    super.key,
    required this.data,
    required this.duration,
    required this.total,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String? selectedMethod;
  late String vaNumber;

  @override
  void initState() {
    super.initState();
    vaNumber =
        "12345${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}";
  }

  String formatRupiah(int number) {
    return NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp ',
      decimalDigits: 0,
    ).format(number);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.softWhite,
      body: Column(
        children: [
          _header(context, "Pilih Pembayaran"),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 100),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppTheme.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 15,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _vaCard("Mandiri VA", vaNumber),
                    const SizedBox(height: 12),
                    _vaCard("BCA Virtual Account", "88321$vaNumber"),

                    const SizedBox(height: 24),

                    Text(
                      "Metode Lain",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                    ),

                    const SizedBox(height: 12),

                    _methodBtn("Cash", Icons.money),
                    const SizedBox(height: 10),
                    _methodBtn("Dana", Icons.account_balance_wallet_outlined),
                    const SizedBox(height: 10),
                    _methodBtn("OVO", Icons.vignette_outlined),
                  ],
                ),
              ),
            ),
          )
        ],
      ),

      // ===== BUTTON =====
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
            )
          ],
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.primaryBlue,
            foregroundColor: Colors.white, // 🔥 biar teks tidak hilang
            minimumSize: const Size(double.infinity, 55),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),

          // ✅ VALIDASI TANPA DISABLE
          onPressed: () {
            if (selectedMethod == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Pilih metode pembayaran dulu"),
                  behavior: SnackBarBehavior.floating,
                ),
              );
              return;
            }

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const UploadProofScreen(),
              ),
            );
          },

          child: Text(
            "Bayar Sekarang",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  // ===== VA CARD =====
  Widget _vaCard(String title, String va) {
    bool isSelected = selectedMethod == title;

    return InkWell(
      onTap: () => setState(() => selectedMethod = title),
      borderRadius: BorderRadius.circular(14),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? AppTheme.primaryBlue.withOpacity(0.05)
              : Colors.white,
          border: Border.all(
            color: isSelected
                ? AppTheme.primaryBlue
                : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w700,
                    color: isSelected
                        ? AppTheme.primaryBlue
                        : Colors.black87,
                  ),
                ),
                if (isSelected)
                  const Icon(Icons.check_circle,
                      color: AppTheme.primaryBlue, size: 20),
              ],
            ),
            const SizedBox(height: 8),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  va,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                const Icon(Icons.copy, size: 18),
              ],
            ),

            const Divider(height: 20),

            Text(
              "Total: ${formatRupiah(widget.total)}",
              style: GoogleFonts.poppins(fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }

  // ===== METHOD BUTTON =====
  Widget _methodBtn(String text, IconData icon) {
    bool isSelected = selectedMethod == text;

    return SizedBox(
      width: double.infinity,
      height: 50,
      child: OutlinedButton.icon(
        style: OutlinedButton.styleFrom(
          backgroundColor: isSelected
              ? AppTheme.primaryBlue
              : Colors.grey.shade100,
          foregroundColor: isSelected ? Colors.white : Colors.black87,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () => setState(() => selectedMethod = text),
        icon: Icon(icon, size: 20),
        label: Text(
          text,
          style: GoogleFonts.poppins(
            fontWeight:
                isSelected ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
      ),
    );
  }

  // ===== HEADER =====
  Widget _header(BuildContext context, String title) {
    return Container(
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
          padding: const EdgeInsets.fromLTRB(8, 10, 16, 20),
          child: Row(
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_ios_rounded,
                    color: Colors.white, size: 20),
              ),
              Text(
                title,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}