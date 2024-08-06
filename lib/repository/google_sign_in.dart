import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInRepository {
  static Future<(String?, UserCredential?)> signInWithGoogle() async {
    GoogleSignInAccount? googleUser;
    GoogleSignInAuthentication? googleAuth;
    try {
      googleUser = await GoogleSignIn().signIn();

      googleAuth = await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      UserCredential? userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      return (null, userCredential);
    } on Exception catch (e) {
      log(e.toString());
      return (e.toString(), null);
    }
  }

  static Future<void> logout() async {
    await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
  }
}
