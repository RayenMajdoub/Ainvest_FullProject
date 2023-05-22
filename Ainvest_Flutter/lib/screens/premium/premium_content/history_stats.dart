import 'dart:ui';
import 'package:ainvest/rest/api_bien.dart';
import 'package:ainvest/rest/api_stat.dart';
import 'package:ainvest/utils/constants.dart';
import 'package:ainvest/utils/responsive.dart';
import 'package:ainvest/widget/bar_charts/pie_chart.dart';
import 'package:ainvest/widget/infoCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../../utils/size_config.dart';
import '../../../widget/bar_charts/bar_chart.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

import 'estimer_bien_form_content/Topbar.dart';

class Content1 extends StatefulWidget {
  Content1({super.key});

  @override
  State<Content1> createState() => _Content1State();
}

Widget buildTileList(int index, PlotsData plotsData) {
  switch (index) {
    case 0:
      return Column(children: [
        Container(
          width: SizeConfig.screenWidth - 40,
          child: InfoCard(
            icon: "money",
            amount: "${plotsData.moyen_prix.toString()}€",
            label: "Moyenne des prix",
          ),
        ),
        SizedBox(height: 20),
        Container(
            width: SizeConfig.screenWidth - 40,
            child: InfoCard(
              icon: "transactions",
              amount: plotsData.nbr_transaction.toString(),
              label: "Nombre de transactions",
            )),
        SizedBox(height: 20)
      ]);

    case 2:
      return Column(children: [
        Container(
            width: SizeConfig.screenWidth - 40,
            child: InfoCard(
              icon: plotsData.most_frequent_type_local == "Appartement"
                  ? "apartment"
                  : "house",
              amount: plotsData.most_frequent_type_local,
              label: "Le plus fréquent type local",
            )),
        SizedBox(
          height: 20,
        ),
        Container(
            width: SizeConfig.screenWidth - 40,
            child: InfoCard(
              icon: "bank.svg",
              amount: "14000",
              label: "Most frequent price",
            )),
        SizedBox(height: 20)
      ]); // Your child widget goes here,

    /*   case 3:
      return Container(
          width: (SizeConfig.screenWidth - 20).toDouble(),
          height: 300,
          child: DecoratedBox(
              decoration: BoxDecoration(
                  color: kBackgroundColorWhite,
                  borderRadius: BorderRadius.circular(30)),
              child: BarChartSample2(
                plotsData: plotsData,
              ) // Your child widget goes here,
              ));
*/
    default:
      return Container();
  }
}

Widget buildTile(int index, PlotsData plotsData) {
  switch (index) {
    case 0:
      return FittedBox(
        child: InfoCard(
          icon: "roi.svg",
          amount: "${plotsData.moyen_prix.toString()}€",
          label: "Moyenne des prix",
        ),
      );
    case 1:
      return FittedBox(
        child: InfoCard(
          icon: "images/transactions.svg",
          amount: plotsData.nbr_transaction.toString(),
          label: "Nombre de transactions",
        ),
      );

    case 2:
      return FittedBox(
        child: InfoCard(
          icon: plotsData.most_frequent_type_local == "Appartement"
              ? "images/appartement.svg"
              : "images/house.svg",
          amount: plotsData.most_frequent_type_local,
          label: "Le plus fréquent\ntype local",
        ),
      ); // Your child widget goes here,
    case 3:
      return FittedBox(
        child: InfoCard(
          icon: "bank.svg",
          amount: "14000",
          label: "Most frequent price",
        ),
      );
    case 4:
      return Container(
          child: DecoratedBox(
              decoration: BoxDecoration(
                  color: kBackgroundColorWhite,
                  borderRadius: BorderRadius.circular(30)),
              child: BarChartSample2(
                plotsData: plotsData,
              ) // Your child widget goes here,
              ));
    case 5:
      return Container();
    default:
      return Container();
  }
}

class _Content1State extends State<Content1> {
  // late io.Socket _socket;
// parent widget
  static bool _isLoading = true;
  PlotsData plotsData = PlotsData(
    axeX: [],
    axeY: [],
    max_x: 0,
    max_y: 0,
    most_frequent_type_local: "",
    moyen_prix: 0,
    nbr_transaction: 0,
  );
  void _updatePlotsData(PlotsData newPlotsData) {
    setState(() {
      plotsData = newPlotsData;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();

    search("", "", "", "", "", "", "TOULOUSE", "", "", "", "", "")
        .then((value) => setState(() {
              plotsData = value!;
            }));

    //  print(plotsData.axeX);
    _isLoading = false;
  }

  /* print('Initializing socket...');

    _socket = io.io("http://192.168.1.4:3333", {
      'transports': ['websocket'],
      'autoConnect': true,
      'forceNew': false,
    });
    _socket.on('connect', (_) {
      print('Connected to server');
      setState(() {});
    });

    _socket.on('sent', (data) {
      setState(() {
        plotsData = PlotsData.fromJson(data);
        print(plotsData.axeX);
        _isLoading = false;
      });
    });

    _socket.on('disconnect', (_) {
      print("disconnected");
      setState(() {});
    });
    _socket.onError((error) {
      print('Error: $error');
      setState(() {});
    });*/

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Stack(children: [
      Column(children: [
        TopBar(onSearchComplete: _updatePlotsData),
        SizedBox(
          height: 10,
        ),
        if (Responsive.isDesktop(context))
          Row(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                width: (MediaQuery.of(context).size.width * 1.8) / 3,
                child: SizedBox(
                  child: GridView.custom(
                    shrinkWrap: true,
                    gridDelegate: SliverQuiltedGridDelegate(
                      crossAxisCount: 4,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                      repeatPattern: QuiltedGridRepeatPattern.inverted,
                      pattern: [
                        QuiltedGridTile(1, 1),
                        QuiltedGridTile(1, 1),
                        QuiltedGridTile(1, 1),
                        QuiltedGridTile(1, 1),
                        QuiltedGridTile(2, 3),
                        QuiltedGridTile(1, 1),
                        QuiltedGridTile(1, 1),
                        QuiltedGridTile(1, 2),
                      ],
                    ),
                    childrenDelegate: SliverChildBuilderDelegate(
                      (context, index) => buildTile(
                        index,
                        plotsData,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Container(
                  height: MediaQuery.of(context).size.height,
                  width: (MediaQuery.of(context).size.width * 0.57) / 3,
                  child: DecoratedBox(
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(30)),
                      child: Column(
                        children: [
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
                                    fontWeight:
                                        FontWeight.bold, // Make the font bold
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
                                color: kAccentRed,
                                borderRadius: BorderRadius.circular(40)),
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
                                    fontWeight:
                                        FontWeight.bold, // Make the font bold
                                  ))
                            ]),
                            // Align to the top left
                          ),
                        ],
                      ))),
            ],
          ),
        if (!Responsive.isDesktop(context))
          Container(
            height: SizeConfig.screenHeight,
            child: ListView.builder(
              itemCount: 4,
              itemBuilder: (context, index) => buildTileList(
                index,
                plotsData,
              ),
            ),
          ),
      ]),
      if (_isLoading)
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.white.withOpacity(0.0),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ),
    ]);
  }
}
