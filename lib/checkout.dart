import 'dart:convert';

import 'package:EZEntry/bookings_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_stripe/flutter_stripe.dart' as Stripe;

class CheckoutPage extends StatefulWidget {
  final String monumentName;
  final String fullName;
  final String email;
  final String phoneNumber;
  final int adultCount;
  final int childCount;
  final int totalPrice;
  final DateTime dateTime;
  final List<Map<String, dynamic>> timeSlot;
  final formKey;

  const CheckoutPage({
    required this.monumentName,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.adultCount,
    required this.childCount,
    required this.totalPrice,
    required this.dateTime,
    required this.timeSlot,
    required this.formKey,
  });

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  String _selectedPaymentMethod = '';

  Map<String, dynamic>? paymentIntent;
  final _formKey = GlobalKey<FormState>();

  void updateAvailableTickets(int index) {
    setState(() {
      widget.timeSlot[index]['availableTickets']--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Checkout'),
          backgroundColor: Colors.teal,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Booking Details',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Monument Name:',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            widget.monumentName,
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Full Name:',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            widget.fullName,
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Email:',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            widget.email,
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Phone Number:',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            widget.phoneNumber,
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Adults:',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            widget.adultCount.toString(),
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Children:',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            widget.childCount.toString(),
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Date:',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            '${widget.dateTime.day}/${widget.dateTime.month}/${widget.dateTime.year}',
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Payment Options',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // ListTile(
                          //   leading: Icon(Icons.payment),
                          //   title: Text('UPI'),
                          //   onTap: () {
                          //     setState(() {
                          //       _selectedPaymentMethod = 'UPI';
                          //     });
                          //   },
                          //   trailing: _selectedPaymentMethod == 'UPI'
                          //       ? Icon(Icons.check_circle, color: Colors.green)
                          //       : null,
                          // ),
                          Divider(),
                          ListTile(
                            leading: Icon(Icons.payment),
                            title: Text('Debit Card'),
                            onTap: () {
                              setState(() {
                                _selectedPaymentMethod = 'Debit Card';
                              });
                            },
                            trailing: _selectedPaymentMethod == 'Debit Card'
                                ? Icon(Icons.check_circle, color: Colors.green)
                                : null,
                          ),
                          Divider(),
                          ListTile(
                            leading: Icon(Icons.payment),
                            title: Text('Credit Card'),
                            onTap: () {
                              setState(() {
                                _selectedPaymentMethod = 'Credit Card';
                              });
                            },
                            trailing: _selectedPaymentMethod == 'Credit Card'
                                ? Icon(Icons.check_circle, color: Colors.green)
                                : null,
                          ),
                          Divider(),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      await makePayment();
                    },
                    child: const Text('Make Payment'),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Future<void> makePayment() async {
    try {
      String totalPriceString = widget.totalPrice.toString();
      paymentIntent = await createPaymentIntent(totalPriceString, 'INR');

      await Stripe.Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: Stripe.SetupPaymentSheetParameters(
                  paymentIntentClientSecret: paymentIntent!['client_secret'],
                  style: ThemeMode.dark,
                  merchantDisplayName: 'vansh'))
          .then((value) {});
      displayPaymentSheet();
    } catch (e, s) {
      if (kDebugMode) {
        print(s);
      }
    }
  }

  displayPaymentSheet() async {
    try {
      await Stripe.Stripe.instance.presentPaymentSheet().then((newValue) async {
        // final paymentResult = await Stripe.Stripe.instance.completePayment();
        // if (paymentResult.status == Stripe.PaymentStatus.succeeded) {
        if (widget.formKey.currentState!.validate()) {
          if (widget.timeSlot.length == 1) {
            widget.formKey.currentState!.save();

            DocumentReference bookingDocRef =
                await FirebaseFirestore.instance.collection('bookings').add({
              'monumentName': widget.monumentName,
              'fullName': widget.fullName,
              'email': widget.email,
              'phoneNumber': widget.phoneNumber,
              'adultCount': widget.adultCount,
              'childCount': widget.childCount,
              'totalPrice': widget.totalPrice,
              'dateTime': widget.dateTime,
              'timeSlot': widget.timeSlot,
            });

            String bookingId = bookingDocRef.id;

            updateAvailableTickets(0);

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BookingConfirmationPage(
                  bookingDocRef: bookingDocRef,
                  bookingId: bookingId,
                ),
              ),
            );
            paymentIntent = null;
          }
        }
      }).onError((error, stackTrace) {
        if (kDebugMode) {
          print('Exception/DISPLAYPAYMENTSHEET==> $error $stackTrace');
        }
      });
    } on Stripe.StripeException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      showDialog(
          context: context,
          builder: (_) => const AlertDialog(
                content: Text("Cancelled "),
              ));
    } catch (e) {
      if (kDebugMode) {
        print('$e');
      }
    }
  }

  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization':
                'Bearer sk_test_51MvJZUSBTWA3x7fKgTaBbcTKC8B6cJx49NHylkhLIlOORRyCgbnjmCX6f3rZrDYm9jp9OT3NjaVqOlBkA99Lt1rb00V7mciHCS',
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      return jsonDecode(response.body);
    } catch (err) {
      if (kDebugMode) {
        print('err charging user: ${err.toString()}');
      }
    }
  }

  calculateAmount(String amount) {
    final a = (int.parse(amount)) * 100;
    return a.toString();
  }
}
