import '../data/periodic_elements.dart';

class FormulaParser {
  static final Set<String> _symbols =
      periodicElements.map((element) => element.symbol).toSet();

  /// Converts forgiving input such as ch4, naoh or Ca(OH)2
  /// into canonical chemical-symbol casing.
  ///
  /// Lowercase symbols prefer one-letter elements when this makes a valid
  /// complete formula. Therefore co2 is interpreted as CO2, while Co is cobalt.
  static String normalize(String formula) {
    final source = formula
        .replaceAll(RegExp(r'\s+'), '')
        .replaceAll('₀', '0')
        .replaceAll('₁', '1')
        .replaceAll('₂', '2')
        .replaceAll('₃', '3')
        .replaceAll('₄', '4')
        .replaceAll('₅', '5')
        .replaceAll('₆', '6')
        .replaceAll('₇', '7')
        .replaceAll('₈', '8')
        .replaceAll('₉', '9');

    if (source.isEmpty) {
      throw const FormatException('A fórmula está vazia.');
    }

    var index = 0;

    String readCount() {
      final start = index;
      while (index < source.length &&
          RegExp(r'[0-9]').hasMatch(source[index])) {
        index++;
      }
      if (start == index) return '';
      final value = int.tryParse(source.substring(start, index));
      if (value == null || value < 1) {
        throw const FormatException('Os índices devem ser números positivos.');
      }
      return source.substring(start, index);
    }

    String sequence({required bool nested}) {
      if (index >= source.length) return '';
      if (source[index] == ')') {
        if (nested) return '';
        throw const FormatException('Parêntese de fecho sem abertura.');
      }

      if (source[index] == '(') {
        index++;
        final inner = sequence(nested: true);
        if (inner.isEmpty || index >= source.length || source[index] != ')') {
          throw const FormatException('Parênteses não fechados ou grupo vazio.');
        }
        index++;
        final multiplier = readCount();
        final rest = sequence(nested: nested);
        return '($inner)$multiplier$rest';
      }

      final first = source[index];
      if (!RegExp(r'[A-Za-z]').hasMatch(first)) {
        throw FormatException('Carácter inesperado na fórmula: $first');
      }

      final candidates = <String>[];
      if (RegExp(r'[A-Z]').hasMatch(first)) {
        if (index + 1 < source.length &&
            RegExp(r'[a-z]').hasMatch(source[index + 1])) {
          final pair =
              first.toUpperCase() + source[index + 1].toLowerCase();
          if (_symbols.contains(pair)) candidates.add(pair);
        }
        final single = first.toUpperCase();
        if (_symbols.contains(single)) candidates.add(single);
      } else {
        final single = first.toUpperCase();
        String? pair;
        if (index + 1 < source.length &&
            RegExp(r'[a-z]').hasMatch(source[index + 1])) {
          final candidate =
              first.toUpperCase() + source[index + 1].toLowerCase();
          if (_symbols.contains(candidate)) pair = candidate;
        }
        // Lowercase input is inherently ambiguous. Prefer common two-letter
        // symbols (si, na, mg, ca, fe, ...) while keeping CO2, NO2 and PO4
        // readable as one-letter element combinations.
        final preferSingle = pair != null &&
            {'Co', 'No', 'Po'}.contains(pair) &&
            (index + 2 >= source.length ||
                RegExp(r'[0-9]').hasMatch(source[index + 2]));
        if (pair != null && !preferSingle) candidates.add(pair);
        if (_symbols.contains(single)) candidates.add(single);
        if (pair != null && preferSingle) candidates.add(pair);
      }

      for (final symbol in candidates) {
        final previous = index;
        index += symbol.length;
        try {
          final count = readCount();
          final rest = sequence(nested: nested);
          return '$symbol$count$rest';
        } on FormatException {
          index = previous;
        }
      }

      throw FormatException('Não reconheci o elemento a partir de "$first".');
    }

    final normalized = sequence(nested: false);
    if (index != source.length || normalized.isEmpty) {
      throw const FormatException('Fórmula química inválida.');
    }
    return normalized;
  }

  static Map<String, int> parse(String formula) {
    final source = normalize(formula);
    var index = 0;

    int number() {
      final start = index;
      while (index < source.length &&
          RegExp(r'[0-9]').hasMatch(source[index])) {
        index++;
      }
      if (start == index) return 1;
      final value = int.parse(source.substring(start, index));
      if (value < 1) {
        throw const FormatException('Os índices devem ser positivos.');
      }
      return value;
    }

    Map<String, int> group({required bool nested}) {
      final result = <String, int>{};
      while (index < source.length && source[index] != ')') {
        if (source[index] == '(') {
          index++;
          final inner = group(nested: true);
          if (index >= source.length || source[index] != ')') {
            throw const FormatException('Parênteses não fechados.');
          }
          index++;
          final multiplier = number();
          inner.forEach((key, value) {
            result[key] = (result[key] ?? 0) + value * multiplier;
          });
        } else if (RegExp(r'[A-Z]').hasMatch(source[index])) {
          final start = index++;
          if (index < source.length &&
              RegExp(r'[a-z]').hasMatch(source[index])) {
            index++;
          }
          final symbol = source.substring(start, index);
          if (!_symbols.contains(symbol)) {
            throw FormatException('Elemento químico desconhecido: $symbol');
          }
          final count = number();
          result[symbol] = (result[symbol] ?? 0) + count;
        } else {
          final unexpected = source[index];
          throw FormatException('Carácter inesperado na fórmula: $unexpected');
        }
      }
      if (!nested && index < source.length) {
        throw const FormatException('Parêntese de fecho sem abertura.');
      }
      return result;
    }

    final result = group(nested: false);
    if (index != source.length || result.isEmpty) {
      throw const FormatException('Fórmula química inválida.');
    }
    return result;
  }
}
