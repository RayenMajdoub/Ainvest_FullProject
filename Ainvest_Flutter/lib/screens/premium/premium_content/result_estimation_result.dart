import 'package:ainvest/screens/premium/premium_content/estimer_bien_form_content/estimer_bien_form_widgets.dart';
import 'package:ainvest/utils/constants.dart';
import 'package:flutter/material.dart';

class resultEstimation extends StatelessWidget {
  final String result;
  const resultEstimation({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Expanded(
            child: Container(
                decoration: BoxDecoration(color: kBackgroundColorLight),
                child: Column(children: [
                  Container(
                      height: 220,
                      child:
                          Image(image: AssetImage('images/AinvestLogo.png'))),
                  Container(
                    height: 350,
                    width: 1480,
                    decoration: BoxDecoration(
                      color: kAccentGreen,
                      image: const DecorationImage(
                        image: AssetImage('images/estimated_value.png'),
                        alignment: Alignment.centerRight,
                        fit: BoxFit.fitHeight,
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
                          width: 650,
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
                                "Nous estimons que la valeur actuelle de votre bien est",
                                style: TextStyle(
                                  color: kSecondaryColor,
                                  fontSize: 20,
                                  height: 1.5,
                                ),
                              ),
                              Text(
                                result,
                                style: TextStyle(
                                    color: kSecondaryColor,
                                    fontSize: 20,
                                    height: 1.5,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 20,
                                width: 30,
                              ),
                              ElevatedButton(
                                onPressed: () {},
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          kPrimaryColor),
                                  padding: MaterialStateProperty.all<
                                      EdgeInsetsGeometry>(
                                    const EdgeInsets.symmetric(
                                        vertical: 20, horizontal: 25),
                                  ),
                                  elevation:
                                      MaterialStateProperty.all<double>(5.0),
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
                                  'Return',
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
                              alignment:
                                  Alignment.center, // Align to the top left
                              child: Column(children: [
                                Titre_avec_underbar(
                                    "L’estimation d’un bien", kAccentRed),
                                const Text(
                                  "L’estimation d’un bien immobilier tient compte de sa localisation, de son environnement\n(commerces, transports), de ses caractéristiques (état, superficie, exposition…) et de la demande.\nPour affiner le calcul du prix de vente vous pouvez également utiliser \ndes simulateurs ou contacter un agent immobilier local.",
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
                                SizedBox(
                                  height: 60,
                                )
                              ]))))
                ]))));
  }
}
