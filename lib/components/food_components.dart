import 'dart:math';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import '../core/model/food_model.dart';

Widget foodItem(double height, double width, {required Food model, required Widget icon,required Function() onPressed}) {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
    color: Colors.grey.shade200,
    elevation: 0,
    child: Stack(
      alignment: Alignment.center,
      children: [
        Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: height * 0.082,
              child: Image.asset(
                model.img,
                height: height * 0.35,
                width: width * 0.35,
              ),
            ).pOnly(top: 16),
            Text(
              model.title,
              style: TextStyle(fontSize: width * 0.055, fontWeight: FontWeight.bold),
            ),
            Text(
              model.subTitle,
              style: TextStyle(fontSize: width * 0.04, color: Colors.black45),
            ),
            Text(
              model.price,
              style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black45),
            ),
          ],
        ),
        Positioned(
          top: -2,
          right: -1,
          child: IconButton(
            onPressed: onPressed,
            icon: icon,
            ),
          ),
      ],
    ),
  ).py4();
}
