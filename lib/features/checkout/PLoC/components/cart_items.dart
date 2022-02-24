import 'package:fireshop/core/utils/app_theme_data.dart';
import 'package:fireshop/core/utils/get_of_context.dart';
import 'package:fireshop/features/checkout/PLoC/cart_controller.dart';
import 'package:fireshop/features/home/PloC/components/food_type.dart';
import 'package:fireshop/features/home/PloC/components/item_modifier.dart';
import 'package:fireshop/features/home/data/models/resturant_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartItemsWidget extends StatelessWidget {
  final CategoryDish food;

  final CartController cartController;
  const CartItemsWidget(
      {Key? key, required this.food, required this.cartController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = getThemeData(context);
    final screenWidhth = getMediaQuerySize(context).width;
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(color: Colors.white),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FoodType(foodType: food.dishType ?? 0).paddingOnly(right: 5),
                  SizedBox(
                    width: screenWidhth * 0.25,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(food.dishName ?? '',
                                style: theme.textTheme.headline4)
                            .paddingOnly(bottom: 15),
                        Text(
                          '${food.dishCurrency ?? ''}  ${food.dishPrice}',
                          style: theme.textTheme.headline5
                              ?.copyWith(color: Colors.grey[600]),
                        ),
                        Text(
                          food.dishCalories.toString() + ' calories',
                          style: theme.textTheme.headline6
                              ?.copyWith(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ).paddingOnly(right: 5),
                  ItemModifier(
                    food: food,
                    cartController: cartController,
                    backGroungColor: Colors.green[900],
                  ).paddingOnly(right: 5),
                  _TotalPriceWidget(food: food, cartController: cartController)
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}

class _TotalPriceWidget extends StatelessWidget {
  final CategoryDish food;
  final CartController cartController;
  const _TotalPriceWidget(
      {Key? key, required this.food, required this.cartController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = getThemeData(context);
    final index = cartController.currentCart.indexOf(food);
    return Obx(
      () => Text(
        'INR ${((cartController.currentCart[index].dishPrice ?? 0) * cartController.currentCart[index].itemsOnCart).toPrecision(2)}',
        style: theme.textTheme.headline4?.copyWith(color: Colors.grey[600]),
      ),
    );
  }
}
