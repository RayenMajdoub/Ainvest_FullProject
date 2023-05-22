import 'dart:convert';

class SoldData {
  final String propertyinfo;
  final double roi;
  final double roiPerYear;
  final int purchasePrice;
  final int salePrice;
  final String purchaseDate;
  final String saleDate;

  SoldData(
      {required this.roi,
      required this.roiPerYear,
      required this.purchasePrice,
      required this.salePrice,
      required this.purchaseDate,
      required this.saleDate,
      required this.propertyinfo});

  factory SoldData.fromJson(Map<String, dynamic> json) {
    return SoldData(
      propertyinfo: json['propertyinfo'] as String,
      roi: json['roi'] as double,
      roiPerYear: json['roiPerYear'] as double,
      purchasePrice: json['purchasePrice'] as int,
      salePrice: json['salePrice'] as int,
      purchaseDate: json['purchaseDate'] as String,
      saleDate: json['saleDate'] as String,
    );
  }
}
