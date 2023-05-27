import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

Widget buildListTile(double width, double height,
    {required String text, required String hint, IconButton? iconButton, TextEditingController? controller, void Function(String)? onChanged}) {
  return ListTile(
    title: Text(
      hint,
      style: TextStyle(fontSize: width * 0.035),
    ),
    subtitle: TextField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(hintText: hint, suffixIcon: iconButton),
      style: TextStyle(fontSize: width * 0.047),
    ),
  ).pOnly(bottom: height * 0.015);
}
