import 'dart:math' as math;

import 'package:ainvest/utils/constants.dart';
import 'package:flutter/material.dart';
import 'components/center_widget/center_widget.dart';
import 'components/login_content.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();

  static String route = "Login" ;
}

class _LoginScreenState extends State<LoginScreen> {
  Widget logo(double screenWidth) {
    return Container(
      width: screenWidth,
      height: 250,
      padding: EdgeInsets.all(5),
      child: Image.asset(
          "assets/images/323075626_1222475965329299_1627377637317812070_n.png"),
    );
  }

  Widget bottomWidget(double screenWidth, double screenheight) {
    return Container(
      width: screenWidth,
      height: screenheight,
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(50.0),
          color: kBackgroundColor),
    );
  }

  Widget topWidget(double screenWidth) {
    return Transform.rotate(
      angle: -35 * math.pi / 180,
      child: Container(
        width: 1.2 * screenWidth,
        height: 1.2 * screenWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(150),
          gradient: const LinearGradient(
            begin: Alignment(-0.2, -0.8),
            end: Alignment.bottomCenter,
            colors: [
              kPrimaryColor,
              kBackgroundColorLight,
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          /*  Positioned(
            top: -160,
            left: -30,
            child: topWidget(screenSize.width),
          ),*/

          Positioned(
            bottom: 700,
            child: logo(screenSize.width),
          ),
          Positioned(
            bottom: -300,
            child: bottomWidget(screenSize.width, screenSize.height),
          ),
          const LoginContent(),
        ],
      ),
    );
  }
}
