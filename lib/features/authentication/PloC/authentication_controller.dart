import 'package:firebase_auth/firebase_auth.dart';
import 'package:fireshop/features/authentication/data/firebase_client/firebase_client.dart';
import 'package:fireshop/features/home/PloC/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final phoneController = TextEditingController();
  final otpController = TextEditingController();
  FirebaseClient firebaseClient = FirebaseClient();
  final isOtpSent = false.obs;
  final formGlobalKey = GlobalKey<FormState>();
  String verificationId = '';
  late User? currentUser;

  void doGoggleSignIn(BuildContext context) async {
    currentUser = await firebaseClient.signInWithGoogle(context: context);
    navigateTOHomeScreen();
  }


  void navigateTOHomeScreen() {
    Get.off(() => HomeScreen(), arguments: {'user': currentUser});
  }
}
