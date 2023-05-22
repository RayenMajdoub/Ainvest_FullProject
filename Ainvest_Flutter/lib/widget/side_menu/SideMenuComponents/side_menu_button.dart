import 'package:ainvest/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ainvest/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/responsive.dart';

class SideMenuButton extends StatefulWidget {
  final String title, svgSrc;
  final VoidCallback tap;

  const SideMenuButton({
    Key? key,
    required this.title,
    required this.svgSrc,
    required this.tap,
  }) : super(key: key);

  @override
  State<SideMenuButton> createState() => _SideMenuButtonState();
}

class _SideMenuButtonState extends State<SideMenuButton> {
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
            leading: Responsive.isDesktop(context)
                ? SvgPicture.asset(
                    widget.svgSrc,
                    color: _isHovered ? kPrimaryColor : Colors.transparent,
                    height: 30,
                  )
                : Icon(
                    widget.svgSrc == 'prediction.svg'
                        ? Icons.trending_up
                        : widget.svgSrc == 'stats.svg'
                            ? Icons.bar_chart
                            : widget.svgSrc == 'suggestion.svg'
                                ? Icons.lightbulb_outline
                                : widget.svgSrc == 'guarantee.svg'
                                    ? Icons.monetization_on
                                    : widget.svgSrc == 'roi_better.svg'
                                        ? Icons.history
                                        : Icons.help, // Default icon
                    color: _isHovered ? kPrimaryColor : kSecondaryColor,
                    size: 30,
                  ),
            title: Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  widget.title,
                  style: TextStyle(
                      color: _isHovered ? kPrimaryColor : kSecondaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                )),
          ),
        ),
      ),
    );
  }
}
