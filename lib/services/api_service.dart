import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://10.253.130.72:8000/api";

  // ================= KOST =================
  static Future<List<dynamic>> getKost() async {
    final res = await http.get(Uri.parse('$baseUrl/kost'));
    return jsonDecode(res.body);
  }

  // ================= KATEGORI =================
  static Future<List<dynamic>> getKategori() async {
    final res = await http.get(Uri.parse('$baseUrl/kategori'));
    return jsonDecode(res.body)['data'];
  }

  // ================= WILAYAH =================
  static Future<List<dynamic>> getWilayah() async {
    final res = await http.get(Uri.parse('$baseUrl/wilayah'));
    return jsonDecode(res.body);
  }

  // ================= BOOKING =================
  static Future<List<dynamic>> getBooking() async {
    final res = await http.get(Uri.parse('$baseUrl/booking'));
    return jsonDecode(res.body);
  }

  static Future createBooking(int userId, int kostId) async {
    final res = await http.post(
      Uri.parse('$baseUrl/booking'),
      body: {
        'user_id': userId.toString(),
        'kost_id': kostId.toString(),
      },
    );

    return jsonDecode(res.body);
  }

  // ================= PEMBAYARAN =================
  static Future<List<dynamic>> getPembayaran() async {
    final res = await http.get(Uri.parse('$baseUrl/pembayaran'));
    return jsonDecode(res.body);
  }

  static Future createPembayaran(int bookingId) async {
    final res = await http.post(
      Uri.parse('$baseUrl/pembayaran'),
      body: {
        'booking_id': bookingId.toString(),
      },
    );

    return jsonDecode(res.body);
  }
}