import 'package:fireshop/core/utils/app_theme_data.dart';
import 'package:fireshop/core/utils/get_of_context.dart';
import 'package:fireshop/features/checkout/PLoC/cart_controller.dart';
import 'package:fireshop/features/home/PloC/components/food_type.dart';
import 'package:fireshop/features/home/PloC/components/item_modifier.dart';
import 'package:fireshop/features/home/PloC/home_controller.dart';
import 'package:fireshop/features/home/data/models/resturant_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FoodItem extends StatelessWidget {
  final CategoryDish food;
  final HomeController homeController;
  final CartController cartController;
  FoodItem(
      {Key? key,
      required this.food,
      required this.homeController,
      required this.cartController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = getThemeData(context);
    final screenWidhth = getMediaQuerySize(context).width;
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(color: Colors.white),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FoodType(foodType: food.dishType ?? 0).paddingOnly(right: 5),
                  SizedBox(
                    width: screenWidhth * 0.55,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(food.dishName ?? '',
                                style: theme.textTheme.headline4)
                            .paddingOnly(bottom: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                '${food.dishCurrency ?? ''}  ${food.dishPrice}',
                                style: theme.textTheme.headline5),
                            Text(food.dishCalories.toString() + ' calories',
                                style: theme.textTheme.headline5),
                          ],
                        ).paddingOnly(bottom: 10),
                        Text(food.dishDescription ?? '',
                                style: theme.textTheme.bodyText1)
                            .paddingOnly(bottom: 10),
                        ItemModifier(
                            food: food, cartController: cartController),
                        Visibility(
                          visible: food.addonCat?.isNotEmpty ?? false,
                          child: Text(
                            'Customizations Available',
                            style: theme.textTheme.headline4?.copyWith(
                                color: Colors.red, fontWeight: FontWeight.w400),
                          ),
                        ).paddingSymmetric(vertical: 8)
                      ],
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    height: 80,
                    width: screenWidhth * 0.2,
                    child: Image.network(
                      food.dishImage ?? '',
                      fit: BoxFit.fill,
                      loadingBuilder: (context, child, loadingProgress) =>
                          Container(
                              alignment: Alignment.center,
                              height: 30,
                              width: 30,
                              child: const CircularProgressIndicator()),
                      errorBuilder: (context, error, stackTrace) => const Icon(
                        Icons.food_bank,
                        size: 80,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ).paddingAll(10),
        Divider(
          height: 1,
          thickness: 1,
          color: Colors.grey[300],
        )
      ],
    );
  }
}
