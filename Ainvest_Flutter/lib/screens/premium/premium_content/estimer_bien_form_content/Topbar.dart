import 'package:ainvest/providers/commune_section_provider.dart';
import 'package:ainvest/rest/api_bien.dart';
import 'package:ainvest/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

import '../../../../rest/api_stat.dart';
import '../history_stats.dart';

class FilterOption {
  final String text;
  final IconData iconData;
  bool selected;

  FilterOption({
    required this.text,
    required this.iconData,
    this.selected = false,
  });
}

class FilterPopup extends StatefulWidget {
  final String selector;
  final Function(PlotsData) onSearchComplete;
  FilterPopup({required this.onSearchComplete, required this.selector});
  @override
  _FilterPopupState createState() => _FilterPopupState();
}

_buildFilterButton(
    String text, context, final Function(PlotsData) onSearchComplete) {
  return InkWell(
    onTap: () {
      showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          // <-- SEE HERE
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(30.0),
          ),
        ),
        builder: (BuildContext context) {
          return FilterPopup(
              selector: text, onSearchComplete: onSearchComplete);
        },
      );
    },
    child: Container(
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.white,
            border: Border.all(
              color: kSecondaryColor,
              width: 1,
            )),
        child: Text(
          text,
          style: TextStyle(
              color: kSecondaryColor,
              fontSize: 14,
              fontWeight: FontWeight.bold),
        )),
  );
}

class _FilterPopupState extends State<FilterPopup> {
  Map<FilterOption, String> options = {
    FilterOption(text: 'Appartement', iconData: Icons.apartment): "Appartement",
    FilterOption(text: 'Maison', iconData: Icons.home): "Maison",
    FilterOption(text: 'Terrain', iconData: Icons.landscape): "Terrain",
    FilterOption(text: 'Local commercial', iconData: Icons.store):
        "Local commercial",
  };

  Map<FilterOption, int> options_nbr = {
    FilterOption(text: '1', iconData: Icons.apartment): 1,
    FilterOption(text: '2', iconData: Icons.home): 2,
    FilterOption(text: '3', iconData: Icons.landscape): 3,
    FilterOption(text: '4', iconData: Icons.store): 4,
    FilterOption(text: '5+', iconData: Icons.store): 5,
  };

  List<String> allKeys = commune_with_section.keys.toList();

