import 'package:ainvest/screens/home_screen/home/home.dart';
import 'package:ainvest/screens/premium/premium_content/estimer_votre_bien_info.dart';
import 'package:ainvest/screens/premium/premium_content/map_estimation.dart';
import 'package:ainvest/screens/premium/premium_content/predict_bien_info.dart';
import 'package:ainvest/screens/premium/premium_content/suggestion_invest_info.dart';
import 'package:ainvest/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:ainvest/widget/appBarActionItems.dart';
import 'package:ainvest/widget/side_menu/sideMenu.dart';
import 'package:ainvest/utils/responsive.dart';
import 'package:ainvest/utils/size_config.dart';
import 'package:ainvest/utils/colors.dart';
import 'premium_content/history_stats.dart';
import 'premium_content/roi_page.dart';
import 'premium_content/transaction_history.dart';

Widget buildTile() {
  return Container(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
      child: SizedBox(
        height: 450,
        width: 750,
        child: Content1(),
      ));
}

class Dashboard extends StatefulWidget {
  static String route = "premium";

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  int _selectedIndex = 0;

  void _onMenuItemClicked(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildChildContent() {
    switch (_selectedIndex) {
      case 0:
        return Content1();

      case 1:
        return EstimerPageInit();

      case 2:
        return PredictBienPage();
      case 3:
        return SuggestionInfo();
      case 4:
        return MapEstimation();
      case 5:
        return PredictBienPage();
      case 6:
        return TransactionHistory();
      case 7:
        return RoiPage();
      default:
        return const Text('Unknown item selected');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _drawerKey,
      drawer: SizedBox(
          width: 220, child: SideMenu(onMenuItemClicked: _onMenuItemClicked)),
      appBar: !Responsive.isDesktop(context)
          ? AppBar(
              elevation: 0,
              backgroundColor: kBackgroundColorWhite,
              leading: IconButton(
                  onPressed: () {
                    _drawerKey.currentState!.openDrawer();
                  },
                  icon: Icon(Icons.menu, color: AppColors.black)),
              actions: [
                AppBarActionItems(),
              ],
            )
          : PreferredSize(
              preferredSize: Size.zero,
              child: SizedBox(),
            ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: kPrimaryColor,
          elevation: 12,
          hoverColor: kAccentRed,
          onPressed: () => Navigator.pushNamed(context, HomePage.route),
          child: const Icon(Icons.store_rounded)),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (Responsive.isDesktop(context))
              Expanded(
                flex: 2,
                child: SideMenu(onMenuItemClicked: _onMenuItemClicked),
              ),
            Expanded(
              flex: 10,
              child: SafeArea(
                child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                    child: Column(children: [
                      Responsive.isDesktop(context)
                          ? AppBarActionItems()
                          : SizedBox(),
                      Responsive.isDesktop(context)
                          ? _buildChildContent()
                          : Container(
                              height: SizeConfig.screenHeight,
                              width: SizeConfig.screenWidth,
                              child: _buildChildContent())
                    ])),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
