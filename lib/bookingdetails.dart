// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class BookingDetailsPage extends StatelessWidget {
//   final String bookingId;

//   const BookingDetailsPage(
//       {required this.bookingId, required String monumentName});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Booking Details'),
//       ),
//       body: StreamBuilder<DocumentSnapshot>(
//         stream: FirebaseFirestore.instance
//             .collection('bookings')
//             .doc(bookingId)
//             .snapshots(),
//         builder: (context, snapshot) {
//           if (!snapshot.hasData) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           }

//           final bookingData = snapshot.data!.data() as Map<String, dynamic>;

//           return Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 Text(
//                   'Booking Details',
//                   style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 Text(
//                   'Monument Name: ${bookingData['monumentName']}',
//                   style: TextStyle(fontSize: 18),
//                 ),
//                 SizedBox(height: 10),
//                 Text(
//                   'Full Name: ${bookingData['fullName']}',
//                   style: TextStyle(fontSize: 18),
//                 ),
//                 SizedBox(height: 10),
//                 Text(
//                   'Email: ${bookingData['email']}',
//                   style: TextStyle(fontSize: 18),
//                 ),
//                 SizedBox(height: 10),
//                 Text(
//                   'Phone Number: ${bookingData['phoneNumber']}',
//                   style: TextStyle(fontSize: 18),
//                 ),
//                 SizedBox(height: 10),
//                 Text(
//                   'Adult Count: ${bookingData['adultCount']}',
//                   style: TextStyle(fontSize: 18),
//                 ),
//                 SizedBox(height: 10),
//                 Text(
//                   'Child Count: ${bookingData['childCount']}',
//                   style: TextStyle(fontSize: 18),
//                 ),
//                 SizedBox(height: 10),
//                 Text(
//                   'Total Price: Rs. ${bookingData['totalPrice']}',
//                   style: TextStyle(fontSize: 18),
//                 ),
//                 SizedBox(height: 10),
//                 Text(
//                   'Date: ${bookingData['dateTime'].toDate().day}/${bookingData['dateTime'].toDate().month}/${bookingData['dateTime'].toDate().year}',
//                   style: TextStyle(fontSize: 18),
//                 ),
//                 SizedBox(height: 10),
//                 Text(
//                   'Time: ${bookingData['dateTime'].toDate().hour}:${bookingData['dateTime'].toDate().minute}',
//                   style: TextStyle(fontSize: 18),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
