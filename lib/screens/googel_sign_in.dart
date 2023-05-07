import 'package:flutter/foundation.dart'; // Required for checking whether the app is running on the web
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth _auth =
    FirebaseAuth.instance; // Instance of the FirebaseAuth class
GoogleSignIn _googleSignIn =
    GoogleSignIn(); // Instance of the GoogleSignIn class

class GoogleSignInHelper {
  static Future<UserCredential> signInWithGoogle() async {
    if (kIsWeb) {
      // If the app is running on the web
      _googleSignIn = GoogleSignIn();
    } else {
      // If the app is running on a mobile device
      _googleSignIn = GoogleSignIn(
        scopes: <String>[
          'email',
          'https://www.googleapis.com/auth/contacts.readonly',
        ],
      );
    }

    // Prompt the user to sign in with Google, and obtain an OAuthCredential object using the user's access token and ID token
    final GoogleSignInAccount? googleSignInAccount =
        await _googleSignIn.signIn();
    if (googleSignInAccount != null) {
      // If signing in with Google was successful
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      // Sign in the authenticated user with Firebase by calling signInWithCredential using the OAuthCredential
      return await _auth.signInWithCredential(credential);
    }

    // If signing in with Google wasn't successful, throw an exception
    throw FirebaseAuthException(code: 'ERROR_MISSING_GOOGLE_AUTH_TOKEN');
  }
}
