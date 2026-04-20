// import 'package:flutter/material.dart';
// import '../theme/app_theme.dart';

// class SuccessScreen extends StatelessWidget {
//   const SuccessScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppTheme.softWhite,
//       body: Column(
//         children: [
//           AppBar(title: const Text("Success")),

//           Expanded(
//             child: Center(
//               child: Container(
//                 margin: const EdgeInsets.all(20),
//                 padding: const EdgeInsets.all(20),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(24),
//                 ),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     const Icon(Icons.check_circle,
//                         size: 80, color: Colors.green),

//                     const SizedBox(height: 16),

//                     const Text(
//                       "Pembayaran Berhasil!",
//                       style:
//                           TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                     ),

//                     const SizedBox(height: 8),

//                     const Text(
//                       "Bukti pembayaran berhasil dikirim.\nMenunggu validasi admin.",
//                       textAlign: TextAlign.center,
//                     ),

//                     const SizedBox(height: 12),

//                     const Text(
//                       "Silakan cek notifikasi dalam 24 jam.",
//                       style: TextStyle(color: Colors.grey),
//                     ),

//                     const SizedBox(height: 20),

//                     ElevatedButton(
//                       onPressed: () {
//                         Navigator.popUntil(
//                             context, (route) => route.isFirst);
//                       },
//                       child: const Text("Selesai"),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }