import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ainvest/utils/responsive.dart';
import 'package:ainvest/utils/size_config.dart';
import 'package:ainvest/utils/colors.dart';
import 'package:ainvest/utils/style.dart';

class InfoCard extends StatefulWidget {
  String icon;
  String label;
  String amount;

  InfoCard({this.icon = "", this.label = "", this.amount = ""});

  @override
  State<InfoCard> createState() => _InfoCardState();
}

class _InfoCardState extends State<InfoCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
          minWidth: Responsive.isDesktop(context)
              ? 200
              : SizeConfig.screenWidth / 2 - 40),
      padding: EdgeInsets.only(
          top: 20,
          bottom: 20,
          left: 20,
          right: Responsive.isMobile(context) ? 20 : 40),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.white,
      ),
      child: Column(
        crossAxisAlignment: Responsive.isDesktop(context)
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.center,
        children: [
          if (Responsive.isDesktop(context))
            SvgPicture.asset(widget.icon, width: 35)
          else
            Icon(
              widget.icon == "lightbulb_outline"
                  ? Icons.lightbulb_outline
                  : widget.icon == "money"
                      ? Icons.monetization_on
                      : widget.icon == "transactions"
                          ? Icons.compare_arrows
                          : widget.icon == "predictions"
                              ? Icons.trending_up
                              : widget.icon == "statistics"
                                  ? Icons.bar_chart
                                  : widget.icon == "apartment"
                                      ? Icons.apartment
                                      : widget.icon == "house"
                                          ? Icons.home
                                          : Icons.help, // Default icon
            ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 2,
          ),
          PrimaryText(text: widget.label, color: AppColors.secondary, size: 12),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 2,
          ),
          PrimaryText(
            text: widget.amount,
            size: 16,
            fontWeight: FontWeight.w400,
          )
        ],
      ),
    );
  }
}
