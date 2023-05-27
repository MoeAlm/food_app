import 'package:flutter/material.dart';
import 'package:food_app_api/core/components/text_components.dart';
import 'package:velocity_x/velocity_x.dart';

import '../model/food_model.dart';

Widget favouriteItem(double height, double width,
    {required Food model, required Function() onPressed}) {
  return Card(
    color: Colors.white,
    child: Container(
      height: height * 0.2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            model.img,
            height: height * 0.3,
            width: width * 0.3,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildText(width,
                  text: model.title,
                  size: 0.065,
                  color: Colors.black,
                  weight: FontWeight.w600),
              buildText(width,
                  text: model.subTitle,
                  size: 0.05,
                  color: Colors.black45,
                  weight: FontWeight.w600),
              buildText(
                width,
                text: '\$${model.price}',
                size: 0.08,
                color: Colors.black45,
                weight: FontWeight.w600,
              ),
            ],
          ).py12(),
          IconButton(
            onPressed: onPressed,
            icon: const Icon(Icons.delete),
          )
        ],
      ),
    ),
  );
}