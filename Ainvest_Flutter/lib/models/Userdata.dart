import 'dart:convert';

import 'Transaction.dart';

class UserData {
  final String id;
  final String user;
  final List<dynamic> properties;
  final List<Transaction> transactions;
  final double totalRoi;
  final int level;
  final int experience;
  final List<dynamic> achievements;

  UserData(
      {required this.id,
      required this.user,
      required this.properties,
      required this.transactions,
      required this.totalRoi,
      required this.level,
      required this.experience,
      required this.achievements});

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
        id: json['_id'] as String,
        user: json['User'] as String,
        properties: json['Properties'] as List<dynamic>,
        transactions: List<Transaction>.from(json['Transactions']
            .map((transaction) => Transaction.fromJson(transaction))),
        totalRoi: json['TotalRoi'] as double,
        level: json['Level'] as int,
        experience: json['Experience'] as int,
        achievements: json['Acheivments']);
  }
}
