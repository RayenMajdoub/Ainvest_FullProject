import 'dart:convert';

import 'Property.dart';

class Transaction {
  final String id;
  final String State;
  final String Date;
  final Property property;
  final int Montant;
  Transaction(
      {required this.id,
      required this.State,
      required this.Date,
      required this.property,
      required this.Montant});

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
        id: json['_id'] as String,
        State: json['State'] as String,
        Date: json['Date'] as String,
        property: Property.fromJson(json['Property']),
        Montant: json['Montant'] as int);
  }
}