  static String? typelocal = null;
  static String? section = null;
  static String? commune = null;
  static String? codepostal = null;
  static String? year = "";
  static String? month = "";
  static String? nbr_piece = "";
  static int? surfacerealbatimax = 0;
  static int? surfacerealbatimin = 0;
  static int? max_budget = 0;
  static int? min_budget = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30),
      height: 400,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        color: Colors.white,
      ),
      child: sheetContent(widget.selector, widget.onSearchComplete),
    );
  }

  Widget sheetContent(
      String selector, final Function(PlotsData) onSearchComplete) {
    switch (selector) {
      case 'Type local':
        {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: Text(
                  'Filtrer par type local',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: options.keys.map((option) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        option.selected = !option.selected;
                        if (option.selected) {
                          typelocal = options[option];
                        }
                      });
                    },
                    child: Column(
                      children: [
                        CircleAvatar(
                          child: Icon(
                            option.iconData,
                            color:
                                option.selected ? kPrimaryColor : Colors.white,
                          ),
                          backgroundColor: option.selected
                              ? kPrimaryColor.withOpacity(0.2)
                              : Colors.grey.withOpacity(0.5),
                          radius: 25,
                        ),
                        SizedBox(height: 8),
                        Text(
                          option.text,
                          style: TextStyle(
                              color: option.selected
                                  ? kPrimaryColor
                                  : Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
              Spacer(),
              Divider(thickness: 2),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Spacer(),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Annuler',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(width: 40),
                  Container(
                      child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: kAccentRed),
                    onPressed: () {
                      search(
                              "",
                              max_budget == 0 ? "" : max_budget.toString(),
                              min_budget == 0 ? "" : min_budget.toString(),
                              typelocal ?? "",
                              "",
                              codepostal ?? "",
                              commune ?? "",
                              "",
                              nbr_piece ?? "",
                              surfacerealbatimin == 0
                                  ? ""
                                  : surfacerealbatimin.toString(),
                              surfacerealbatimax == 0
                                  ? ""
                                  : surfacerealbatimax.toString(),
                              section ?? "")
                          .then((value) => onSearchComplete(value!));
                    },
                    child: Text(
                      'Appliquer',
                      style: TextStyle(color: Colors.white),
                    ),
                  )),
                  Spacer()
                ],
              ),
            ],
          );
        }
      case 'Budget':
        {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: Text(
                  'Pour quel budget ?',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 60),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text(
                        "Min",
                        style: TextStyle(
                            color: kSecondaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 16),
                      SizedBox(
                          width: 300,
                          child: TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                  color: kSecondaryColor,
                                  width: 1,
                                ),
                              ),
                              suffixIcon: Padding(
                                padding: const EdgeInsets.only(right: 10.0),
                                child: Icon(Icons.euro),
                              ),
                            ),
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            onChanged: (newValue) {
                              setState(() {
                                min_budget = int.parse(newValue);
                              });
                            },
                          ))
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "Max",
                        style: TextStyle(
                            color: kSecondaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 16),
                      SizedBox(
                          width: 300,
                          child: TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                  color: kSecondaryColor,
                                  width: 1,
                                ),
                              ),
                              suffixIcon: Padding(
                                padding: const EdgeInsets.only(right: 10.0),
                                child: Icon(Icons.euro),
                              ),
                            ),
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            onChanged: (newValue) {
                              setState(() {
                                max_budget = int.parse(newValue);
                              });
                            },
                          ))
                    ],
                  ),
                ],
              ),
              Spacer(),
              Divider(thickness: 2),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Spacer(),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Annuler',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(width: 40),
                  Container(
                      child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: kAccentRed),
                    onPressed: () {
                      search(
                              "",
                              max_budget == 0 ? "" : max_budget.toString(),
                              min_budget == 0 ? "" : min_budget.toString(),
                              typelocal ?? "",
                              "",
                              codepostal ?? "",
                              commune ?? "",
                              "",
                              nbr_piece ?? "",
                              surfacerealbatimin == 0
                                  ? ""
                                  : surfacerealbatimin.toString(),
                              surfacerealbatimax == 0
                                  ? ""
                                  : surfacerealbatimax.toString(),
                              section ?? "")
                          .then((value) => onSearchComplete(value!));
                    },
                    child: Text(
                      'Appliquer',
                      style: TextStyle(color: Colors.white),
                    ),
                  )),
                  Spacer()
                ],
              ),
            ],
          );
        }
      case 'Surface':
        {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: Text(
                  'Quelle surface habitable ?',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 60),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text(
                        "Min",
                        style: TextStyle(
                            color: kSecondaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 16),
                      SizedBox(
                          width: 300,
                          child: TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                  color: kSecondaryColor,
                                  width: 1,
                                ),
                              ),
                              suffixIcon: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text("m²",
                                    style: TextStyle(
                                        color: kSecondaryColor,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                            style: TextStyle(color: kSecondaryColor),
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            onChanged: (newValue) {
                              setState(() {
                                surfacerealbatimin = int.parse(newValue);
                              });
                            },
                          ))
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "Max",
                        style: TextStyle(
                            color: kSecondaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 16),
                      SizedBox(
                          width: 300,
                          child: TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                  color: kSecondaryColor,
                                  width: 1,
                                ),
                              ),
                              suffixIcon: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text("m²",
                                    style: TextStyle(
                                        color: kSecondaryColor,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                            style: TextStyle(color: kSecondaryColor),
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            onChanged: (newValue) {
                              setState(() {
                                surfacerealbatimax = int.parse(newValue);
                              });
                            },
                          ))
                    ],
                  ),
                ],
              ),
              Spacer(),
              Divider(thickness: 2),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Spacer(),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Annuler',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(width: 40),
                  Container(
                      child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: kAccentRed),
                    onPressed: () {
                      search(
                              "",
                              max_budget == 0 ? "" : max_budget.toString(),
                              min_budget == 0 ? "" : min_budget.toString(),
                              typelocal ?? "",
                              "",
                              codepostal ?? "",
                              commune ?? "",
                              "",
                              nbr_piece ?? "",
                              surfacerealbatimin == 0
                                  ? ""
                                  : surfacerealbatimin.toString(),
                              surfacerealbatimax == 0
                                  ? ""
                                  : surfacerealbatimax.toString(),
                              section ?? "")
                          .then((value) => onSearchComplete(value!));
                    },
                    child: Text(
                      'Appliquer',
                      style: TextStyle(color: Colors.white),
                    ),
                  )),
                  Spacer()
                ],
              ),
            ],
          );
        }
      case 'Localité':
        {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: Text(
                  'Filtrer par type Localité',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 60),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text(
                        "Commune",
                        style: TextStyle(
                            color: kSecondaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      DropdownButton(
                        //  value: commune, // set the selected value

                        items: allKeys.map<DropdownMenuItem<String>>((value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        value: commune,
                        hint: Text("Choisir une commune"),
                        onChanged: (String? value) {
                          setState(() {
                            commune = value ?? "";
                            print(commune); //
                          });
                        },
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "Section",
                        style: TextStyle(
                            color: kSecondaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      DropdownButton(
                        onChanged: (value) {
                          setState(() {
                            section = value ?? "";
                            print(section); //
                          });
                        },
                        hint: Text("Choisir une Section"),
                        value:
                            section, // set the value property to the selected section
                        items: commune != null
                            ? commune_with_section[commune]!
                                .map<DropdownMenuItem<String>>((value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList()
                            : null,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "Code postal",
                        style: TextStyle(
                            color: kSecondaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      SizedBox(
                          width: 300,
                          child: TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                  color: kSecondaryColor,
                                  width: 1,
                                ),
                              ),
                              suffixIcon: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Icon(Icons.location_city),
                              ),
                            ),
                            style: TextStyle(color: kSecondaryColor),
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            onChanged: (newValue) {
                              setState(() {
                                codepostal = newValue;
                              });
                            },
                          ))
                    ],
                  )
                ],
              ),
              Spacer(),
              Divider(thickness: 2),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Spacer(),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Annuler',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(width: 40),
                  Container(
                      child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: kAccentRed),
                    onPressed: () {
                      search(
                              "",
                              max_budget == 0 ? "" : max_budget.toString(),
                              min_budget == 0 ? "" : min_budget.toString(),
                              typelocal ?? "",
                              "",
                              codepostal ?? "",
                              commune ?? "",
                              "",
                              nbr_piece ?? "",
                              surfacerealbatimin == 0
                                  ? ""
                                  : surfacerealbatimin.toString(),
                              surfacerealbatimax == 0
                                  ? ""
                                  : surfacerealbatimax.toString(),
                              section ?? "")
                          .then((value) => onSearchComplete(value!));
                    },
                    child: Text(
                      'Appliquer',
                      style: TextStyle(color: Colors.white),
                    ),
                  )),
                  Spacer()
                ],
              ),
            ],
          );
        }
      case 'Pièces':
        {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: Text(
                  'Combien de pièces ?',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: options_nbr.keys.map((option) {
                  return Padding(
                      padding: EdgeInsets.all(10),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            option.selected = !option.selected;
                            if (option.selected) {
                              nbr_piece = options[option].toString();
                            }
                          });
                        },
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: kSecondaryColor,
                                  width: 1,
                                ),
                              ),
                              child: CircleAvatar(
                                child: Text(
                                  option.text,
                                  style: TextStyle(
                                    color: option.selected
                                        ? kPrimaryColor
                                        : kSecondaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                backgroundColor: option.selected
                                    ? kPrimaryColor.withOpacity(0.2)
                                    : Colors.white.withOpacity(0.5),
                                radius: 25,
                              ),
                            ),
                            SizedBox(height: 8),
                          ],
                        ),
                      ));
                }).toList(),
              ),
              Spacer(),
              Divider(thickness: 2),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Spacer(),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Annuler',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(width: 40),
                  Container(
                      child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: kAccentRed),
                    onPressed: () {
                      search(
                              "",
                              max_budget == 0 ? "" : max_budget.toString(),
                              min_budget == 0 ? "" : min_budget.toString(),
                              typelocal ?? "",
                              "",
                              codepostal ?? "",
                              commune ?? "",
                              "",
                              nbr_piece ?? "",
                              surfacerealbatimin == 0
                                  ? ""
                                  : surfacerealbatimin.toString(),
                              surfacerealbatimax == 0
                                  ? ""
                                  : surfacerealbatimax.toString(),
                              section ?? "")
                          .then((value) => onSearchComplete(value!));
                    },
                    child: Text(
                      'Appliquer',
                      style: TextStyle(color: Colors.white),
                    ),
                  )),
                  Spacer()
                ],
              ),
            ],
          );
        }
      default:
        return Container(
          width: 0,
          height: 0,
        );
    }
  }
}

class TopBar extends StatefulWidget {
  final Function(PlotsData) onSearchComplete;
  TopBar({required this.onSearchComplete});

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildFilterButton('Type local', context, widget.onSearchComplete),
            SizedBox(width: 10),
            _buildFilterButton('Localité', context, widget.onSearchComplete),
            SizedBox(width: 10),
            _buildFilterButton('Budget', context, widget.onSearchComplete),
            SizedBox(width: 10),
            _buildFilterButton('Surface', context, widget.onSearchComplete),
            SizedBox(width: 10),
            _buildFilterButton('Pièces', context, widget.onSearchComplete),
            SizedBox(width: 10),
            _buildFilterButton(
                '+de critères', context, widget.onSearchComplete),
          ],
        ),
      ),
    );
  }
}
