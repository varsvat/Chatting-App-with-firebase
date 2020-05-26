import 'package:flutter/material.dart';

Widget appBarMain(BuildContext context, String title) {
  return AppBar(
    centerTitle: true,
    backgroundColor: Colors.black87,
    title: Text(
      title,
      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
    ),
  );
}

TextStyle textstyle(Color color) {
  return TextStyle(color: color, fontSize: 16);
}
