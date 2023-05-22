import 'dart:convert';
import 'package:http/http.dart' as http;

import 'api_stat.dart';

Future<PlotsData?> search(
    String date_mutation,
    String prix_max,
    String prix_min,
    String type_local,
    String voie,
    String code_postal,
    String commune,
    String code_dep,
    String nbr_piece,
    String surface_real_bati_min,
    String surface_real_bati_max,
    String section) async {
  //final baseUrl = 'http://localhost:8000/Bien/PublishFilterStat';
  final baseUrl = 'http://localhost:8000/Statistique/searchBien';
  //final baseUrl = 'http://10.0.2.2:8000/Statistique/searchBien';

  var queryParameters = <String, dynamic>{};

  if (date_mutation.trim().isNotEmpty) {
    queryParameters['Date mutation'] = date_mutation;
  }
  if (prix_max.trim().isNotEmpty) {
    queryParameters['Valeur fonciere max'] = prix_max;
  }
  if (prix_min.trim().isNotEmpty) {
    queryParameters['Valeur fonciere min'] = prix_min;
  }
  //
  if (type_local.trim().isNotEmpty) {
    queryParameters['Type local'] = type_local;
  }

  if (voie.trim().isNotEmpty) {
    queryParameters['Voie'] = voie;
  }

  if (code_postal.trim().isNotEmpty) {
    queryParameters['Code postal'] = code_postal;
  }
  if (commune.trim().isNotEmpty) {
    queryParameters['Commune'] = commune;
  }

  if (code_dep.trim().isNotEmpty) {
    queryParameters['Code departement'] = code_dep;
  }

  if (section.trim().isNotEmpty) {
    queryParameters['Section'] = section;
  }
  if (surface_real_bati_min.trim().isNotEmpty) {
    queryParameters['Surface min'] = surface_real_bati_min;
  }
  if (surface_real_bati_max.trim().isNotEmpty) {
    queryParameters['Surface max'] = surface_real_bati_max;
  }
  if (nbr_piece.trim().isNotEmpty) {
    queryParameters['Nombre pieces principales'] = int.parse(nbr_piece);
  }

  final uri = Uri.parse(baseUrl).replace(queryParameters: queryParameters);

  try {
    final response = await http.get(uri);
    // process the response
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      // Check if the response has the "data" key
      if (jsonResponse.containsKey("data")) {
        // Map the JSON response to PlotsData object
        final plotsData = PlotsData.fromJson(jsonResponse["data"]);
        return plotsData;
        print(plotsData);
      } else {
        throw Exception("Invalid response format: missing 'data' field");
      }
    } else {
      // Handle the error
      print('Request failed with status: ${response.statusCode}.');
    }
  } catch (error) {
    print('Error occurred: $error');
  }
}
