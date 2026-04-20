// import 'package:flutter/material.dart';
// import '../theme/app_theme.dart';
// import 'upload_proof_screen.dart';

// class ConfirmationScreen extends StatelessWidget {
//   final Map<String, dynamic> data;
//   final int duration;
//   final int total;

//   const ConfirmationScreen({
//     super.key,
//     required this.data,
//     required this.duration,
//     required this.total,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppTheme.softWhite,
//       body: Column(
//         children: [
//           _header(context, "Ringkasan & Konfirmasi"),

//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.all(16),
//               child: Container(
//                 padding: const EdgeInsets.all(16),
//                 decoration: _card(),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(data['name']),
//                     Text("Durasi: $duration bulan"),
//                     const SizedBox(height: 10),
//                     Text("Total Tagihan: Rp $total"),
//                   ],
//                 ),
//               ),
//             ),
//           )
//         ],
//       ),
//       bottomNavigationBar: _bottom(context),
//     );
//   }

//   Widget _bottom(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16),
//       child: ElevatedButton(
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (_) => const UploadProofScreen()),
//           );
//         },
//         child: const Text("Konfirmasi"),
//       ),
//     );
//   }

//   Widget _header(BuildContext context, String title) {
//     return Container(
//       decoration: const BoxDecoration(gradient: AppTheme.headerGradient),
//       child: SafeArea(
//         child: Row(
//           children: [
//             IconButton(
//               onPressed: () => Navigator.pop(context),
//               icon: const Icon(Icons.arrow_back, color: Colors.white),
//             ),
//             Text(title, style: const TextStyle(color: Colors.white)),
//           ],
//         ),
//       ),
//     );
//   }

//   BoxDecoration _card() =>
//       BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24));
// }