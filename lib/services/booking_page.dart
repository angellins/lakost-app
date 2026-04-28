import 'package:flutter/material.dart';
import '../services/api_service.dart';

class BookingPage extends StatefulWidget {
  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  List booking = [];

  @override
  void initState() {
    super.initState();
    loadBooking();
  }

  void loadBooking() async {
    final data = await ApiService.getBooking();
    setState(() {
      booking = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Booking')),
      body: ListView.builder(
        itemCount: booking.length,
        itemBuilder: (context, i) {
          final b = booking[i];
          return ListTile(
            title: Text(b['kost']['nama_kost']),
            subtitle: Text(b['user']['name']),
          );
        },
      ),
    );
  }
}