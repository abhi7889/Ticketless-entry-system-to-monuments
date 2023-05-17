import 'package:EZEntry/QR_Code_Screen.dart';
import 'package:EZEntry/checkout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BookingConfirmationPage extends StatelessWidget {
  final DocumentReference bookingDocRef;
  final String bookingId;

  const BookingConfirmationPage({
    required this.bookingDocRef,
    required this.bookingId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking Confirmation'),
        backgroundColor: Colors.teal.shade900,
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.teal.shade200,
              Colors.teal.shade400,
            ],
          ),
        ),
        padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: ClipOval(
                child: Image.asset(
                  'assets/Confirmed.gif',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Your booking has been confirmed!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: 'Montserrat',
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Booking ID: $bookingId',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: 'Montserrat',
              ),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => QRCodePage(bookingId: bookingId),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange.shade900,
                padding: EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 20,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                'View Details',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'Montserrat',
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Share your booking with friends:',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontFamily: 'Montserrat',
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.facebook,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.share,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
