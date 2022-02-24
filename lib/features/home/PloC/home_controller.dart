import 'package:firebase_auth/firebase_auth.dart';
import 'package:fireshop/features/authentication/PloC/authentication.dart';
import 'package:fireshop/features/authentication/data/firebase_client/firebase_client.dart';
import 'package:fireshop/features/checkout/PLoC/cart_screen.dart';
import 'package:fireshop/features/home/data/api_client/api_client.dart';
import 'package:fireshop/features/home/data/models/resturant_model.dart';
import 'package:fireshop/features/home/data/repository/repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  HomeApiClient homeApiClient = HomeApiClient();
  FirebaseClient firebaseClient = FirebaseClient();

  late HomeRepository homeRepository;
  final resturant = Resturant().obs;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final isLoading = true.obs;
  late TabController tabController;
  final tabLength = 0.obs;
  late User? currentUser;
  //final currentCart = <CategoryDish>[].obs;

  @override
  void onInit() {
    currentUser = Get.arguments['user'];
    update();
    homeRepository = HomeRepository(homeApiClient: homeApiClient);
    getResturantData();
    super.onInit();
  }

  void getResturantData() async {
    resturant.value = await homeRepository.getResturantData();
    tabLength.value = resturant.value.tableMenuList?.length ?? 0;
    tabController = TabController(length: tabLength.value, vsync: this);
    isLoading.value = false;
    update();
  }

  void onCartClick() {
    Get.to(() => CartScreen(),
        transition: Transition.native, duration: const Duration(seconds: 1));
  }

  void openDrawer() {
    scaffoldKey.currentState?.openDrawer();
  }

  void onLogout() async {
    try {
      final isLoggedOut = await firebaseClient.logOut();

      if (isLoggedOut ?? false) {
        Future.delayed(const Duration(seconds: 2), () {
          Get.offAll(() => AuthenticationScreen());
        });
      } else {
        Get.snackbar('Failed to Singout at this moment', '',
            backgroundColor: Colors.black, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar(e.toString(), '',
          backgroundColor: Colors.black, colorText: Colors.white);
    }
  }
}
