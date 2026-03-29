# 🏠 laKost — Aplikasi Pencarian Kost Modern

> Platform pencarian kost yang mudah, cepat, dan terpercaya — dibangun dengan Flutter.

---

## 📋 Daftar Isi

- [Tentang Aplikasi](#tentang-aplikasi)
- [Fitur Utama](#fitur-utama)
- [Teknologi & Package](#teknologi--package)
- [Struktur Proyek](#struktur-proyek)
- [Cara Menjalankan](#cara-menjalankan)
- [Panduan Update & Pengembangan](#panduan-update--pengembangan)
- [Catatan Desain](#catatan-desain)

---

## Tentang Aplikasi

**laKost** adalah aplikasi mobile berbasis Flutter untuk mencari kos-kosan secara modern. Aplikasi ini dirancang dengan pengalaman pengguna yang mulus (smooth UX), transisi animasi yang halus, dan branding yang konsisten dari splash screen hingga layar utama.

---

## Fitur Utama

### 1. Navigasi & Transisi Halus
- **Splash → Home**: Menggunakan `PageRouteBuilder` dengan `FadeTransition` — perpindahan terasa natural, tidak kaku.
- **Antar Tab (Bottom Nav)**: Menggunakan `SharedAxisTransition` dari package `animations` dengan arah horizontal — saat pindah tab, layar bergeser secara elegan.
- Semua perpindahan layar konsisten menggunakan transisi yang sama di seluruh aplikasi.

### 2. Visual & Branding Terpadu
- **Gradasi Sinkron**: Kode warna `LinearGradient` pada `splash_screen.dart` dan `home_screen.dart` identik — saat transisi, latar belakang terasa menyatu tanpa "lompatan" warna.
- **Aset Logo**: File logo PNG yang sama (`assets/images/logo.png`) dipakai di Splash Screen dan Header Home — ukuran konsisten, tidak ada perbedaan visual.
- **Gambar Rumah Background**: Gambar nyata (`assets/images/house_bg.png`) dipakai sebagai background header Home dengan overlay gradasi untuk keterbacaan teks.

### 3. Layout & Status Bar Responsif
- **Status Bar Transparan**: Diatur di `main.dart` via `SystemChrome.setSystemUIOverlayStyle` dengan `statusBarColor: Colors.transparent` dan `SystemUiMode.edgeToEdge`.
- **SafeArea**: Seluruh konten header dibungkus `SafeArea` agar tidak tertutup notch/kamera/jam.

### 4. Micro-Interactions
- **Efek Ripple**: Ikon notifikasi menggunakan `InkWell` — muncul efek lingkaran saat ditekan.
- **Badge Berdenyut (Pulsing Badge)**: Widget `PulsingBadge` menggunakan `AnimationController` dengan `repeat(reverse: true)` — titik kuning notifikasi "berdenyut" untuk menarik perhatian.
- **Filter Animasi**: Chip filter menggunakan `AnimatedContainer` — ada perubahan warna, elevasi, dan gradient saat dipilih.
- **Bottom Nav Animasi**: Tab aktif memperluas diri menampilkan label teks dengan `AnimatedSize`.

### 5. Optimasi Filter (Better UX)
- Tombol filter menggunakan widget `Wrap` dengan `spacing: 10.0` — jarak konsisten dan otomatis turun baris jika layar sempit.
- Filter aktif mendapatkan `gradient` cyan + `boxShadow` biru — kontras visual yang jelas.

### 6. Greeting Sederhana
- Header Home hanya menampilkan **"Hallo! 👋"** tanpa nama user yang statis.

---

## Teknologi & Package

| Package | Versi | Fungsi |
|---|---|---|
| `flutter` | SDK | Framework utama |
| `animations` | ^2.0.11 | SharedAxisTransition untuk bottom nav |
| `google_fonts` | ^6.1.0 | Font Poppins — tipografi modern |
| `cached_network_image` | ^3.3.1 | Gambar dari network (siap dipakai) |

---

## Struktur Proyek

```
lakost_app/
├── assets/
│   └── images/
│       ├── logo.png          # Logo laKost (Splash + Header)
│       └── house_bg.png      # Foto rumah untuk background header
│
├── lib/
│   ├── main.dart             # Entry point, konfigurasi status bar
│   ├── theme/
│   │   └── app_theme.dart    # Semua warna, gradasi, dan tema aplikasi
│   ├── screens/
│   │   ├── splash_screen.dart     # Splash + animasi logo + transisi ke Home
│   │   ├── bottom_nav_bar.dart    # Navigasi bawah + SharedAxisTransition
│   │   ├── home_screen.dart       # Layar utama (header + filter + daftar kost)
│   │   ├── search_screen.dart     # Pencarian kost
│   │   ├── favorite_screen.dart   # Daftar favorit
│   │   └── profile_screen.dart    # Profil pengguna
│   └── widgets/
│       ├── kost_card.dart         # Card kost reusable
│       └── pulsing_badge.dart     # Badge notifikasi berdenyut
│
├── pubspec.yaml              # Konfigurasi dependencies & assets
└── README.md                 # Dokumentasi ini
```

---

## Cara Menjalankan

### Prasyarat
- Flutter SDK versi 3.0.0 atau lebih baru
- Android Studio / VS Code dengan ekstensi Flutter
- Perangkat Android/iOS atau emulator

### Langkah-langkah

```bash
# 1. Masuk ke folder proyek
cd lakost_app

# 2. Install dependencies
flutter pub get

# 3. Jalankan aplikasi
flutter run
```

### Build APK (Release)

```bash
flutter build apk --release
```

File APK akan tersimpan di: `build/app/outputs/flutter-apk/app-release.apk`

---

## Panduan Update & Pengembangan

### Mengganti Warna Tema
Semua warna terpusat di `lib/theme/app_theme.dart`. Cukup ubah nilai konstanta warna di sana, semua layar akan ikut berubah otomatis.

```dart
// Contoh: ganti warna aksen
static const Color accentCyan = Color(0xFF29B6D9); // Ubah di sini
```

### Menambah Data Kost
Data kost saat ini menggunakan list statis di `home_screen.dart` dan `search_screen.dart`. Untuk integrasi dengan API/backend, ganti list statis dengan pemanggilan HTTP di `initState()`.

### Menambah Layar Baru
1. Buat file baru di `lib/screens/`
2. Tambahkan ke list `_screens` di `bottom_nav_bar.dart`
3. Tambahkan item baru ke list `_navItems` di `bottom_nav_bar.dart`

### Mengganti Logo atau Gambar
1. Ganti file di `assets/images/`
2. Pastikan nama file sama (atau update referensi di kode)
3. Jalankan `flutter pub get` jika ada aset baru

---

## Catatan Desain

### Palet Warna

| Nama | HEX | Penggunaan |
|---|---|---|
| Deep Navy | `#0D1F35` | Background utama, gradasi gelap |
| Primary Blue | `#1A3A5C` | Gradasi header, button |
| Accent Cyan | `#29B6D9` | Aksen, icon aktif, badge |
| Accent Gold | `#F5A623` | Bintang rating, elemen kuning logo |
| Soft White | `#F5F7FA` | Background layar konten |
| Text Dark | `#0D1F35` | Teks judul |
| Text Grey | `#7A8FA6` | Teks sekunder, placeholder |

### Prinsip Desain
- **Konsistensi**: Gradasi yang sama dipakai di semua header layar
- **Hierarki visual**: Ukuran font dan berat (weight) yang bertingkat jelas
- **Micro-feedback**: Setiap elemen interaktif punya respons visual
- **Branding**: Logo dan warna laKost hadir di seluruh aplikasi

---

*Dibuat dengan ❤️ menggunakan Flutter — laKost 2026*
