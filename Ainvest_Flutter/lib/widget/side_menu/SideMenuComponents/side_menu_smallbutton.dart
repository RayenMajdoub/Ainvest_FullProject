import 'package:ainvest/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ainvest/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SideMenuButtonS extends StatefulWidget {
  final String title;
  final VoidCallback tap;

  const SideMenuButtonS({
    Key? key,
    required this.title,
    required this.tap,
  }) : super(key: key);

  @override
  State<SideMenuButtonS> createState() => _SideMenuButtonSState();
}

class _SideMenuButtonSState extends State<SideMenuButtonS> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) {
        setState(() {
          _isHovered = true;
        });
      },
      onExit: (event) {
        setState(() {
          _isHovered = false;
        });
      },
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          hoverColor: kBackgroundColorLight,
          onTap: widget.tap,
          child: ListTile(
            horizontalTitleGap: 0.0,
            leading: SizedBox(height: 20),
            title: Text(
              widget.title,
              style: TextStyle(
                  color: _isHovered ? kPrimaryColor : kSecondaryColor,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
