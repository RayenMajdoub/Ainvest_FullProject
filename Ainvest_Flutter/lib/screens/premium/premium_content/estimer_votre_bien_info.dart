import 'package:ainvest/screens/premium/premium_content/estimer_bien_form_content/estimer_bien_form_widgets.dart';
import 'package:ainvest/utils/constants.dart';
import 'package:flutter/material.dart';
import '../../../utils/responsive.dart';
import '../../../utils/size_config.dart';
import 'estimer_bien_form.dart';

class EstimerPageInit extends StatefulWidget {
  const EstimerPageInit({super.key});

  @override
  State<EstimerPageInit> createState() => _EstimerPageInitState();
}

class _EstimerPageInitState extends State<EstimerPageInit> {
  int _selectedIndex = 0;
  void on_content_changed(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _build_content_changed() {
    switch (_selectedIndex) {
      case 1:
        return Responsive.isDesktop(context)
            ? SizedBox(height: 900, width: 1000, child: EstimerBienForm())
            : SizedBox(
                height: SizeConfig.screenHeight,
                width: SizeConfig.screenWidth,
                child: EstimerBienForm());

      default:
        return Responsive.isDesktop(context)
            ? Column(
                children: [
                  Container(
                    height: 350,
                    width: 1480,
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                        image: AssetImage('images/estimer_image.png'),
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
                                "Nous estimons la valeur actuelle d'un bien à partir ",
                                style: TextStyle(
                                  color: kSecondaryColor,
                                  fontSize: 20,
                                  height: 1.5,
                                ),
                              ),
                              const Text(
                                " de ses caractéristiques et du marché local ",
                                style: TextStyle(
                                    color: kSecondaryColor,
                                    fontSize: 20,
                                    height: 1.5,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 40,
                                width: 30,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  on_content_changed(1);
                                },
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
                                  'Estimer votre bien',
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
                                  Alignment.topLeft, // Align to the top left
                              child: Row(
                                children: [
                                  Column(
                                    children: [
                                      Titre_avec_underbar(
                                          "Comment estimer un bien ?",
                                          kAccentRed),
                                      const Text(
                                        "L’estimation d’un bien immobilier tient compte de sa localisation, de son environnement\n(commerces, transports), de ses caractéristiques (état, superficie, exposition…) et de la demande.\nPour affiner le calcul du prix de vente vous pouvez également utiliser \ndes simulateurs ou contacter un agent immobilier local.",
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
                                          height:
                                              2, // Add padding between lines
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
                                            height:
                                                2, // Add padding between lines
                                            fontWeight: FontWeight
                                                .bold // Make the font bold
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
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 10, 10, 0),
                                        decoration: BoxDecoration(
                                            color: kAccentRed,
                                            borderRadius:
                                                BorderRadius.circular(40)),
                                        child: Column(children: const [
                                          Image(
                                            image: AssetImage(
                                                'images/house_hand.png'),
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
              )
            : Column(
                children: [
                  Align(
                    alignment: FractionalOffset.center,
                    child: Container(
                      height: 350,
                      width: SizeConfig.screenWidth,
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
                            "Nous estimons la valeur actuelle d'un bien à partir ",
                            style: TextStyle(
                              color: kSecondaryColor,
                              fontSize: 20,
                              height: 1.5,
                            ),
                          ),
                          const Text(
                            " de ses caractéristiques et du marché local ",
                            style: TextStyle(
                                color: kSecondaryColor,
                                fontSize: 20,
                                height: 1.5,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 40,
                            width: 30,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              on_content_changed(1);
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  kPrimaryColor),
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
                              'Estimer votre bien',
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
                  const SizedBox(
                    height: 40,
                  ),
                  Container(
                      decoration: BoxDecoration(
                          color: kBackgroundColorWhite,
                          borderRadius: BorderRadius.circular(40)),
                      width: SizeConfig.screenWidth,
                      padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
                      child: Expanded(
                          child: Align(
                              alignment:
                                  Alignment.topLeft, // Align to the top left
                              child: Column(
                                children: [
                                  Titre_avec_underbar(
                                      "Comment estimer un bien ?", kAccentRed),
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
                                      width: SizeConfig.screenWidth,
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
                                      width: SizeConfig.screenWidth,
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
                                        fontWeight: FontWeight
                                            .bold // Make the font bold
                                        ),
                                    textAlign: TextAlign.left,
                                    // Center the text
                                  ),
                                  Container(
                                    height: 200,
                                    width: 220,
                                    padding: const EdgeInsets.fromLTRB(
                                        10, 10, 10, 0),
                                    decoration: BoxDecoration(
                                        color: kAccentRed,
                                        borderRadius:
                                            BorderRadius.circular(40)),
                                    child: Column(children: const [
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
                                ],
                              ))))
                ],
              );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        SizedBox(
          height: 40,
        ),
        _build_content_changed(),
      ]),
    );
  }
}
