import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../constant/utils.dart';
import '../models/Userdata.dart';
import '../models/sold_data.dart';

final String apiUrl =
    'http://localhost:8000/Transactions/getUserDatabyUserIdPremium';

//final String apiUrl =
//  'http://10.0.2.2:8000/Transactions/getUserDatabyUserIdPremium';

class ResponseData {
  final List<SoldData> soldProperties;
  final Map<String, dynamic> boughtProperties;
  final int totalSoldAmount;
  final int totalBoughtAmount;
  final UserData userData;
  ResponseData(
      {required this.soldProperties,
      required this.boughtProperties,
      required this.totalSoldAmount,
      required this.totalBoughtAmount,
      required this.userData});
  factory ResponseData.fromJson(Map<String, dynamic> json) {
    return ResponseData(
        soldProperties: (json['soldProperties'] as List)
            .map((e) => SoldData.fromJson(e))
            .toList(),
        boughtProperties: json['boughtProperties'] as Map<String, dynamic>,
        totalSoldAmount: json['totalSoldAmount'] as int,
        totalBoughtAmount: json['totalBoughtAmount'] as int,
        userData: UserData.fromJson(json['userData']));
  }
}

Future<ResponseData> getCurrentUserData(
  BuildContext context,

  // String userId,
) async {
  Map<String, dynamic> requestBody = {"User": "643a6ab4c65cfc20dd0787d5"};
  try {
    print(jsonEncode(requestBody));
    http.Response res = await http.post(Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(requestBody));
    print(res);
    ResponseData responseData;
    if (res.statusCode == 200) {
      // process the response
      responseData = ResponseData.fromJson(jsonDecode(res.body));
      print(responseData.userData.transactions);
      showSnackBar(
        context,
        'Done!',
      );
      return responseData;
      // display the result to the user
    } else {
      // Handle error
      print('Error: ${res.statusCode}');
      throw Exception('Error: ${res.statusCode}');
    }
  } catch (error) {
    print('Error occurred: $error');
    throw Exception('Error occurred: $error');
  }
}
