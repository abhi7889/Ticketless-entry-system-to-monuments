// import 'package:EZEntry/allbookings.dart';
// import 'package:EZEntry/payment/upi.dart';
// import 'package:flutter/material.dart';

// class CheckoutPage extends StatefulWidget {
//   final String monumentName;
//   final String fullName;
//   final String email;
//   final String phoneNumber;
//   final int adultCount;
//   final int childCount;
//   final int totalPrice;
//   final DateTime dateTime;
//   final Map selectedTimeSlot;

//   const CheckoutPage({
//     required this.monumentName,
//     required this.fullName,
//     required this.email,
//     required this.phoneNumber,
//     required this.adultCount,
//     required this.childCount,
//     required this.totalPrice,
//     required this.dateTime,
//     required this.selectedTimeSlot,
//   });

//   @override
//   _CheckoutPageState createState() => _CheckoutPageState();
// }

// class _CheckoutPageState extends State<CheckoutPage> {
//   String _selectedPaymentMethod = '';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Checkout'),
//         backgroundColor: Colors.teal,
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               Text(
//                 'Booking Details',
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(height: 20),
//               Card(
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Monument Name:',
//                         style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       SizedBox(height: 5),
//                       Text(
//                         widget.monumentName,
//                         style: TextStyle(fontSize: 18),
//                       ),
//                       SizedBox(height: 10),
//                       Text(
//                         'Full Name:',
//                         style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       SizedBox(height: 5),
//                       Text(
//                         widget.fullName,
//                         style: TextStyle(fontSize: 18),
//                       ),
//                       SizedBox(height: 10),
//                       Text(
//                         'Email:',
//                         style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       SizedBox(height: 5),
//                       Text(
//                         widget.email,
//                         style: TextStyle(fontSize: 18),
//                       ),
//                       SizedBox(height: 10),
//                       Text(
//                         'Phone Number:',
//                         style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       SizedBox(height: 5),
//                       Text(
//                         widget.phoneNumber,
//                         style: TextStyle(fontSize: 18),
//                       ),
//                       SizedBox(height: 10),
//                       Text(
//                         'Adults:',
//                         style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       SizedBox(height: 5),
//                       Text(
//                         widget.adultCount.toString(),
//                         style: TextStyle(fontSize: 18),
//                       ),
//                       SizedBox(height: 10),
//                       Text(
//                         'Children:',
//                         style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       SizedBox(height: 5),
//                       Text(
//                         widget.childCount.toString(),
//                         style: TextStyle(fontSize: 18),
//                       ),
//                       SizedBox(height: 10),
//                       Text(
//                         'Date:',
//                         style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       SizedBox(height: 5),
//                       Text(
//                         '${widget.dateTime.day}/${widget.dateTime.month}/${widget.dateTime.year}',
//                         style: TextStyle(fontSize: 18),
//                       ),
//                       SizedBox(height: 10),
//                       Text(
//                         'Time Slot:',
//                         style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       SizedBox(height: 5),
//                       Text(
//                         widget.selectedTimeSlot['time'],
//                         style: TextStyle(fontSize: 18),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20),
//               Text(
//                 'Payment Options',
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(height: 20),
//               Card(
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       ListTile(
//                         leading: Icon(Icons.payment),
//                         title: Text('UPI'),
//                         onTap: () {
//                           setState(() {
//                             _selectedPaymentMethod = 'UPI';
//                           });
//                         },
//                         trailing: _selectedPaymentMethod == 'UPI'
//                             ? Icon(Icons.check_circle, color: Colors.green)
//                             : null,
//                       ),
//                       Divider(),
//                       ListTile(
//                         leading: Icon(Icons.payment),
//                         title: Text('Debit Card'),
//                         onTap: () {
//                           setState(() {
//                             _selectedPaymentMethod = 'Debit Card';
//                           });
//                         },
//                         trailing: _selectedPaymentMethod == 'Credit Card'
//                             ? Icon(Icons.check_circle, color: Colors.green)
//                             : null,
//                       ),
//                       Divider(),
//                       ListTile(
//                         leading: Icon(Icons.payment),
//                         title: Text('Credit Card'),
//                         onTap: () {
//                           setState(() {
//                             _selectedPaymentMethod = 'Credit Card';
//                           });
//                         },
//                         trailing: _selectedPaymentMethod == 'Credit Card'
//                             ? Icon(Icons.check_circle, color: Colors.green)
//                             : null,
//                       ),
//                       Divider(),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => BookingsScreen()),
//                   );
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.teal,
//                   padding: EdgeInsets.symmetric(vertical: 16),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   textStyle: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 child: Text('Pay Now'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
