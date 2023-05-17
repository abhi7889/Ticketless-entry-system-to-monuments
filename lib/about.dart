import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Image.asset(
              'assets/images/logo1.png',
              height: 150,
            ),
            SizedBox(height: 20),
            Text(
              'About the App',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Our app is a solution to the Smart India Problem Statement, providing a seamless and hassle-free experience for tourists and travelers by offering ticketless entry to popular monuments and tourist attractions. With our app, users can easily plan their trips and save time, making their travels more enjoyable and stress-free.",
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 40),
            Text(
              'Meet the Team',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    // CircleAvatar(
                    //   radius: 50,
                    //   backgroundImage: AssetImage(
                    //     'assets/images/john_doe.jpg',
                    //   ),
                    //   backgroundColor: Colors.teal,
                    // ),
                    SizedBox(height: 10),
                    Text(
                      'Abhishek Sharma',
                      style: TextStyle(fontSize: 18),
                    ),
                    // Text(
                    //   'Lead Developer',
                    //   style: TextStyle(fontSize: 16, color: Colors.grey),
                    // ),
                  ],
                ),
                Column(
                  children: [
                    // CircleAvatar(
                    //   radius: 50,
                    //   backgroundImage: AssetImage(
                    //     'assets/images/bob_johnson.jpg',
                    //   ),
                    //   backgroundColor: Colors.teal,
                    // ),
                    SizedBox(height: 10),
                    Text(
                      'Dhara Vadagasiya',
                      style: TextStyle(fontSize: 18),
                    ),
                    // Text(
                    //   'Backend Developer',
                    //   style: TextStyle(fontSize: 16, color: Colors.grey),
                    // ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 40),
            Text(
              'Contact Us',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'If you have any questions or feedback about our app, please feel free to contact us at:',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.email),
                SizedBox(width: 10),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'abhishek131214@gmail.com',
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.phone),
                SizedBox(width: 10),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    '+91 6005734979',
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
