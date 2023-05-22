class PlotsData {
  final List<int> axeX;
  final List<double> axeY;
  final double max_x;
  final double max_y;
  final int nbr_transaction;
  final double moyen_prix;
  final String most_frequent_type_local;
  //final List<double> percentages;

  PlotsData(
      {required this.axeX,
      required this.axeY,
      required this.max_x,
      required this.max_y,
      required this.nbr_transaction,
      required this.moyen_prix,
      required this.most_frequent_type_local
      // required this.percentages,
      });

  factory PlotsData.fromJson(Map<String, dynamic> json) {
    return PlotsData(
        axeX: json['axe_x'].cast<int>(),
        axeY: json['axe_y'].cast<double>(),
        max_x: json['max_x'] as double,
        max_y: json['max_y'] as double,
        nbr_transaction: json['nbr_transaction'] as int,
        moyen_prix: json['moyen_prix'] as double,
        most_frequent_type_local: json['type_local'] as String);

//percentages: json['percentages'].cast<String>());
  }
}
