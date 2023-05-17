import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class AccountScreen extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('users');
  final FirebaseStorage _storage = FirebaseStorage.instance;

  String _fullName = '';
  String _phone = '';
  late File _imageFile;
  late String _imageUrl = '';
  bool _isLoading = true;

  String _fullNameInput = '';
  String _phoneInput = '';
  String _ageInput = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() async {
    try {
      final userSnapshot = await _usersCollection.doc('users').get();
      setState(() {
        _fullName = userSnapshot.get('full_name');
        _phone = userSnapshot.get('phone');
        _imageUrl = userSnapshot.get('profile_image_url');
        _isLoading = false;
      });
    } catch (e) {
      print('Error loading user data: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future _uploadImage() async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _imageFile = File(pickedFile.path);
        });
        final ref = _storage.ref().child('profile_images/${_imageFile.path}');
        final uploadTask = ref.putFile(_imageFile);
        final taskSnapshot = await uploadTask;
        final downloadUrl = await taskSnapshot.ref.getDownloadURL();
        setState(() {
          _imageUrl = downloadUrl;
        });
        await _usersCollection
            .doc('users')
            .update({'profile_image_url': _imageUrl});
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Profile image uploaded successfully'),
          duration: Duration(seconds: 2),
        ));
      }
    } catch (e) {
      print('Error uploading profile image: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to upload profile image'),
        duration: Duration(seconds: 2),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blueGrey, Colors.grey],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          title: Text('My Profile', style: TextStyle(fontFamily: 'Montserrat')),
          backgroundColor: Colors.blueGrey,
        ),
        body: _isLoading
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.white, Colors.grey[200]!],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        GestureDetector(
                          onTap: _uploadImage,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              CircleAvatar(
                                radius: 50,
                                backgroundImage: _imageUrl.isNotEmpty
                                    ? NetworkImage(_imageUrl)
                                    : null,
                                child: _imageUrl.isEmpty
                                    ? Icon(Icons.person)
                                    : null,
                              ),
                              Icon(Icons.camera_alt,
                                  size: 30, color: Colors.white),
                            ],
                          ),
                        ),
                        SizedBox(height: 16.0),
                        Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Full Name',
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0,
                                  ),
                                ),
                                SizedBox(height: 8.0),
                                TextField(
                                  controller: _fullNameController,
                                  onChanged: (value) {
                                    setState(() {
                                      _fullNameInput = value;
                                    });
                                  },
                                  decoration: InputDecoration(
                                    hintText: _fullName,
                                    // Add any desired styling or configuration
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 16.0),
                        Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Email',
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0,
                                  ),
                                ),
                                SizedBox(height: 8.0),
                                Text(
                                  "${FirebaseAuth.instance.currentUser!.email}",
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 16.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 16.0),
                        Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Phone Number',
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0,
                                  ),
                                ),
                                SizedBox(height: 8.0),
                                TextField(
                                  controller: _phoneController,
                                  onChanged: (value) {
                                    setState(() {
                                      _phoneInput = value;
                                    });
                                  },
                                  decoration: InputDecoration(
                                    hintText: _phone,
                                    // Add any desired styling or configuration
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 16.0),
                        Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Age',
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0,
                                  ),
                                ),
                                SizedBox(height: 8.0),
                                TextField(
                                  controller: _ageController,
                                  onChanged: (value) {
                                    setState(() {
                                      _ageInput = value;
                                    });
                                  },
                                  decoration: InputDecoration(
                                    hintText: "21",
                                    // Add any desired styling or configuration
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 16.0),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _fullNameController.text = _fullName;
                              _phoneController.text = _phone;
                              _ageController.text = "21";
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueGrey,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 16.0),
                          ),
                          child: Text(
                            'Edit Profile',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                        SizedBox(height: 16.0),
                        ElevatedButton(
                          onPressed: () async {
                            try {
                              await _usersCollection.doc('users').update({
                                'full_name': _fullNameInput,
                                'phone': _phoneInput,
                              });
                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text('Profile saved successfully'),
                                duration: Duration(seconds: 2),
                              ));
                            } catch (e) {
                              print('Error saving profile: $e');
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text('Failed to save profile'),
                                duration: Duration(seconds: 2),
                              ));
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueGrey,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 16.0),
                          ),
                          child: Text(
                            'Save Profile',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                        SizedBox(height: 16.0),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 16.0),
                          ),
                          child: Text(
                            'Log Out',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ));
  }
}
