import 'package:ainvest/screens/premium/premium_content/estimer_bien_form_content/TransactionTable.dart';
import 'package:ainvest/utils/constants.dart';
import 'package:datepicker_dropdown/datepicker_dropdown.dart';
import 'package:flutter/material.dart';
import '../../../rest/api_transactions.dart';

class TransactionHistory extends StatefulWidget {
  const TransactionHistory({super.key});

  @override
  State<TransactionHistory> createState() => _TransactionHistoryState();
}

class _TransactionHistoryState extends State<TransactionHistory> {
  Future<ResponseData>? _futureResponse;
  final TextEditingController controllerMontant = TextEditingController();

  String selectedMonth = "10";
  String selectedYear = "2023";
  String formatDate(String dayStr, String monthStr, String yearStr) {
    return '${dayStr.toString().padLeft(2, '0')}/${monthStr.toString().padLeft(2, '0')}/$yearStr';
  }

  @override
  void initState() {
    super.initState();
    _futureResponse = getCurrentUserData(context);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            'Historique de transactions',
            style: TextStyle(
              color: kSecondaryColor,
              height: 1.3,
              fontFamily: 'Poppins',
              fontSize: 33,
              fontWeight: FontWeight.w900,
            ),
          ),
          SizedBox(height: 80),
          Row(children: [
            Container(
                decoration: BoxDecoration(
                  color: kBackgroundColorWhite,
                  borderRadius: BorderRadius.circular(30.0),
                ),
                padding: const EdgeInsets.all(30),
                child: FutureBuilder<ResponseData>(
                  future: _futureResponse,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasData) {
                      return Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Text(
                                "Montant total de la vente  ",
                                style: TextStyle(
                                  color: kSecondaryColor,
                                  height: 1.3,
                                  fontFamily: 'Poppins',
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                '${snapshot.data!.totalSoldAmount} €',
                                style: TextStyle(
                                  color: kAccentRed,
                                  height: 1.3,
                                  fontFamily: 'Poppins',
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Error fetching data'),
                      );
                    } else {
                      return SizedBox.shrink();
                    }
                  },
                )),
            SizedBox(
              width: 40,
            ),
            Container(
                decoration: BoxDecoration(
                  color: kBackgroundColorWhite,
                  borderRadius: BorderRadius.circular(30.0),
                ),
                padding: const EdgeInsets.all(30),
                child: FutureBuilder<ResponseData>(
                  future: _futureResponse,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasData) {
                      return Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Text(
                                "Montant total de l'achat  ",
                                style: TextStyle(
                                  color: kSecondaryColor,
                                  height: 1.3,
                                  fontFamily: 'Poppins',
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                '${snapshot.data!.totalBoughtAmount} €',
                                style: TextStyle(
                                  color: kAccentGreen,
                                  height: 1.3,
                                  fontFamily: 'Poppins',
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Error fetching data'),
                      );
                    } else {
                      return SizedBox.shrink();
                    }
                  },
                )),
            SizedBox(
              width: 40,
            ),
            Container(
                decoration: BoxDecoration(
                  color: kBackgroundColorWhite,
                  borderRadius: BorderRadius.circular(30.0),
                ),
                padding: const EdgeInsets.all(30),
                child: FutureBuilder<ResponseData>(
                  future: _futureResponse,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasData) {
                      return Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Text(
                                "Ratio actuel  ",
                                style: TextStyle(
                                  color: kSecondaryColor,
                                  height: 1.3,
                                  fontFamily: 'Poppins',
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                '${(snapshot.data!.totalSoldAmount / snapshot.data!.totalBoughtAmount).toStringAsFixed(2)}',
                                style: TextStyle(
                                  color: (snapshot.data!.totalSoldAmount /
                                              snapshot
                                                  .data!.totalBoughtAmount) >
                                          1
                                      ? kAccentGreen
                                      : kAccentRed,
                                  height: 1.3,
                                  fontFamily: 'Poppins',
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Error fetching data'),
                      );
                    } else {
                      return SizedBox.shrink();
                    }
                  },
                ))
          ]),
          SizedBox(height: 60),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Transactions',
                style: TextStyle(
                  color: kSecondaryColor,
                  height: 1.3,
                  fontFamily: 'Poppins',
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(height: 20)
            ],
          ),
          Container(
              decoration: BoxDecoration(
                color: kBackgroundColorWhite,
                borderRadius: BorderRadius.circular(30.0),
              ),
              padding: const EdgeInsets.all(30),
              child: FutureBuilder<ResponseData>(
                future: _futureResponse,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasData) {
                    return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /* Row(
                            children: [
                              Container(
                                  height: 50,
                                  width: 300,
                                  child: TextField(
                                    controller: controllerMontant,
                                    decoration: InputDecoration(
                                      hintText: "Montant",
                                      border: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: kSecondaryColor,
                                              strokeAlign: 1),
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                    ),
                                  )),
                              SizedBox(
                                width: 30,
                              ),
                              Container(
                                  height: 50,
                                  width: 250,
                                  child: DropdownDatePicker(
                                    inputDecoration: InputDecoration(
                                        enabledBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: kSecondaryColor,
                                                width: 1.0),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(30))),
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                                30))), // optional
                                    isDropdownHideUnderline: true, // optional
                                    isFormValidator: true, // optional
                                    startYear: 2018, // optional
                                    endYear: 2028, // optional
                                    width: 10,

                                    // selectedDay: 14, // optional
                                    showDay: false,
                                    onChangedMonth: (value) {
                                      setState(() {
                                        selectedMonth = value!;
                                      });
                                    },
                                    onChangedYear: (value) {
                                      setState(() {
                                        selectedYear = value!;
                                      });
                                    },

                                    hintTextStyle: TextStyle(fontSize: 12),
                                    locale: "fr_FR", // optional
                                  )),
                              SizedBox(
                                width: 60,
                              ),
                              ElevatedButton(
                                onPressed: () {},
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          kPrimaryColor),
                                  padding: MaterialStateProperty.all<
                                      EdgeInsetsGeometry>(
                                    const EdgeInsets.symmetric(
                                        vertical: 20, horizontal: 25),
                                  ),
                                  elevation:
                                      MaterialStateProperty.all<double>(5.0),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                  shadowColor: MaterialStateProperty.all<Color>(
                                      kPrimaryColor), // Use `label` to specify the label text of the button
                                ),
                                child: const Text(
                                  'Filtrer',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                              )
                            ],
                          ),*/
                          SizedBox(
                            height: 30,
                          ),
                          TransactionTable(
                              transactions:
                                  snapshot.data!.userData.transactions)
                        ]);
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error fetching data'),
                    );
                  } else {
                    return SizedBox.shrink();
                  }
                },
              )),
        ]),
        SizedBox(
          width: 120,
        ),
        Column(
          children: [
            SizedBox(height: 55),
            Container(
              height: 460,
              width: 220,
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(40)),
              child: Column(children: const [
                Image(
                  image: AssetImage('images/ranking_system.png'),
                  height: 200,
                  width: 200,
                ),
                Text(
                    "Gagnez des niveaux en effectuant des transactions et obtenez des récompenses pour votre engagement et votre fidélité sur notre site !\nvoir le classement",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      height: 2, // Add padding between lines
                      fontWeight: FontWeight.bold, // Make the font bold
                    ))
              ]),
              // Align to the top left
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              height: 380,
              width: 220,
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              decoration: BoxDecoration(
                  color: kAccentRed, borderRadius: BorderRadius.circular(40)),
              child: Column(children: const [
                Image(
                  image: AssetImage('images/house_hand.png'),
                  height: 200,
                  width: 200,
                ),
                Text(
                    "Besoin d'aide pour trouver l'agent qui fera la différence ? SeLoger s'en charge pour vous.",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      height: 2, // Add padding between lines
                      fontWeight: FontWeight.bold, // Make the font bold
                    ))
              ]),
              // Align to the top left
            ),
          ],
        )
      ],
    );
  }
}
