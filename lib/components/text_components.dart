import 'package:flutter/material.dart';

Widget buildText(double width, {required String text,required double size, required Color color,FontWeight? weight}) {
  return Text(text, style: TextStyle(fontSize: size * width, color: color, fontWeight: weight),);
}
