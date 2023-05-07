// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MonumentDetailsPage extends StatefulWidget {
  final String title;
  final String image;
  final String description;

  const MonumentDetailsPage({
    required this.title,
    required this.image,
    required this.description,
  });

  @override
  _MonumentDetailsPageState createState() => _MonumentDetailsPageState();
}

class _MonumentDetailsPageState extends State<MonumentDetailsPage> {
  bool _showDescription = false;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () {
              setState(() {
                _showDescription = !_showDescription;
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              widget.image,
              height: 300,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            Visibility(
              visible: _showDescription,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  widget.description,
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Nearby Services',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20),
            ListTile(
              title: Text(
                'Food',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text('View nearby restaurants on Google Maps'),
              trailing: Icon(Icons.emoji_food_beverage_rounded),
              onTap: () async {
                final String query = 'restaurants near ${widget.title}';
                final String googleUrl =
                    'https://www.google.com/maps/search/?api=1&query=$query';
                try {
                  await launch(googleUrl);
                } catch (e) {
                  print('Could not launch $googleUrl');
                }
              },
            ),
            Divider(),
            ListTile(
              title: Text(
                'Hotels',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text('View nearby hotels on Google Maps'),
              trailing: Icon(Icons.local_hotel_rounded),
              onTap: () async {
                final String query = 'hotels near ${widget.title}';
                final String googleUrl =
                    'https://www.google.com/maps/search/?api=1&query=$query';
                try {
                  await launch(googleUrl);
                } catch (e) {
                  print('Could not launch $googleUrl');
                }
              },
            ),
            Divider(),
            ListTile(
              title: Text(
                'Police Stations',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text('View nearby Police Station on Google Maps'),
              trailing: Icon(Icons.local_police_rounded),
              onTap: () async {
                final String query = 'Police Station near ${widget.title}';
                final String googleUrl =
                    'https://www.google.com/maps/search/?api=1&query=$query';
                try {
                  await launch(googleUrl);
                } catch (e) {
                  print('Could not launch $googleUrl');
                }
              },
            ),
            Divider(),
            ListTile(
              title: Text(
                'ATM',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text('View nearby ATMs on Google Maps'),
              trailing: Icon(Icons.local_atm),
              onTap: () async {
                final String query = 'ATMs near ${widget.title}';
                final String googleUrl =
                    'https://www.google.com/maps/search/?api=1&query=$query';
                try {
                  await launch(googleUrl);
                } catch (e) {
                  print('Could not launch $googleUrl');
                }
              },
            ),
            Divider(),
            ListTile(
              title: Text(
                'Medical Services',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text('View nearby medical services on Google Maps'),
              trailing: Icon(Icons.local_hospital),
              onTap: () async {
                final String query = 'medical services near ${widget.title}';
                final String googleUrl =
                    'https://www.google.com/maps/search/?api=1&query=$query';
                try {
                  await launch(googleUrl);
                } catch (e) {
                  print('Could not launch $googleUrl');
                }
              },
            ),
            Divider(),
            ListTile(
              title: Text(
                'Nearby Attractions',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text('View nearby attractions on Google Maps'),
              trailing: Icon(Icons.location_on),
              onTap: () async {
                final String query = 'attractions near ${widget.title}';
                final String googleUrl =
                    'https://www.google.com/maps/search/?api=1&query=$query';
                try {
                  await launch(googleUrl);
                } catch (e) {
                  print('Could not launch $googleUrl');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
