import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';


class FirebaseClient {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<User?> signInWithGoogle({required BuildContext context}) async {
    User? user;

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      user = await singinWithCredential(credential);
    }

    return user;
  }

  Future<User?> singinWithCredential(AuthCredential credential) async {
    User? user;
    try {
      final UserCredential userCredential =
          await auth.signInWithCredential(credential);
      user = userCredential.user;
      return user;
    } catch (e) {
      print(e.toString());
    }
  }

  Future<String> verifyPhoneNumber(String phoneNumber) async {
    String verificationId = '';

    return verificationId;
  }

  Future<User?> verifyOtp(
      {required String otpText, required String verifyID}) async {
    final phoneAuthCred = PhoneAuthProvider.credential(
        verificationId: verifyID, smsCode: otpText);
    return await singinWithCredential(phoneAuthCred);
  }

  Future<bool?> logOut() async {
    try {
      await auth.signOut();
      await googleSignIn.signOut();
      print('User Signout');
      return true;
    } catch (e) {
      print(e.toString());
    }
  }
}

SnackBar customSnackBar({required String content}) {
  return SnackBar(
    backgroundColor: Colors.black,
    content: Text(
      content,
      style: const TextStyle(color: Colors.redAccent, letterSpacing: 0.5),
    ),
  );
}
