import 'package:flutter/material.dart';
import 'package:pharus/constant/colors.dart';

showSnac(String data, context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: border,
      content: Text(data,
          style: TextStyle(
            color: Colors.white,
          ))));
}
