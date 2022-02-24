import 'package:flutter/material.dart';

class FoodType extends StatelessWidget {
  final int foodType;
  const FoodType({Key? key, required this.foodType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color typeColor = foodType == 1 ? Colors.red : Colors.green;
    return Container(
      height: 20,
      width: 20,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: typeColor, width: 2),
      ),
      child: Container(
        height: 12,
        width: 12,
        decoration: BoxDecoration(shape: BoxShape.circle, color: typeColor),
      ),
    );
  }
}
