// ignore_for_file: use_key_in_widget_constructors, deprecated_member_use

import 'package:ainvest/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:ainvest/screens/home_screen/home/widget/best_offer.dart';
import 'package:ainvest/screens/home_screen/home/widget/categories.dart';
import 'package:ainvest/screens/home_screen/home/widget/custom_app_bar.dart';
import 'package:ainvest/screens/home_screen/home/widget/custom_bottom_navigation_bar.dart';
import 'package:ainvest/screens/home_screen/home/widget/recommended_house.dart';
import 'package:ainvest/screens/home_screen/home/widget/search_input.dart';
import 'package:ainvest/screens/home_screen/home/widget/welcome_text.dart';
class HomePage extends StatelessWidget {
  static String route = "home";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBF5F7),
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            WelcomeText(),
            SearchInput(),
            Categories(),
            RecommendedHouse(),
            Container(
                color: kSecondaryColor,
                height: 500,
                width: 800,
                child: Container()),
            BestOffer()
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}
