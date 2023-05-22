import 'package:ainvest/screens/premium/premium.dart';
import 'package:ainvest/screens/home_screen/home/home.dart';
import 'package:ainvest/screens/login_screen/login_screen.dart';
import 'package:path/path.dart';

getRoutes() {
  return {
    LoginScreen.route: (context) => LoginScreen(),
    HomePage.route: (context) => HomePage(),
    Dashboard.route: (context) => Dashboard()
  };
}
