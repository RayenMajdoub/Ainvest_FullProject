class Property {
  final String id;
  final String dateMutation;
  final String natureMutation;
  final double valeurFonciere;
  final String typeVoie;
  final String voie;
  final double codePostal;
  final String commune;
  final double codeDepartement;
  final double codeCommune;
  final String section;
  final double noPlan;
  final double nombreLots;
  final String typeLocal;
  final double surfaceReelleBati;
  final double nombrePiecesPrincipales;
  final String natureCulture;

  Property({
    required this.id,
    required this.dateMutation,
    required this.natureMutation,
    required this.valeurFonciere,
    required this.typeVoie,
    required this.voie,
    required this.codePostal,
    required this.commune,
    required this.codeDepartement,
    required this.codeCommune,
    required this.section,
    required this.noPlan,
    required this.nombreLots,
    required this.typeLocal,
    required this.surfaceReelleBati,
    required this.nombrePiecesPrincipales,
    required this.natureCulture,
  });

  factory Property.fromJson(Map<String, dynamic> json) {
    return Property(
      id: json['_id'] as String,
      dateMutation: json['Date mutation'] as String,
      natureMutation: json['Nature mutation'] as String,
      valeurFonciere: json['Valeur fonciere'] as double,
      typeVoie: json['Type de voie'] as String,
      voie: json['Voie'] as String,
      codePostal: json['Code postal'] as double,
      commune: json['Commune'] as String,
      codeDepartement: json['Code departement'] as double,
      codeCommune: json['Code commune'] as double,
      section: json['Section'] as String,
      noPlan: json['No plan'] as double,
      nombreLots: json['Nombre de lots'] as double,
      typeLocal: json['Type local'] as String,
      surfaceReelleBati: json['Surface reelle bati'] as double,
      nombrePiecesPrincipales: json['Nombre pieces principales'] as double,
      natureCulture: json['Nature culture'] as String,
    );
  }
}
