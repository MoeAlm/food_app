import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../core/model/category_model.dart';

Widget categoryItem(double height, double width, {required Color color,required CategoryModel model}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Card(
        elevation: 0,
        color: color,
        child: SizedBox(
          height: height * 0.09,
          child: Image.asset(
            model.icon,
          ).p(8),
        ),
      ),
      Text(
        model.title,
        style: TextStyle(fontSize: width * 0.04, fontWeight: FontWeight.bold),
      )
    ],
  );
}