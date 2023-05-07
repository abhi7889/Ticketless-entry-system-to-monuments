import 'package:EZEntry/QR_Code_Screen.dart';
import 'package:EZEntry/bookingpage.dart';
import 'package:EZEntry/homepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BookingsListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('Bookings'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.teal, Colors.blue],
          ),
        ),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('bookings')
              .orderBy('dateTime', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            final bookings = snapshot.data!.docs;

            final upcomingBookings = bookings
                .where((booking) =>
                    (booking.data() as Map<String, dynamic>)['dateTime']
                        .toDate()
                        .isAfter(DateTime.now()))
                .toList();

            final previousBookings = bookings
                .where((booking) =>
                    (booking.data() as Map<String, dynamic>)['dateTime']
                        .toDate()
                        .isBefore(DateTime.now()) &&
                    (DateTime.now()
                            .difference((booking.data()
                                    as Map<String, dynamic>)['dateTime']
                                .toDate())
                            .inDays <=
                        6))
                .toList();
            if (upcomingBookings.isEmpty && previousBookings.isEmpty) {
              return Center(
                child: Text(
                  'No bookings found.',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              );
            }
            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Text(
                    'Upcoming Tickets',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: upcomingBookings.length,
                    itemBuilder: (context, index) {
                      final bookingData = upcomingBookings[index].data()
                          as Map<String, dynamic>;

                      final timeSlot = bookingData['timeSlot'] != null
                          ? bookingData['timeSlot'][0]['time']
                          : '';

                      return Card(
                        margin: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ListTile(
                          leading: Icon(
                            Icons.event,
                            color: Colors.teal,
                          ),
                          title: Text(
                            '${bookingData['monumentName']} - Booking ID: ${upcomingBookings[index].id}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Full Name: ${bookingData['fullName'] ?? ''}',
                              ),
                              Text(
                                'Date: ${bookingData['dateTime'] != null ? '${bookingData['dateTime'].toDate().day}/${bookingData['dateTime'].toDate().month}/${bookingData['dateTime'].toDate().year}' : ''}',
                              ),
                              Text('Time Slot: $timeSlot'),
                              Text(
                                'Adult Count: ${bookingData['adultCount'] ?? ''}',
                              ),
                              Text(
                                'Child Count: ${bookingData['childCount'] ?? ''}',
                              ),
                              Text(
                                'Total Price: Rs. ${bookingData['totalPrice'] ?? ''}',
                              ),
                            ],
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.teal,
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => QRCodePage(
                                  bookingId: upcomingBookings[index].id,
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Previous Tickets',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: previousBookings.length,
                    itemBuilder: (context, index) {
                      final bookingData = previousBookings[index].data()
                          as Map<String, dynamic>;

                      final timeSlot = bookingData['timeSlot'] != null
                          ? bookingData['timeSlot'][0]['time']
                          : '';

                      return Card(
                        margin: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ListTile(
                          leading: Icon(
                            Icons.event,
                            color: Colors.teal,
                          ),
                          title: Text(
                            '${bookingData['monumentName']} - Booking ID: ${previousBookings[index].id}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Full Name: ${bookingData['fullName'] ?? ''}',
                              ),
                              Text(
                                'Date: ${bookingData['dateTime'] != null ? '${bookingData['dateTime'].toDate().day}/${bookingData['dateTime'].toDate().month}/${bookingData['dateTime'].toDate().year}' : ''}',
                              ),
                              Text('Time Slot: $timeSlot'),
                              Text(
                                'Adult Count: ${bookingData['adultCount'] ?? ''}',
                              ),
                              Text(
                                'Child Count: ${bookingData['childCount'] ?? ''}',
                              ),
                              Text(
                                'Total Price: Rs. ${bookingData['totalPrice'] ?? ''}',
                              ),
                            ],
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.teal,
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => QRCodePage(
                                  bookingId: previousBookings[index].id,
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      HomePage())); // Navigate to the booking screen
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
