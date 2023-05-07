import 'package:EZEntry/about.dart';
import 'package:EZEntry/accountpage.dart';
import 'package:EZEntry/allbookings.dart';
import 'package:EZEntry/bookingpage.dart';
import 'package:EZEntry/helpsupport.dart';
import 'package:EZEntry/monuments_detail.dart';
import 'package:EZEntry/screens/signin_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future clearSharedPreference() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.clear();
}

class HomePage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF5F5F5),
        appBar: AppBar(
          title: Text(
            "Explore India's \nMagnificence",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
              color: Colors.white,
              shadows: [
                Shadow(
                  blurRadius: 2.0,
                  color: Colors.grey,
                  offset: Offset(1.0, 1.0),
                ),
              ],
            ),
          ),
          backgroundColor: Color(0xFF008080),
          toolbarHeight: 90,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF008080), Color(0xFF000080)],
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
              ),
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50),
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.notifications),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('You have new notifications'),
                  ),
                );
              },
            ),
          ],
        ),
        drawer: Drawer(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF008080),
                  Color(0xFF000080),
                ],
              ),
            ),
            child: Column(
              children: [
                Expanded(
                  child: SizedBox(
                    width: 310, // set desired width here
                    child: DrawerHeader(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.12),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.network(
                              'https://firebasestorage.googleapis.com/v0/b/ticketless-ezentry.appspot.com/o/profile_images%2Fdata%2Fuser%2F0%2Fcom.example.myapp%2Fcache%2F56e412b8-0f2a-438d-b21b-d87d0571000f%2FIMG20230415175831.jpg?alt=media&token=fb9a062e-6ce4-4da1-abdf-4cdd1ad6b6a0',
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Abhishek Sharma",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "${FirebaseAuth.instance.currentUser!.email}",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.home, color: Colors.white),
                  title: Text(
                    'Home',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.account_circle, color: Colors.white),
                  title: Text(
                    'My Account',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        fullscreenDialog: true,
                        builder: (context) => AccountScreen(),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.book_online, color: Colors.white),
                  title: Text(
                    'My Bookings',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookingsListPage(),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.info_outline,
                    color: Colors.white,
                    size: 24.0,
                  ),
                  title: Text(
                    'Help & Support',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HelpPage()),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.info_outline,
                    color: Colors.white,
                    size: 24.0,
                  ),
                  title: Text(
                    'About',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AboutPage()),
                    );
                  },
                ),
                Divider(
                  color: Colors.white.withAlpha(80), // set opacity to 50%
                  thickness: 1, // set thickness to 2 pixels
                ),
                SizedBox(height: 170),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.teal,
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () async {
                      await clearSharedPreference();
                      // ignore: use_build_context_synchronously
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => SignInScreen()),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.exit_to_app, color: Colors.teal),
                          SizedBox(width: 10),
                          Text(
                            'Logout',
                            style: TextStyle(
                              color: Colors.teal,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                _buildMonumentBlock(
                    context,
                    'Taj Mahal',
                    'assets/images/TajView.jpg',
                    'The Taj Mahal is an ivory-white marble mausoleum on the right bank of the river Yamuna in the Indian city of Agra. It was commissioned in 1632 by the Mughal emperor, Shah Jahan, to house the tomb of his favourite wife, Mumtaz Mahal.'),
                SizedBox(height: 20),
                _buildMonumentBlock(
                    context,
                    'Charminar',
                    'assets/images/charmainar.jpeg',
                    'The Charminar is a monument and mosque located in Hyderabad, Telangana, India. The landmark has become a global icon of Hyderabad, listed among the most recognized structures of India.'),
                SizedBox(height: 20),
                _buildMonumentBlock(
                    context,
                    'Statue of Unity',
                    'assets/images/statue.jpg',
                    'The Statue of Unity is a colossal statue of Indian statesman and independence activist Sardar Vallabhbhai Patel, who was the first Deputy Prime Minister and Home minister of independent India. The statue is located in the state of Gujarat, India.'),
                SizedBox(height: 20),
                _buildMonumentBlock(
                    context,
                    'Qutab Minar',
                    'assets/images/monuments.jpg',
                    'The Qutub Minar is a minaret and "victory tower" that forms part of the Qutb complex, a UNESCO World Heritage Site in the Mehrauli area of Delhi, India. The tower is 73 metres (240 feet) tall and is made of red sandstone and marble.'),
                SizedBox(height: 20),
                SizedBox(height: 20),
                _buildMonumentBlock(
                    context,
                    'Gateway of India',
                    'assets/images/gateway.jpg',
                    'The Gateway of India is an arch monument built during the 20th century in Mumbai, India. The monument was erected to commemorate the landing of King George V and Queen Mary at Apollo Bunder on their visit to India in 1911.'),
                SizedBox(height: 20),
                _buildMonumentBlock(
                    context,
                    'Hawa Mahal',
                    'assets/images/hawamahal.jpg',
                    'Hawa Mahal is a palace in Jaipur, India. It is constructed of red and pink sandstone and was built in 1799 by Maharaja Sawai Pratap Singh. It is a five-storey structure that resembles a honeycomb.'),
                SizedBox(height: 20),
                _buildMonumentBlock(
                    context,
                    'Red Fort',
                    'assets/images/redfort.jpg',
                    'The Red Fort is a historic fort in the city of Delhi, India that served as the main residence of the Mughal Emperors. It was constructed in the 17th century and is made of red sandstone.'),
                SizedBox(height: 20),
                _buildMonumentBlock(
                    context,
                    'Lotus Temple',
                    'assets/images/lotustemple.jpg',
                    'The Lotus Temple is a Baháʼí House of Worship in New Delhi, India. It was completed in 1986 and is notable for its flower-like shape. It has won numerous architectural awards and has become a prominent attraction in Delhi.'),
                SizedBox(height: 20),
                _buildMonumentBlock(
                    context,
                    'Mysore Palace',
                    'assets/images/mysorepalace.jpg',
                    'The Mysore Palace is a historical palace in the city of Mysore in Karnataka, India. It is the official residence of the Wadiyar dynasty and was constructed in the 14th century. It is known for its grand architecture and is one of the most visited tourist attractions in India.')
              ],
            ),
          ),
        ));
  }

  Widget _buildMonumentBlock(
    BuildContext context,
    String title,
    String imagePath,
    String description,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 4,
            blurRadius: 4,
            offset: Offset(0, 3),
          ),
        ],
      ),
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: Image.asset(
              imagePath,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Color.fromARGB(255, 23, 116, 136) // button color
                    ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MonumentDetailsPage(
                        title: title,
                        image: imagePath,
                        description: description,
                      ),
                    ),
                  );
                },
                child: Text('View Details'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Color.fromARGB(255, 23, 116, 136) // button color
                    ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BookingPage(
                              monumentName: title,
                            )),
                  );
                },
                child: Text('Book Tickets'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
