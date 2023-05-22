import 'package:ainvest/screens/premium/premium_content/estimer_bien_form_content/estimer_bien_form_widgets.dart';
import 'package:ainvest/utils/constants.dart';
import 'package:datepicker_dropdown/datepicker_dropdown.dart';
import 'package:flutter/material.dart';
import '../../../rest/api_estimation.dart';
import 'package:intl/intl.dart';

class SuggestionForm extends StatefulWidget {
  const SuggestionForm({super.key});

  @override
  State<SuggestionForm> createState() => _SuggestionFormState();
}

class _SuggestionFormState extends State<SuggestionForm> {
  int _processIndex = 0;

  final TextEditingController _adresseController = TextEditingController();
  String selectedTypeBien = "";
  String? selectedTerrasse;
  String? selectedStanding;
  String? selectedEmplacement;
  DateTime? _selected;

  final TextEditingController _surfaceBatiController = TextEditingController();
  final TextEditingController _nbrPieceController = TextEditingController();
  final TextEditingController _nbrEtage = TextEditingController();
  final TextEditingController _surQuelleEtage = TextEditingController();
  final TextEditingController _chargeMensuelle = TextEditingController();
  final TextEditingController _caveController = TextEditingController();
  final TextEditingController _nbrBalcon = TextEditingController();
  final TextEditingController _ville = TextEditingController();
  final TextEditingController _commune = TextEditingController();
  final TextEditingController _section = TextEditingController();
  final TextEditingController _code_postal = TextEditingController();
  final TextEditingController _voie = TextEditingController();
  final TextEditingController _codedepartement = TextEditingController();
  String selectedDay = "01";
  String selectedMonth = "10";
  String selectedYear = "2023";
  String formatDate(String dayStr, String monthStr, String yearStr) {
    return '${dayStr.toString().padLeft(2, '0')}/${monthStr.toString().padLeft(2, '0')}/$yearStr';
  }

// Example usage:

