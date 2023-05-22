import 'dart:convert';
import 'package:ainvest/screens/premium/premium_content/result_prediction.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../constant/utils.dart';
import '../screens/premium/premium_content/result_estimation_result.dart';

final String apiUrl = 'http://localhost:8000/Prediction/predict';

Future<void> postFormestimation(
  BuildContext context,
  bool estimation,
  String dateMutation,
  String natureMutation,
  String typeDeVoie,
  String voie,
  int codePostal,
  String commune,
  int codeDepartement,
  String section,
  String typeLocal,
  int surfaceBati,
  int nbrPiece,
  String natureCulture,
  double valeurFonciere,
) async {
  Map<String, dynamic> requestBody = {
    "Date mutation": dateMutation,
    "Nature mutation": natureMutation,
    "Type de voie": typeDeVoie,
    "Voie": voie,
    "Code postal": codePostal,
    "Commune": commune,
    "Code departement": codeDepartement,
    "Section": section,
    "Type local": typeLocal,
    "Surface reelle bati": surfaceBati,
    "Nombre pieces principales": nbrPiece,
    "Nature culture": natureCulture,
    "Valeur fonciere": valeurFonciere
  };
  try {
    http.Response res = await http.post(Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(requestBody));
    print(res);

    if (res.statusCode == 200) {
      // process the response
      Map<String, dynamic> responseJson = jsonDecode(res.body);
      print(jsonDecode(res.body));
      double predictedValue = responseJson['predicted_value'];
      dynamic result = jsonDecode(res.body);
      if (estimation) {
        Route route = MaterialPageRoute(
            builder: (_) =>
                resultEstimation(result: predictedValue.toString()));

        Navigator.push(context, route);
      } else {
        Route route = MaterialPageRoute(
            builder: (_) => resultPrediction(
                result: predictedValue.toString(), date: dateMutation));

        Navigator.push(context, route);
      }

      showSnackBar(
        context,
        'Done!',
      );
      // display the result to the user
    } else {
      // Handle error
      print('Error: ${res.statusCode}');
    }
  } catch (error) {
    print('Error occurred: $error');
  }
}
