import 'formula_parser.dart';

class AtomBalance {
  final String element;
  final int reactants;
  final int products;

  const AtomBalance({
    required this.element,
    required this.reactants,
    required this.products,
  });

  bool get isBalanced => reactants == products;
}

class EquationAnalysis {
  static Map<String, AtomBalance> analyze(String equation) {
    final sides = equation.split('→');
    if (sides.length != 2) {
      throw const FormatException('A equação deve ter uma seta entre reagentes e produtos.');
    }

    final totals = <String, List<int>>{
      // The list holds [reactant count, product count].
    };

    for (var sideIndex = 0; sideIndex < 2; sideIndex++) {
      final terms = sides[sideIndex].split('+');
      if (terms.any((term) => term.trim().isEmpty)) {
        throw const FormatException('A equação contém uma substância vazia.');
      }

      for (final term in terms) {
        final match = RegExp(r'^\s*([0-9]+)?\s*(.+?)\s*$').firstMatch(term);
        if (match == null) {
          throw FormatException('Não foi possível interpretar: $term');
        }

        final coefficient = int.tryParse(match.group(1) ?? '1');
        if (coefficient == null || coefficient < 1) {
          throw const FormatException('Os coeficientes devem ser inteiros positivos.');
        }

        final atoms = FormulaParser.parse(match.group(2)!);
        for (final entry in atoms.entries) {
          totals.putIfAbsent(entry.key, () => [0, 0]);
          totals[entry.key]![sideIndex] += entry.value * coefficient;
        }
      }
    }

    final elements = totals.keys.toList()..sort();
    return {
      for (final element in elements)
        element: AtomBalance(
          element: element,
          reactants: totals[element]![0],
          products: totals[element]![1],
        ),
    };
  }

  static bool isBalanced(String equation) =>
      analyze(equation).values.every((line) => line.isBalanced);
}
).firstMatch(term);
        if (match == null) {
          throw FormatException('Não foi possível interpretar: $term');
        }

        final coefficient = int.tryParse(match.group(1) ?? '1');
        if (coefficient == null || coefficient < 1) {
          throw const FormatException('Os coeficientes devem ser inteiros positivos.');
        }

        final atoms = FormulaParser.parse(match.group(2)!);
        for (final entry in atoms.entries) {
          totals.putIfAbsent(entry.key, () => [0, 0]);
          totals[entry.key]![sideIndex] += entry.value * coefficient;
        }
      }
    }

    final elements = totals.keys.toList()..sort();
    return {
      for (final element in elements)
        element: AtomBalance(
          element: element,
          reactants: totals[element]![0],
          products: totals[element]![1],
        ),
    };
  }

  static bool isBalanced(String equation) =>
      analyze(equation).values.every((line) => line.isBalanced);
}
