import 'package:ainvest/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:ainvest/utils//responsive.dart';
import 'package:ainvest/utils//size_config.dart';
import 'package:ainvest/data.dart';
import 'package:ainvest/utils/colors.dart';
import 'package:ainvest/utils/style.dart';

import '../../../../models/Transaction.dart';

class TransactionTable extends StatefulWidget {
  final List<Transaction> transactions;

  const TransactionTable({
    Key? key,
    required this.transactions,
  }) : super(key: key);

  @override
  State<TransactionTable> createState() => _TransactionTableState();
}

class _TransactionTableState extends State<TransactionTable> {
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
            widget.transactions.length + 1, // add 1 for header row
            (index) {
              if (index == 0) {
                // header row
                return TableRow(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  children: [
                    SizedBox(height: 40, child: HeaderText(text: 'Bien')),
                    SizedBox(height: 40, child: HeaderText(text: 'Date')),
                    SizedBox(height: 40, child: HeaderText(text: 'Montant')),
                    SizedBox(height: 40, child: HeaderText(text: 'Type')),
                  ],
                );
              } else {
                // data row
                final data = widget.transactions[index - 1];
                return TableRow(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  children: [
                    SizedBox(
                        height: 40,
                        child: PrimaryText(
                          text:
                              "${data.property.commune} ${data.property.section}",
                          size: 16,
                          fontWeight: FontWeight.w400,
                          color: AppColors.secondary,
                        )),
                    SizedBox(
                        height: 40,
                        child: PrimaryText(
                          text: data.Date.toString(),
                          size: 16,
                          fontWeight: FontWeight.w400,
                          color: AppColors.secondary,
                        )),
                    SizedBox(
                        height: 40,
                        child: PrimaryText(
                          text: data.Montant.toString(),
                          size: 16,
                          fontWeight: FontWeight.w400,
                          color: AppColors.secondary,
                        )),
                    SizedBox(
                        height: 40,
                        child: PrimaryText(
                          text: data.State.toString(),
                          size: 16,
                          fontWeight: FontWeight.w400,
                          color:
                              data.State == "SOLD" ? kAccentRed : kAccentGreen,
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
