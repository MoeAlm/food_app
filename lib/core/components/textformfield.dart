import 'package:flutter/material.dart';

Widget defaultTextFormField(
    {required String label,
    required String hint,
    required TextInputType inputType,
    Function(String)? onChanged,
    IconButton? iconButton,
    bool obscureText = false}) {
  return TextFormField(
    decoration: InputDecoration(
        labelText: label, hintText: hint, suffixIcon: iconButton),
    validator: (value) {
      if (value!.isEmpty) {
        return 'Field is required';
      }
      return null;
    },
    onChanged: onChanged,
    keyboardType: inputType,
    obscureText: obscureText,
  );
}
