import 'package:ainvest/utils/constants.dart';
import 'package:flutter/material.dart';

Widget text_filed_with_title(String titre, TextEditingController controller) {
  return Column(children: [
    Text(
      titre,
      style: const TextStyle(
          fontWeight: FontWeight.bold, color: kSecondaryColor, fontSize: 22),
    ),
    const SizedBox(
      height: 40,
    ),
    SizedBox(
      height: 60,
      width: 800,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: kPrimaryColor, strokeAlign: 2),
              borderRadius: BorderRadius.circular(50)),
        ),
      ),
    ),
    SizedBox(
      height: 40,
    ),
  ]);
}

Widget Titre_avec_underbar(String titre, Color barcolor) {
  return Column(children: [
    Text(
      titre,
      style: const TextStyle(
          color: kSecondaryColor,
          fontSize: 24,
          fontWeight: FontWeight.bold,
          height: 1.5),
      textAlign: TextAlign.center,
    ),
    const SizedBox(
      height: 10,
    ),
    Container(
      height: 5,
      width: 80,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50), color: barcolor),
    ),
  ]);
}
