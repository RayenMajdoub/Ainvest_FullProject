// ignore_for_file: use_build_context_synchronously, unused_local_variable, import_of_legacy_library_into_null_safe, unused_field, unnecessary_null_comparison

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:ainvest/constant/error_handling.dart';
import 'package:ainvest/constant/utils.dart';
import 'package:ainvest/models/user.dart';
import 'package:ainvest/providers/user_provider.dart';
import 'package:ainvest/screens/home_screen/home/home.dart';

// ignore: camel_case_types
class Authservices {
  late SharedPreferences _sharedPreferences;
  void signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String username,
  }) async {
    try {
      User user = User(
        id: '',
        username: username,
        password: password,
        email: email,
        token: '',
      );

      http.Response res = await http.post(
          Uri.parse('${Utils.baseurl}/auth/register'),
          body: user.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(
            context,
            'Account created! Login with the same credentials!',
          );
        },
      );
    } catch (e) {
      debugPrint(e.toString());
      showSnackBar(context, e.toString());
    }
  }

  // sign in user
  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    _sharedPreferences = await SharedPreferences.getInstance();
    try {
      http.Response res = await http.post(
        Uri.parse('${Utils.baseurl}/auth/login'),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          /* var obj = jsonDecode(res.body) ; 
          var useremail = obj['email'] ; 
          var userid = obj ['_id'] ; */
          showSnackBar(
            context,
            'loged in ! welcome!',
          );

          /*_sharedPreferences.setString('userid', userid) ;
          _sharedPreferences.setString('useremail', useremail) ;  */

          Route route = MaterialPageRoute(builder: (_) => HomePage());
          Navigator.pushReplacement(context, route);
        },
      );
    } catch (e) {
      debugPrint(e.toString());
      showSnackBar(context, e.toString());
    }
  }

  // get user data
  void getUserData(
    BuildContext context,
  ) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null) {
        prefs.setString('x-auth-token', '');
      }

      var tokenRes = await http.post(
        Uri.parse('${Utils.baseurl}/tokenIsValid'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token!
        },
      );

      var response = jsonDecode(tokenRes.body);

      if (response == true) {
        http.Response userRes = await http.get(
          Uri.parse('${Utils.baseurl}/'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token
          },
        );

        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(userRes.body);
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
