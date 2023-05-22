import 'package:ainvest/screens/premium/premium_content/estimer_bien_form_content/estimer_bien_form_widgets.dart';
import 'package:ainvest/screens/premium/premium_content/predict_bien_form.dart';
import 'package:ainvest/utils/constants.dart';
import 'package:flutter/material.dart';

class SuggestionPage extends StatefulWidget {
  const SuggestionPage({super.key});

  @override
  State<SuggestionPage> createState() => _SuggestionPageState();
}

class _SuggestionPageState extends State<SuggestionPage> {
  int _selectedIndex = 0;
  void on_content_changed(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
 
  Widget _build_content_changed() {
    switch (_selectedIndex) {
      case 1:
        return SizedBox(height: 900, width: 1000, child: PredictBienForm());
      default:
        return Column(
          children: [
            Container(
              height: 350,
              width: 1480,
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: AssetImage('images/prediction_banner.jpg'),
                  fit: BoxFit.fitWidth,
                ),
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Positioned(
                top: 0,
                bottom: 0,
                left: 0,
                right: 0,
                child: Align(
                  alignment: FractionalOffset.center,
                  child: Container(
                    height: 200,
                    width: 600,
                    padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
                    decoration: BoxDecoration(
                      color: kBackgroundColorWhite,
                      borderRadius: BorderRadius.circular(30.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 4,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        const Text(
                          "Nous prédisons la valeur actuelle d'un bien en utilisant",
                          style: TextStyle(
                            color: kSecondaryColor,
                            fontSize: 18,
                            height: 1.5,
                          ),
                        ),
                        const Text(
                          "ses caractéristiques ainsi que les tendances du marché local.",
                          style: TextStyle(
                              color: kSecondaryColor,
                              fontSize: 18,
                              height: 1.5,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 30,
                          width: 30,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            on_content_changed(1);
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(kPrimaryColor),
                            padding:
                                MaterialStateProperty.all<EdgeInsetsGeometry>(
                              const EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 25),
                            ),
                            elevation: MaterialStateProperty.all<double>(5.0),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            shadowColor: MaterialStateProperty.all<Color>(
                                kPrimaryColor), // Use `label` to specify the label text of the button
                          ),
                          child: const Text(
                            'Prédire un bien',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Container(
                decoration: BoxDecoration(
                    color: kBackgroundColorWhite,
                    borderRadius: BorderRadius.circular(40)),
                width: 1150,
                padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
                child: Expanded(
                    child: Align(
                        alignment: Alignment.topLeft, // Align to the top left
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Titre_avec_underbar(
                                    "Comment prédire la valeur d'un bien ?",
                                    kAccentRed),
                                const Text(
                                  " Pour prédire la valeur d'un bien, il est important de prendre en compte plusieurs \nfacteurs, tels que l'emplacement, la taille, l'état du bien, \nles équipements et les services à proximité, ainsi que les tendances du marché \nimmobilier local. Il est également essentiel de réaliser une analyse \ncomparative avec des biens similaires qui ont récemment été vendus\n dans la même zone géographique Cette analyse comparative permet de déterminer\n. un prix de référence qui servira de base à la prédiction de la valeur du bien en question.\nPour affiner le calcul du prix de vente vous pouvez également utiliser \ndes simulateurs ou contacter un agent immobilier local.",
                                  style: TextStyle(
                                    color: kSecondaryColor,
                                    fontSize: 16,
                                    height: 2, // Add padding between lines
                                    // Make the font bold
                                  ),
                                  textAlign: TextAlign.left,
                                  // Center the text
                                ),
                                const SizedBox(height: 40),
                                Container(
                                    width: 800,
                                    decoration: BoxDecoration(
                                        color: kAccentLightYellow,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    padding: const EdgeInsets.fromLTRB(
                                        30, 10, 30, 30),
                                    child: Column(children: const [
                                      Text("👉 Bon à savoir",
                                          style: TextStyle(
                                            color: kSecondaryColor,
                                            fontSize: 16,
                                            height:
                                                2, // Add padding between lines
                                            fontWeight: FontWeight
                                                .bold, // Make the font bold
                                          )),
                                      Text(
                                        "Il faut garder à l’esprit que votre logement a une valeur de marché, qui ne correspond pas toujours au prix auquel vous l’avez acheté. En effet, cette valeur dépend de l’évolution des prix de l’immobilier, de l’offre et de la demande au moment de la mise en vente.",
                                        style: TextStyle(
                                          color: kSecondaryColor,
                                          fontSize: 16,
                                          height:
                                              2, // Add padding between lines
                                          // Make the font bold
                                        ),
                                        textAlign: TextAlign.left,
                                        // Center the text
                                      ),
                                    ])),
                                const SizedBox(height: 40),
                                Titre_avec_underbar(
                                    "Contacter une agence immobilière pour \nfaire une estimation gratuite?",
                                    kAccentRed),
                                const Text(
                                  "Aujourd'hui, bien estimer sa maison ou son appartement est essentiel, dans la mesure où \nles acheteurs potentiels sont mieux informés qu'auparavant.",
                                  style: TextStyle(
                                    color: kSecondaryColor,
                                    fontSize: 16,
                                    height: 2, // Add padding between lines
                                    // Make the font bold
                                  ),
                                  textAlign: TextAlign.left,
                                  // Center the text
                                ),
                                const SizedBox(height: 40),
                                Container(
                                    width: 800,
                                    decoration: BoxDecoration(
                                        color: kAccentLightYellow,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    padding: const EdgeInsets.fromLTRB(
                                        30, 10, 30, 30),
                                    child: Column(children: const [
                                      Text("👉 Bon à savoir",
                                          style: TextStyle(
                                            color: kSecondaryColor,
                                            fontSize: 16,
                                            height:
                                                2, // Add padding between lines
                                            fontWeight: FontWeight
                                                .bold, // Make the font bold
                                          )),
                                      Text(
                                        "En effet, avec Internet, ils peuvent consulter des milliers d'annonces immobilières, et donc comparer les biens immobiliers entre eux. Par ailleurs, ils suivent l'actualité immobilière et connaissent donc la conjoncture du marché : prix de l'immobilier dans chaque ville et quartier, prix moyen des maisons et appartements, délais de vente, etc. Le vendeur pourra trouver en l’agent immobilier le meilleur allié pour réussir la vente de son bien",
                                        style: TextStyle(
                                          color: kSecondaryColor,
                                          fontSize: 16,
                                          height:
                                              2, // Add padding between lines
                                          // Make the font bold
                                        ),
                                        textAlign: TextAlign.left,
                                        // Center the text
                                      ),
                                    ])),
                                const SizedBox(height: 40),
                                const Text(
                                  "75% des vendeurs contactent un professionnel pour obtenir une estimation fiable et ainsi \nvendre au meilleur prix.",
                                  style: TextStyle(
                                      color: kSecondaryColor,
                                      fontSize: 14,
                                      height: 2, // Add padding between lines
                                      fontWeight:
                                          FontWeight.bold // Make the font bold
                                      ),
                                  textAlign: TextAlign.left,
                                  // Center the text
                                ),
                                const SizedBox(height: 40),
                              ],
                            ),
                            const Spacer(),
                            Column(
                              children: [
                                Container(
                                  height: 380,
                                  width: 220,
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 10, 10, 0),
                                  decoration: BoxDecoration(
                                      color: kAccentRed,
                                      borderRadius: BorderRadius.circular(40)),
                                  child: Column(children: const [
                                    Image(
                                      image:
                                          AssetImage('images/house_hand.png'),
                                      height: 200,
                                      width: 200,
                                    ),
                                    Text(
                                        "Besoin d'aide pour trouver l'agent qui fera la différence ? SeLoger s'en charge pour vous.",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          height:
                                              2, // Add padding between lines
                                          fontWeight: FontWeight
                                              .bold, // Make the font bold
                                        ))
                                  ]),
                                  // Align to the top left
                                ),
                                const SizedBox(
                                  height: 490,
                                )
                              ],
                            )
                          ],
                        )))),
          ],
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(
        height: 40,
      ),
      _build_content_changed(),
    ]);
  }
}
