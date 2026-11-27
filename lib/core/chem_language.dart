import 'package:flutter/widgets.dart';

bool isEnglish(BuildContext context) =>
    Localizations.localeOf(context).languageCode == 'en';

String chemText(BuildContext context, String portuguese, String english) =>
    isEnglish(context) ? english : portuguese;

String prettyFormula(String formula) {
  const subscripts = {
    '0': '₀', '1': '₁', '2': '₂', '3': '₃', '4': '₄',
    '5': '₅', '6': '₆', '7': '₇', '8': '₈', '9': '₉',
  };
  return formula.replaceAllMapped(
    RegExp(r'([A-Za-z\)])([0-9]+)'),
    (match) => match.group(1)! +
        match.group(2)!.split('').map((digit) => subscripts[digit]!).join(),
  );
}

String prettyEquation(String equation) {
  final arrowParts = equation.split('→');
  if (arrowParts.length != 2) return prettyFormula(equation);
  return _prettySide(arrowParts[0]) + ' → ' + _prettySide(arrowParts[1]);
}

String _prettySide(String side) {
  return side.split('+').map((part) {
    final trimmed = part.trim();
    final match = RegExp(r'^([0-9]+)?(.+)$').firstMatch(trimmed);
    if (match == null) return prettyFormula(trimmed);
    return (match.group(1) ?? '') + prettyFormula(match.group(2)!);
  }).join(' + ');
}
