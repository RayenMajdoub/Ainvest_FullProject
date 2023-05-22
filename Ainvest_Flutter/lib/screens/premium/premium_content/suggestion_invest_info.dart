import 'package:ainvest/utils/constants.dart';
import 'package:flutter/material.dart';

import 'estimer_bien_form_content/estimer_bien_form_widgets.dart';

class SuggestionInfo extends StatefulWidget {
  const SuggestionInfo({super.key});

  @override
  State<SuggestionInfo> createState() => _SuggestionInfoState();
}

class _SuggestionInfoState extends State<SuggestionInfo> {
  @override
  Widget build(BuildContext context) {
    return Titre_avec_underbar(
        "Comment estimer un bien immobilier gratuitement ?", kAccentRed);
  }
}
