import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

Widget customTextField(
    {String? title, String? hint, controller, isPass, isEmail}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      title!.text.color(Colors.black).size(16).make(),
      5.heightBox,
      TextFormField(
        validator: isEmail
            ? (value) {
                if (value == null ||
                    value.isEmpty ||
                    !value.contains('@') ||
                    value.contains('@xyz') ||
                    value.contains('@example') ||
                    value.contains('@dummy')) {
                  return 'Invalid Email';
                }
                return null;
              }
            : null,
        obscureText: isPass,
        controller: controller,
        decoration: InputDecoration(
          hintStyle: const TextStyle(
            color: Colors.grey,
          ),
          hintText: hint,
          isDense: true,
          fillColor: Colors.grey,
          filled: true,
          border: InputBorder.none,
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
            ),
          ),
        ),
      ),
      5.heightBox,
    ],
  );
}
