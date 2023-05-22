import 'package:ainvest/models/Userdata.dart';
import 'package:ainvest/rest/api_transactions.dart';
import 'package:ainvest/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:ainvest/utils//responsive.dart';
import 'package:ainvest/utils//size_config.dart';
import 'package:ainvest/data.dart';
import 'package:ainvest/utils/colors.dart';
import 'package:ainvest/utils/style.dart';

import '../../../../models/Transaction.dart';

class RoiTable extends StatefulWidget {
  final ResponseData userdata;

  const RoiTable({
    Key? key,
    required this.userdata,
  }) : super(key: key);

  @override
  State<RoiTable> createState() => _RoiTableState();
}

class _RoiTableState extends State<RoiTable> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection:
          Responsive.isDesktop(context) ? Axis.vertical : Axis.horizontal,
      child: SizedBox(
        width: 900,
        child: Table(
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: List.generate(
            widget.userdata.soldProperties.length + 1, // add 1 for header row
            (index) {
              if (index == 0) {
                // header row
                return TableRow(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  children: [
                    SizedBox(height: 40, child: HeaderText(text: 'Bien')),
                    SizedBox(
                        height: 40, child: HeaderText(text: "Date d'achat")),
                    SizedBox(
                        height: 40, child: HeaderText(text: 'Date de vente')),
                    SizedBox(
                        height: 40, child: HeaderText(text: "Prix d'achat")),
                    SizedBox(
                        height: 40, child: HeaderText(text: "Prix de vente")),
                    SizedBox(height: 40, child: HeaderText(text: "Rci/ans")),
                    SizedBox(height: 40, child: HeaderText(text: "Rci")),
                  ],
                );
              } else {
                // data row
                final data = widget.userdata.soldProperties[index - 1];
                return TableRow(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  children: [
                    SizedBox(
                        height: 40,
                        child: PrimaryText(
                          text: data.propertyinfo,
                          size: 16,
                          fontWeight: FontWeight.w400,
                          color: AppColors.secondary,
                        )),
                    SizedBox(
                        height: 40,
                        child: PrimaryText(
                          text: data.purchaseDate,
                          size: 16,
                          fontWeight: FontWeight.w400,
                          color: AppColors.secondary,
                        )),
                    SizedBox(
                        height: 40,
                        child: PrimaryText(
                          text: data.saleDate,
                          size: 16,
                          fontWeight: FontWeight.w400,
                          color: AppColors.secondary,
                        )),
                    SizedBox(
                        height: 40,
                        child: PrimaryText(
                          text: data.purchasePrice.toString(),
                          size: 16,
                          fontWeight: FontWeight.w400,
                          color: AppColors.secondary,
                        )),
                    SizedBox(
                        height: 40,
                        child: PrimaryText(
                          text: data.salePrice.toString(),
                          size: 16,
                          fontWeight: FontWeight.w400,
                          color: AppColors.secondary,
                        )),
                    SizedBox(
                        height: 40,
                        child: PrimaryText(
                          text: "${data.roiPerYear.toStringAsFixed(2)}%",
                          size: 16,
                          fontWeight: FontWeight.w400,
                          color:
                              data.roiPerYear < 0 ? kAccentRed : kAccentGreen,
                        )),
                    SizedBox(
                        height: 40,
                        child: PrimaryText(
                          text: "${data.roi.toStringAsFixed(2)}%",
                          size: 16,
                          fontWeight: FontWeight.w400,
                          color: data.roi < 0 ? kAccentRed : kAccentGreen,
                        ))
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class HeaderText extends StatelessWidget {
  const HeaderText({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return PrimaryText(
      text: text,
      size: 18,
      fontWeight: FontWeight.w600,
      color: AppColors.primary,
    );
  }
}
