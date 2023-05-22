import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

Widget ourButton({
  onPress,
  color,
  textColor,
  String? title,
}) {
  return ElevatedButton(
    onPressed: onPress,
    style: ElevatedButton.styleFrom(
      backgroundColor: color,
      padding: const EdgeInsets.all(12),
    ),
    child: title!.text.color(textColor).make(),
  );
}