  void _submitForm() {
    String selectedDate = formatDate(selectedDay, selectedMonth, selectedYear);

    print(selectedDate);
    String surfaceBati = _surfaceBatiController.text;
    String nbrPiece = _nbrPieceController.text;
    String dateMutation = _nbrPieceController.text;
    String nbrEtage = _nbrEtage.text;
    String surQuelleEtage = _surQuelleEtage.text;
    String chargeMensuelle = _chargeMensuelle.text;
    String cave = _caveController.text;
    String nbrBalcon = _nbrBalcon.text;
    String ville = _ville.text;
    String commune = _commune.text;
    String section = _section.text;
    String codePostal = _code_postal.text;
    String voie = _voie.text;
    String codeDepartement = _codedepartement.text;

    if (surfaceBati.isEmpty ||
        selectedDate.isEmpty ||
        nbrPiece.isEmpty ||
        //  nbrEtage.isEmpty ||
        //  surQuelleEtage.isEmpty ||
        //    chargeMensuelle.isEmpty ||
        //  cave.isEmpty ||
        //  nbrBalcon.isEmpty ||
        // ville.isEmpty ||
        commune.isEmpty ||
        section.isEmpty ||
        codePostal.isEmpty ||
        voie.isEmpty ||
        codeDepartement.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('There is an empty field')),
      );
    } else {
      print("im in else ");

      postFormestimation(
          context,
          false,
          selectedDate,
          "Vente",
          "RUE",
          voie,
          int.parse(codePostal),
          commune,
          int.parse(codeDepartement),
          section,
          selectedTypeBien,
          int.parse(surfaceBati),
          int.parse(nbrPiece),
          "S",
          1850000);
    }

    Navigator.pop(context);
  }

  void _showConfirmationDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Confirmation'),
            content: Text('Are you sure you want to submit the form?'),
            actions: <Widget>[
              TextButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text('Submit'),
                onPressed: () {
                  _submitForm();
                },
              ),
            ],
          );
        });
  }

  List<Step> stepList() => [
        Step(
            state: _processIndex <= 0 ? StepState.disabled : StepState.complete,
            isActive: _processIndex >= 0,
            title: const Text("Adresse"),
            content: Column(children: [
              /// DATE PICKER ICI

              text_filed_with_title("Commune", _commune),
              text_filed_with_title("Section ", _section),
              text_filed_with_title("Code postal", _code_postal),
              text_filed_with_title("Code departement", _codedepartement),
              text_filed_with_title("Voie", _voie),
            ])),
        Step(
          state: _processIndex <= 1 ? StepState.disabled : StepState.complete,
          isActive: _processIndex >= 1,
          title: const Text("Type de bien"),
          content: Column(children: [
            const Text(
              "Quel type de bien souhaitez vous estimer ?",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: kSecondaryColor,
                  fontSize: 22),
            ),
            const SizedBox(
              height: 80,
            ),
            Row(children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                decoration: BoxDecoration(
                    border: Border.all(width: 2.0, color: kAccentRed),
                    borderRadius: BorderRadius.circular(30)),
                width: 225,
                height: 150,
                child: RadioListTile(
                  title: Column(
                    children: const [
                      Icon(
                        Icons.house_rounded,
                        color: kAccentRed,
                        size: 60,
                      ),
                      Text("Maison"),
                    ],
                  ),
                  value: "Maison",
                  groupValue: selectedTypeBien,
                  onChanged: (value) {
                    setState(() {
                      selectedTypeBien = value!;
                    });
                  },
                ),
              ),
              const SizedBox(
                width: 30,
              ),
              Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  decoration: BoxDecoration(
                      border: Border.all(width: 2.0, color: kAccentRed),
                      borderRadius: BorderRadius.circular(30)),
                  width: 225,
                  height: 150,
                  child: RadioListTile(
                    title: Column(
                      children: const [
                        Icon(
                          Icons.apartment_rounded,
                          color: kAccentRed,
                          size: 60,
                        ),
                        Text("Appartement"),
                      ],
                    ),
                    value: "Appartement",
                    groupValue: selectedTypeBien,
                    onChanged: (value) {
                      setState(() {
                        selectedTypeBien = value!;
                      });
                    },
                  ))
            ]),
            const SizedBox(
              height: 40,
            )
          ]),
        ),
        Step(
            state: _processIndex <= 2 ? StepState.disabled : StepState.complete,
            isActive: _processIndex >= 2,
            title: const Text("Surface bati en m²"),
            content: text_filed_with_title(
                "Quelle est la surface de votre appartement ?",
                _surfaceBatiController)),
        Step(
            state: _processIndex <= 3 ? StepState.disabled : StepState.complete,
            isActive: _processIndex >= 3,
            title: const Text("Nombre de pièces"),
            content: text_filed_with_title(
                "Combien y a-t-il de pièces ?", _nbrPieceController)),
        Step(
            state: _processIndex <= 4 ? StepState.disabled : StepState.complete,
            isActive: _processIndex >= 4,
            title: const Text("Date"),
            content: Column(children: [
              Text(
                "Sélectionnez la date à laquelle vous souhaitez prévoir la \nvaleur du bien.  ",
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: kSecondaryColor,
                    fontSize: 22),
              ),
              SizedBox(
                height: 20,
              ),
              DropdownDatePicker(
                inputDecoration: InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: kSecondaryColor, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30))), // optional
                isDropdownHideUnderline: true, // optional
                isFormValidator: true, // optional
                startYear: 2023, // optional
                endYear: 2028, // optional
                width: 10, // optional
                // selectedDay: 14, // optional
                selectedMonth: 3,
                selectedYear: 2023,
                onChangedDay: (value) {
                  setState(() {
                    selectedDay = value!;
                  });
                },
                onChangedMonth: (value) {
                  setState(() {
                    selectedMonth = value!;
                  });
                },
                onChangedYear: (value) {
                  setState(() {
                    selectedYear = value!;
                  });
                },
                //boxDecoration: BoxDecoration(
                // border: Border.all(color: Colors.grey, width: 1.0)), // optional
                // showDay: false,// optional
                // dayFlex: 2,// optional
                locale: "fr_FR", // optional
                // hintDay: 'Day', // optional
                // hintMonth: 'Month', // optional
                // hintYear: 'Year', // optional
                // hintTextStyle: TextStyle(color: Colors.grey), // optional
              ),
              SizedBox(
                height: 20,
              ),
            ])),
        /* Step(
            state: _processIndex <= 5 ? StepState.disabled : StepState.complete,
            isActive: _processIndex >= 5,
            title: const Text("Charge "),
            content: text_filed_with_title(
                "A combien s'élèvent vos charges de copropriété mensuelles ?",
                _chargeMensuelle)),
        Step(
            state: _processIndex <= 6 ? StepState.disabled : StepState.complete,
            isActive: _processIndex >= 6,
            title: const Text("Cave"),
            content: text_filed_with_title(
                "Avez-vous une cave si oui donné la surface en m² ?",
                _caveController)),
        Step(
            state: _processIndex <= 7 ? StepState.disabled : StepState.complete,
            isActive: _processIndex >= 7,
            title: const Text("Balcon"),
            content: text_filed_with_title("Nombre de balcon ", _nbrBalcon)),
        Step(
            state: _processIndex <= 8 ? StepState.disabled : StepState.complete,
            isActive: _processIndex >= 8,
            title: const Text("Terrasse"),
            content: Column(children: [
              const Text(
                "Terrasse ?",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: kSecondaryColor,
                    fontSize: 22),
              ),
              const SizedBox(
                height: 80,
              ),
              Row(children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  decoration: BoxDecoration(
                      border: Border.all(width: 2.0, color: kAccentRed),
                      borderRadius: BorderRadius.circular(30)),
                  width: 225,
                  height: 80,
                  child: RadioListTile(
                    title: Column(
                      children: const [
                        Text("Oui"),
                      ],
                    ),
                    value: "Oui",
                    groupValue: selectedTerrasse,
                    onChanged: (value) {
                      setState(() {
                        selectedTerrasse = value;
                      });
                    },
                  ),
                ),
                const SizedBox(
                  width: 30,
                ),
                Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 20),
                    decoration: BoxDecoration(
                        border: Border.all(width: 2.0, color: kAccentRed),
                        borderRadius: BorderRadius.circular(30)),
                    width: 225,
                    height: 80,
                    child: RadioListTile(
                      title: Column(
                        children: const [
                          Text("Non"),
                        ],
                      ),
                      value: "Non",
                      groupValue: selectedTerrasse,
                      onChanged: (value) {
                        setState(() {
                          selectedTerrasse = value;
                        });
                      },
                    ))
              ]),
              const SizedBox(
                height: 40,
              )
            ])),
        Step(
            state: _processIndex <= 9 ? StepState.disabled : StepState.complete,
            isActive: _processIndex >= 9,
            title: const Text("Standing"),
            content: Column(children: [
              const Text(
                "Standing de votre Bien ?",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: kSecondaryColor,
                    fontSize: 22),
              ),
              const SizedBox(
                height: 80,
              ),
              Row(children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  decoration: BoxDecoration(
                      border: Border.all(width: 2.0, color: kAccentRed),
                      borderRadius: BorderRadius.circular(30)),
                  width: 225,
                  height: 80,
                  child: RadioListTile(
                    title: Column(
                      children: const [
                        Text("Moyen"),
                      ],
                    ),
                    value: "Moyen",
                    groupValue: selectedStanding,
                    onChanged: (value) {
                      setState(() {
                        selectedStanding = value;
                      });
                    },
                  ),
                ),
                const SizedBox(
                  width: 30,
                ),
                Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 20),
                    decoration: BoxDecoration(
                        border: Border.all(width: 2.0, color: kAccentRed),
                        borderRadius: BorderRadius.circular(30)),
                    width: 225,
                    height: 80,
                    child: RadioListTile(
                      title: Column(
                        children: const [
                          Text("Standard"),
                        ],
                      ),
                      value: "Standard",
                      groupValue: selectedStanding,
                      onChanged: (value) {
                        setState(() {
                          selectedStanding = value;
                        });
                      },
                    )),
                const SizedBox(
                  width: 30,
                ),
                Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 20),
                    decoration: BoxDecoration(
                        border: Border.all(width: 2.0, color: kAccentRed),
                        borderRadius: BorderRadius.circular(30)),
                    width: 225,
                    height: 80,
                    child: RadioListTile(
                      title: Column(
                        children: const [
                          Text("Exceptionnel"),
                        ],
                      ),
                      value: "Exceptionnel",
                      groupValue: selectedStanding,
                      onChanged: (value) {
                        setState(() {
                          selectedStanding = value;
                        });
                      },
                    ))
              ]),
              const SizedBox(
                height: 40,
              )
            ])),
        Step(
            state:
                _processIndex <= 10 ? StepState.disabled : StepState.complete,
            isActive: _processIndex >= 10,
            title: const Text("Emplacement"),
            content: Column(children: [
              const Text(
                "Enfin, comment qualifiez-vous l'emplacement de votre appartement ?",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: kSecondaryColor,
                    fontSize: 22),
              ),
              const SizedBox(
                height: 80,
              ),
              Row(children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  decoration: BoxDecoration(
                      border: Border.all(width: 2.0, color: kAccentRed),
                      borderRadius: BorderRadius.circular(30)),
                  width: 225,
                  height: 80,
                  child: RadioListTile(
                    title: Column(
                      children: const [
                        Text("Bruyant"),
                      ],
                    ),
                    value: "Bruyant",
                    groupValue: selectedEmplacement,
                    onChanged: (value) {
                      setState(() {
                        selectedEmplacement = value;
                      });
                    },
                  ),
                ),
                const SizedBox(
                  width: 30,
                ),
                Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 20),
                    decoration: BoxDecoration(
                        border: Border.all(width: 2.0, color: kAccentRed),
                        borderRadius: BorderRadius.circular(30)),
                    width: 225,
                    height: 80,
                    child: RadioListTile(
                      title: Column(
                        children: const [
                          Text("Standard"),
                        ],
                      ),
                      value: "Standard",
                      groupValue: selectedEmplacement,
                      onChanged: (value) {
                        setState(() {
                          selectedEmplacement = value;
                        });
                      },
                    )),
                const SizedBox(
                  width: 30,
                ),
                Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 20),
                    decoration: BoxDecoration(
                        border: Border.all(width: 2.0, color: kAccentRed),
                        borderRadius: BorderRadius.circular(30)),
                    width: 225,
                    height: 80,
                    child: RadioListTile(
                      title: Column(
                        children: const [
                          Text("Calme"),
                        ],
                      ),
                      value: "Calme",
                      groupValue: selectedEmplacement,
                      onChanged: (value) {
                        setState(() {
                          selectedEmplacement = value;
                        });
                      },
                    ))
              ]),
              const SizedBox(
                height: 40,
              ),
              const Text(
                  "Bruyant : proche d’artères à circulation dense, voies ferrées, aéroport etc."),
              const Text(
                  "Standard : proche de rues animées, commerces ou restaurants etc."),
              const Text(
                  "Calme : retiré ou donnant sur cour, en zone résidentielle etc.")
            ])),*/
      ];
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 80),
        decoration: BoxDecoration(
            color: kBackgroundColorWhite,
            borderRadius: BorderRadius.circular(30)),
        child: Theme(
            data: ThemeData(
                colorScheme: Theme.of(context).colorScheme.copyWith(
                      primary: kPrimaryColor,
                      secondary: kAccentRed,
                    )),
            child: Stepper(
              controlsBuilder: (context, _) {
                return Row(
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: _.onStepContinue,
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(kPrimaryColor),
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 20),
                        ),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        shadowColor: MaterialStateProperty.all<Color>(
                            kPrimaryColor), // Use `label` to specify the label text of the button
                      ),
                      child: const Text('Continuer',
                          style: TextStyle(
                              color: kBackgroundColorWhite, fontSize: 18)),
                    ),
                    TextButton(
                      onPressed: _.onStepCancel,
                      child: const Text('Retourner'),
                    ),
                  ],
                );
              },
              currentStep: _processIndex,
              steps: stepList(),
              type: StepperType.vertical,
              onStepContinue: () {
                if (_processIndex < (stepList().length - 1)) {
                  _processIndex += 1;
                }
                if (_processIndex + 1 > (stepList().length - 1)) {
                  _showConfirmationDialog();
                }
                setState(() {});
              },
              onStepCancel: () {
                if (_processIndex == 0) {
                  return;
                }

                _processIndex -= 1;
                setState(() {});
              },
            )));
  }
}
