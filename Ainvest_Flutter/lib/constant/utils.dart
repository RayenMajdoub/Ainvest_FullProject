import 'package:flutter/material.dart';

class Utils {
  static String baseurl = "http://locahost:8000";
}

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
    ),
  );
}
