import 'package:fireshop/features/checkout/data/repository/repositiore.dart';
import 'package:fireshop/features/home/PloC/home.dart';
import 'package:fireshop/features/home/data/models/resturant_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  final totalPrice = 0.0.obs;
  final totalItems = 0.obs;
  final currentCart = <CategoryDish>[].obs;
  CartRepository cartRepository = CartRepository();

  void addItemToCart(CategoryDish food) {
    if (currentCart.contains(food)) {
      final index = currentCart.indexOf(food);
      currentCart.removeAt(index);
      food.copyWith(itemsOnCart: food.itemsOnCart++);
      currentCart.insert(index, food);
      updateTotalCartAmount();
      update();
      return;
    } else {
      food.copyWith(itemsOnCart: food.itemsOnCart++);
      currentCart.add(food);
      updateTotalCartAmount();
      update();
      return;
    }
  }

  void removeItemFromCart(CategoryDish food) {
    if (currentCart.contains(food)) {
      final index = currentCart.indexOf(food);
      currentCart.removeAt(index);
      if (food.itemsOnCart == 1) {
        updateTotalCartAmount();
        return;
      }
      food.copyWith(itemsOnCart: food.itemsOnCart--);
      currentCart.insert(index, food);
      updateTotalCartAmount();
      update();
      return;
    } else {
      updateTotalCartAmount();
      return;
    }
  }

  void updateTotalCartAmount() {
    totalPrice.value = 0;
    for (int i = 0; i < currentCart.length; i++) {
      totalPrice.value +=
          currentCart[i].itemsOnCart * (currentCart[i].dishPrice ?? 0);
    }
    updateTotalItems();
    update();
  }

  void updateTotalItems() {
    totalItems.value = 0;
    for (int i = 0; i < currentCart.length; i++) {
      totalItems.value += currentCart[i].itemsOnCart;
    }
    update();
  }

  void placeOrder() {
    if (cartRepository.placeOrder()) {
      Get.snackbar('Order Succesfully Placed', '',
          backgroundColor: Colors.black, colorText: Colors.white);
      clearItemsFromFood();
      currentCart.clear();
      totalItems.value = 0;
      totalPrice.value = 0;
      update();
    }
  }

  void clearItemsFromFood() {
    for (int i = 0; i < currentCart.length; i++) {
      currentCart[i].itemsOnCart = 0;
    }
    update();
  }
}
