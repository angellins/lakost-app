import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart'; // Jika dibutuhkan
import 'package:intl/date_symbol_data_local.dart'; // Library inisialisasi bahasa
import 'screens/splash_screen.dart';
import 'theme/app_theme.dart';
import 'services/api_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id', null);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  // 4. Set mode tampilan ke edge-to-edge
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  // 5. Jalankan aplikasi
  runApp(const LaKostApp());
}

class LaKostApp extends StatelessWidget {
  const LaKostApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'laKost',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      // Mengarahkan ke SplashScreen saat pertama kali dibuka
      home: const SplashScreen(),
    );
  }
}

