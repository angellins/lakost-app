import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  final _namaController = TextEditingController();
  final _tanggalLahirController = TextEditingController();
  final _kotaAsalController = TextEditingController();
  final _kontakDaruratController = TextEditingController();

  String? _selectedJenisKelamin;
  String? _selectedPekerjaan;

  final List<String> _jenisKelaminOptions = ['Laki-laki', 'Perempuan'];
  final List<String> _pekerjaanOptions = ['Pelajar', 'Mahasiswa', 'Karyawan'];

  @override
  void dispose() {
    _namaController.dispose();
    _tanggalLahirController.dispose();
    _kotaAsalController.dispose();
    _kontakDaruratController.dispose();
    super.dispose();
  }

  void _simpan() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Profil berhasil disimpan!',
            style: GoogleFonts.poppins(color: AppTheme.white),
          ),
          backgroundColor: AppTheme.primaryBlue,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
    }
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
                padding: const EdgeInsets.fromLTRB(4, 8, 20, 20),
                child: Row(
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
                      'Informasi Pribadi',
                      style: GoogleFonts.poppins(
                        color: AppTheme.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // ── Form ──
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppTheme.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ── Foto profil ──
                      Row(
                        children: [
                          Container(
                            width: 64,
                            height: 64,
                            decoration: BoxDecoration(
                              color: AppTheme.primaryBlue,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.person_rounded,
                              color: AppTheme.white,
                              size: 34,
                            ),
                          ),
                          const SizedBox(width: 16),
                          GestureDetector(
                            onTap: () {},
                            child: Text(
                              'Ubah Foto',
                              style: GoogleFonts.poppins(
                                color: AppTheme.primaryBlue,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      // ── Nama Lengkap ──
                      _buildLabel('Nama Lengkap'),
                      const SizedBox(height: 6),
                      _buildTextField(
                        controller: _namaController,
                        hint: 'Masukkan nama lengkap kamu',
                        validator: (v) =>
                            (v == null || v.isEmpty) ? 'Nama wajib diisi' : null,
                      ),

                      const SizedBox(height: 16),

                      // ── Jenis Kelamin ──
                      _buildLabel('Jenis Kelamin'),
                      const SizedBox(height: 6),
                      _buildDropdown(
                        value: _selectedJenisKelamin,
                        hint: 'Pilih jenis kelamin',
                        items: _jenisKelaminOptions,
                        onChanged: (val) =>
                            setState(() => _selectedJenisKelamin = val),
                        isRequired: true,
                      ),

                      const SizedBox(height: 16),

                      // ── Tanggal Lahir ──
                      _buildLabel('Tanggal Lahir'),
                      const SizedBox(height: 6),
                      _buildTextField(
                        controller: _tanggalLahirController,
                        hint: 'Masukkan tanggal lahir',
                        readOnly: true,
                        suffixIcon: Icons.calendar_today_outlined,
                        onTap: () async {
                          final picked = await showDatePicker(
                            context: context,
                            initialDate: DateTime(2000),
                            firstDate: DateTime(1950),
                            lastDate: DateTime.now(),
                            builder: (ctx, child) => Theme(
                              data: Theme.of(ctx).copyWith(
                                colorScheme: ColorScheme.light(
                                  primary: AppTheme.primaryBlue,
                                ),
                              ),
                              child: child!,
                            ),
                          );
                          if (picked != null) {
                            _tanggalLahirController.text =
                                '${picked.day}/${picked.month}/${picked.year}';
                          }
                        },
                        validator: (v) =>
                            (v == null || v.isEmpty) ? 'Wajib diisi' : null,
                      ),

                      const SizedBox(height: 16),

                      // ── Pekerjaan ──
                      _buildLabel('Pekerjaan'),
                      const SizedBox(height: 6),
                      _buildDropdown(
                        value: _selectedPekerjaan,
                        hint: 'Pilih pekerjaan',
                        items: _pekerjaanOptions,
                        onChanged: (val) =>
                            setState(() => _selectedPekerjaan = val),
                        isRequired: true,
                      ),

                      const SizedBox(height: 16),

                      // ── Kota Asal ──
                      _buildLabel('Kota Asal'),
                      const SizedBox(height: 6),
                      _buildTextField(
                        controller: _kotaAsalController,
                        hint: 'Masukkan kota asal',
                        validator: (v) =>
                            (v == null || v.isEmpty) ? 'Wajib diisi' : null,
                      ),

                      const SizedBox(height: 16),

                      // ── Kontak Darurat ──
                      _buildLabel('Kontak Darurat'),
                      const SizedBox(height: 6),
                      _buildTextField(
                        controller: _kontakDaruratController,
                        hint: '',
                        keyboardType: TextInputType.phone,
                      ),

                      const SizedBox(height: 28),

                      // ── Tombol Simpan ──
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _simpan,
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ).copyWith(
                            backgroundColor:
                                WidgetStateProperty.all(Colors.transparent),
                          ),
                          child: Ink(
                            decoration: BoxDecoration(
                              gradient: AppTheme.primaryGradient,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              child: Text(
                                'Simpan',
                                style: GoogleFonts.poppins(
                                  color: AppTheme.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        color: AppTheme.textDark,
        fontSize: 13,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
    bool readOnly = false,
    IconData? suffixIcon,
    VoidCallback? onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: controller,
          validator: validator,
          keyboardType: keyboardType,
          readOnly: readOnly,
          onTap: onTap,
          style: GoogleFonts.poppins(
            color: AppTheme.textDark,
            fontSize: 13,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.poppins(
              color: AppTheme.textGrey,
              fontSize: 13,
            ),
            suffixIcon: suffixIcon != null
                ? Icon(suffixIcon, color: AppTheme.textGrey, size: 18)
                : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppTheme.primaryBlue, width: 1.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.red),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          ),
        ),
        if (validator != null)
          Padding(
            padding: const EdgeInsets.only(top: 3, left: 2),
            child: Text(
              'Wajib diisi',
              style: GoogleFonts.poppins(
                color: AppTheme.textGrey,
                fontSize: 10,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildDropdown({
    required String? value,
    required String hint,
    required List<String> items,
    required void Function(String?) onChanged,
    bool isRequired = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButtonFormField<String>(
          value: value,
          hint: Text(
            hint,
            style: GoogleFonts.poppins(color: AppTheme.textGrey, fontSize: 13),
          ),
          validator: isRequired
              ? (v) => v == null ? 'Wajib diisi' : null
              : null,
          onChanged: onChanged,
          style: GoogleFonts.poppins(color: AppTheme.textDark, fontSize: 13),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppTheme.primaryBlue, width: 1.5),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          ),
          items: items
              .map((e) => DropdownMenuItem(
                    value: e,
                    child: Text(e,
                        style: GoogleFonts.poppins(
                            color: AppTheme.textDark, fontSize: 13)),
                  ))
              .toList(),
        ),
        if (isRequired)
          Padding(
            padding: const EdgeInsets.only(top: 3, left: 2),
            child: Text(
              'Wajib diisi',
              style: GoogleFonts.poppins(
                color: AppTheme.textGrey,
                fontSize: 10,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
      ],
    );
  }
}
