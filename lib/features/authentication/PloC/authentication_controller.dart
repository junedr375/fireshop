import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fireshop/core/Storage/shared_preference.dart';
import 'package:fireshop/features/authentication/data/firebase_client/firebase_client.dart';
import 'package:fireshop/features/home/PloC/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final phoneController = TextEditingController();
  final otpController = TextEditingController();

  FirebaseClient firebaseClient = FirebaseClient();
  final isLoading = false.obs;
  final formGlobalKey = GlobalKey<FormState>();
  String verificationId = '';
  late User? currentUser;

  @override
  void onInit() {
    checkIsLoggenIn();
    super.onInit();
  }

  void checkIsLoggenIn() async {
    isLoading(true);

    AppStorage.getBool(AppStorageKeys.isLoggedIn).then((value) async {
      if (value) {
        try {
          currentUser = await firebaseClient.getCurrentUser();
          navigateToHomeScreen();
        } catch (e) {
          log(e.toString());
        } finally {
          isLoading(false);
        }
      } else {
        isLoading(false);
      }
    });
  }

  void doGoggleSignIn(BuildContext context) async {
    try {
      isLoading(true);
    currentUser = await firebaseClient.signInWithGoogle(context: context);
      AppStorage.setBool(AppStorageKeys.isLoggedIn, true);
      isLoading(false);
      navigateToHomeScreen();
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading(false);
    }
  }

  void navigateToHomeScreen() {
    Get.off(() => HomeScreen(), arguments: {'user': currentUser});
  }
}
