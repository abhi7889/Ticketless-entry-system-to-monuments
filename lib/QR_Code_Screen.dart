import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class QRCodePage extends StatefulWidget {
  final String bookingId;

  const QRCodePage({required this.bookingId});

  @override
  _QRCodePageState createState() => _QRCodePageState();
}

class _QRCodePageState extends State<QRCodePage> {
  @override
  void initState() {
    super.initState();
    // Check if permission to save images to the gallery is granted
    Permission.storage.request();
    Permission.notification.request();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          title: Text('Bookings Details'),
          centerTitle: true,
          backgroundColor: Colors.teal,
          elevation: 0,
        ),
        body: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('bookings')
              .doc(widget.bookingId)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            final bookingData = snapshot.data!.data() as Map<String, dynamic>;

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Card(
                    elevation: 8,
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'QR Code',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 20),
                          Container(
                            color: Colors.white,
                            padding: EdgeInsets.all(16),
                            child: QrImage(
                              data: widget.bookingId,
                              size: 250,
                            ),
                          ),
                          Divider(),
                          SizedBox(height: 20),
                          Text(
                            'Full Name: ${bookingData['fullName']}',
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Date: ${bookingData['dateTime'].toDate().day}/${bookingData['dateTime'].toDate().month}/${bookingData['dateTime'].toDate().year}',
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Time Slot: ${bookingData['timeSlot'][0]['time']}',
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Adult Count: ${bookingData['adultCount']}',
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Child Count: ${bookingData['childCount']}',
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Total Price: Rs. ${bookingData['totalPrice']}',
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        floatingActionButton: Padding(
          padding: EdgeInsets.only(bottom: 2),
          child: FloatingActionButton(
            onPressed: () async {
              // Check if permission to save images to the gallery is granted
              if (await Permission.storage.isGranted) {
                // Save the QR code image to the gallery
                final qrImageData = await QrPainter(
                  data: widget.bookingId,
                  version: QrVersions.auto,
                  errorCorrectionLevel: QrErrorCorrectLevel.Q,
                ).toImageData(250);
                final result = await ImageGallerySaver.saveImage(
                  Uint8List.view(qrImageData!.buffer),
                  quality: 100,
                );
                print(result);

                // Show a notification that the image has been downloaded
                FlutterLocalNotificationsPlugin flnp =
                    FlutterLocalNotificationsPlugin();
                // Show a notification that the image has been downloaded
                var android = AndroidNotificationDetails(
                  'channel id',
                  'channel name',
                  'channel description',
                  importance: Importance.high,
                  priority: Priority.high,
                );
                var platform = NotificationDetails(android: android);
                await flnp.show(
                  0,
                  'QR Code Downloaded',
                  'The QR code image has been saved to the gallery.',
                  platform,
                );
              } else {
                // Request permission to save images to the gallery
                await Permission.storage.request();
                await Permission.notification.request();
              }
            },
            backgroundColor: Colors.white,
            child: Icon(Icons.download, color: Colors.teal),
          ),
        ));
  }
}
