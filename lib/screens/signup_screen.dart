import 'package:EZEntry/screens/signin_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:EZEntry/reusable_widgets/reusable_widget.dart';
import 'package:EZEntry/utils/color_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _confirmPasswordTextController =
      TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _firstNameTextController = TextEditingController();
  TextEditingController _lastNameTextController = TextEditingController();

  @override
  void dispose() {
    _emailTextController.dispose();
    _passwordTextController.dispose();
    _confirmPasswordTextController.dispose();
    _firstNameTextController.dispose();
    _lastNameTextController.dispose();
    super.dispose();
  }

  Future signUp() async {
    try {
      // check password contains capital letter and unique symbols
      RegExp regex =
          new RegExp(r'^(?=.*?[A-Z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
      if (!regex.hasMatch(_passwordTextController.text)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Password must contain a capital letter and unique symbols!'),
            duration: Duration(seconds: 2),
          ),
        );
        return;
      }

      // create user
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailTextController.text.trim(),
        password: _passwordTextController.text.trim(),
      );
      await addUserDetails(
          _firstNameTextController.text.trim(),
          _lastNameTextController.text.trim(),
          _emailTextController.text.trim());
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('You have successfully signed up!'),
          duration: Duration(seconds: 2),
        ),
      );
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    } catch (e) {
      print('Error: $e');
    }
  }

  Future addUserDetails(String firstName, String lastName, String email) async {
    await FirebaseFirestore.instance.collection('users').add({
      'first name': firstName,
      'last name': lastName,
      'email': email,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            "Sign Up",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                hexStringToColor("FF671F"),
                hexStringToColor("06038D"),
                hexStringToColor("046A38")
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 120, 20, 0),
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 20,
                  ),
                  reusableTextField(
                    "First Name",
                    Icons.person_outline,
                    false,
                    _firstNameTextController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  reusableTextField(
                    "Last Name",
                    Icons.person_outline,
                    false,
                    _lastNameTextController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  reusableTextField(
                    "Email",
                    Icons.email_outlined,
                    false,
                    _emailTextController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  reusableTextField(
                    "Password",
                    Icons.lock_outlined,
                    true,
                    _passwordTextController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  reusableTextField(
                    "Confirm Password",
                    Icons.lock_outlined,
                    true,
                    _confirmPasswordTextController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  firebaseUIButton(
                    context,
                    "Sign Up",
                    () async {
                      if (_passwordTextController.text !=
                          _confirmPasswordTextController.text) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Passwords do not match!'),
                          duration: Duration(seconds: 2),
                        ));
                        return;
                      }
                      await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                        email: _emailTextController.text.trim(),
                        password: _passwordTextController.text.trim(),
                      );
                      await addUserDetails(
                          _firstNameTextController.text.trim(),
                          _lastNameTextController.text.trim(),
                          _emailTextController.text.trim());
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('You have successfully signed up!'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                      // ignore: use_build_context_synchronously
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.fromLTRB(50, 15, 50, 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignInScreen(),
                        ),
                      );
                    },
                    child: RichText(
                      text: TextSpan(
                        text: "Already have an account? ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: "Sign in",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
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
