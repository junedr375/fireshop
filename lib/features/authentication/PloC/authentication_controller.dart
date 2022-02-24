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

  void doSigninWithPhone() async {
    if (formGlobalKey.currentState!.validate()) {
      formGlobalKey.currentState!.save();

      if (isOtpSent.value) {
        currentUser = await firebaseClient.verifyOtp(
            otpText: otpController.text.trim(), verifyID: verificationId);
        if (currentUser != null) {
          navigateTOHomeScreen();
        }
      } else {
        final FirebaseAuth auth = FirebaseAuth.instance;
        await auth.verifyPhoneNumber(
            phoneNumber: "+91" + phoneController.text,
            verificationCompleted: (phoneAuthCredential) async {},
            verificationFailed: (verificationFailed) async {
              Get.snackbar(
                  'Verification Failed', verificationFailed.message ?? '');
            },
            codeSent: (verifyId, resendingToken) async {
              verificationId = verifyId;
              print(verificationId);
              print(verifyId);
              update();
            },
            codeAutoRetrievalTimeout: (verificationId) async {});
        // await firebaseClient
        //     .verifyPhoneNumber(phoneController.text.trim())
        //     .then((value) {
        //   verificationId = value;
        // });
        isOtpSent.value = true;
        print('VerificationId: ' + verificationId);
        update();
      }
    }
  }

  void navigateTOHomeScreen() {
    Get.off(() => HomeScreen(), arguments: {'user': currentUser});
  }
}
