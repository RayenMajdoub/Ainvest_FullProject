import 'package:ainvest/screens/premium/premium_content/estimer_bien_form_content/TransactionTable.dart';
import 'package:ainvest/utils/constants.dart';
import 'package:datepicker_dropdown/datepicker_dropdown.dart';
import 'package:flutter/material.dart';

import '../../../rest/api_transactions.dart';
import 'estimer_bien_form_content/roi_table.dart';

class RoiPage extends StatefulWidget {
  const RoiPage({super.key});

  @override
  State<RoiPage> createState() => _RoiPageState();
}

class _RoiPageState extends State<RoiPage> {
  Future<ResponseData>? _futureResponse;

  @override
  void initState() {
    super.initState();
    _futureResponse = getCurrentUserData(context);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 120,
              ),
              Text(
                'Rentabilité des capitaux investis',
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
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
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
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
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
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
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
                                                  snapshot.data!
                                                      .totalBoughtAmount) >
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
                    'Détails sur RCI',
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
                        return RoiTable(userdata: snapshot.data!);
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
            SizedBox(height: 120),
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
                          Text(
                            "Retour total sur investissement",
                            style: TextStyle(
                              color: kSecondaryColor,
                              height: 1.3,
                              fontFamily: 'Poppins',
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            '${snapshot.data!.userData.totalRoi.toStringAsFixed(2)}%',
                            style: TextStyle(
                              color: snapshot.data!.userData.totalRoi > 0
                                  ? kAccentGreen
                                  : kAccentRed,
                              height: 1.3,
                              fontFamily: 'Poppins',
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
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
            SizedBox(height: 40),
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
                          Text(
                            "Retour total sur investissement\nen €",
                            style: TextStyle(
                              color: kSecondaryColor,
                              height: 1.3,
                              fontFamily: 'Poppins',
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 10),
                          Text(
                            '${(snapshot.data!.totalSoldAmount - snapshot.data!.totalBoughtAmount).toStringAsFixed(2)} €',
                            style: TextStyle(
                              color: snapshot.data!.userData.totalRoi > 0
                                  ? kAccentGreen
                                  : kAccentRed,
                              height: 1.3,
                              fontFamily: 'Poppins',
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
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
