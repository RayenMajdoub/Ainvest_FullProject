import 'package:ainvest/utils/constants.dart';
import 'package:ainvest/widget/side_menu/SideMenuComponents/side_menu_smallbutton.dart';
import 'package:flutter/material.dart';
import 'package:ainvest/utils/size_config.dart';
import '../../utils/responsive.dart';
import '../../utils/style.dart';
import 'SideMenuComponents/side_menu_button.dart';

class SideMenu extends StatefulWidget {
  final Function(int) onMenuItemClicked;

  const SideMenu({Key? key, required this.onMenuItemClicked}) : super(key: key);

  @override
  _SideMenuState createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  int _content = 0; // default content of the child widget
  bool _showButtons_estimation = false;
  bool _showButtons_prediction = false;
  bool _showButtons_transaction = false;

  bool _showButtons_stat = false;
  void _updateContent(int index) {
    setState(() {
      _content = index;
    });
    widget.onMenuItemClicked(
        index); // notify the parent widget of the clicked menu item
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 1,
      child: Container(
        width: double.infinity,
        height: SizeConfig.screenHeight,
        decoration: BoxDecoration(color: kBackgroundColorWhite),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 180,
                alignment: Alignment.topCenter,
                width: double.infinity,
                child: SizedBox(
                  width: 180,
                  height: 180,
                  child: Responsive.isDesktop(context)
                      ? Image.asset('images/AinvestLogo.png')
                      : PrimaryText(
                          text: "Ainvest",
                          size: 16,
                          fontWeight: FontWeight.w400,
                          color: kSecondaryColor,
                        ),
                ),
              ),
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: SideMenuButton(
                    title: "Statistiques",
                    svgSrc: 'stats.svg',
                    tap: () {
                      setState(() {
                        _showButtons_stat = !_showButtons_stat;
                      }); // update content when button is clicked
                    },
                  )),
              Visibility(
                  visible: _showButtons_stat,
                  child: Column(
                    children: [
                      // add as many buttons as you need
                      TextButton(
                        onPressed: () {},
                        child: Container(
                            child: SideMenuButtonS(
                          title: "- Statistique sur l'historique",
                          tap: () {
                            _updateContent(0);
                          },
                        )),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Container(
                            child: SideMenuButtonS(
                          title: "- Statistique des predictions",
                          tap: () {
                            //_updateContent(1);
                          },
                        )),
                      )
                    ],
                  )),
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: SideMenuButton(
                    title: "Estimation",
                    svgSrc: 'prediction.svg',
                    tap: () {
                      setState(() {
                        _showButtons_estimation = !_showButtons_estimation;
                      }); // update content when button is clicked
                    },
                  )),
              Visibility(
                  visible: _showButtons_estimation,
                  child: Column(
                    children: [
                      // add as many buttons as you need
                      TextButton(
                        onPressed: () {},
                        child: Container(
                            child: SideMenuButtonS(
                          title: "- Estimer votre bien",
                          tap: () {
                            _updateContent(1);
                          },
                        )),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Container(
                            child: SideMenuButtonS(
                          title: "- Map d'estimation",
                          tap: () {
                            _updateContent(4);
                          },
                        )),
                      )
                    ],
                  )),
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: SideMenuButton(
                    title: "Prediction",
                    svgSrc: 'suggestion.svg',
                    tap: () {
                      setState(() {
                        _showButtons_prediction = !_showButtons_prediction;
                      }); // update content when button is clicked
                    },
                  )),
              Visibility(
                  visible: _showButtons_prediction,
                  child: Column(
                    children: [
                      // add as many buttons as you need
                      TextButton(
                        onPressed: () {},
                        child: Container(
                            child: SideMenuButtonS(
                          title: "- Prédire votre bien",
                          tap: () {
                            _updateContent(5);
                          },
                        )),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Container(
                            child: SideMenuButtonS(
                          title: "- Map de prediction",
                          tap: () {
                            _updateContent(4);
                          },
                        )),
                      )
                    ],
                  )),
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: SideMenuButton(
                    title: "Suggestion",
                    svgSrc: 'guarantee.svg',
                    tap: () {
                      _updateContent(
                          2); // update content when button is clicked
                    },
                  )),
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: SideMenuButton(
                    title: "Transactions",
                    svgSrc: 'roi_better.svg',
                    tap: () {
                      setState(() {
                        _showButtons_transaction = !_showButtons_transaction;
                      }); // update content when button is clickedontent when button is clicked
                    },
                  )),
              Visibility(
                  visible: _showButtons_transaction,
                  child: Column(
                    children: [
                      // add as many buttons as you need
                      TextButton(
                        onPressed: () {},
                        child: Container(
                            child: SideMenuButtonS(
                          title: "- Historique",
                          tap: () {
                            _updateContent(6);
                          },
                        )),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Container(
                            child: SideMenuButtonS(
                          title: "- Rentabilité sur Capitaux",
                          tap: () {
                            _updateContent(7);
                          },
                        )),
                      )
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
