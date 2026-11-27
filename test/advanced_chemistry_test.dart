import 'package:flutter_test/flutter_test.dart';
import 'package:chemmaster/chemistry/electron_configuration.dart';
import 'package:chemmaster/chemistry/equation_balancer.dart';
import 'package:chemmaster/chemistry/formula_parser.dart';
import 'package:chemmaster/chemistry/reaction_predictor.dart';

void main() {
  group('FormulaParser', () {
    test('accepts lowercase formulas without spaces', () {
      expect(FormulaParser.parse('co2'), {'C': 1, 'O': 2});
      expect(FormulaParser.parse('CO2'), {'C': 1, 'O': 2});
      expect(FormulaParser.parse('naoh'), {'Na': 1, 'O': 1, 'H': 1});
      expect(FormulaParser.parse('ca(oh)2'), {'Ca': 1, 'O': 2, 'H': 2});
    });

    test('accepts subscript characters and spaces', () {
      expect(FormulaParser.parse(' H₂ SO₄ '), {'H': 2, 'S': 1, 'O': 4});
    });

    test('preserves correct mixed-case element symbols', () {
      expect(FormulaParser.parse('Co2'), {'Co': 2});
      expect(FormulaParser.parse('Ca(OH)2'), {'Ca': 1, 'O': 2, 'H': 2});
    });
  });

  group('EquationBalancer', () {
    test('balances lowercase input without spaces', () {
      expect(
        EquationBalancer.balance('ch4+o2->co2+h2o'),
        'CH4 + 2O2 → CO2 + 2H2O',
      );
    });

    test('accepts equals and unicode arrows', () {
      expect(
        EquationBalancer.balance('h2 + o2 = h2o'),
        '2H2 + O2 → 2H2O',
      );
      expect(
        EquationBalancer.balance('H2 + O2 ⇒ H2O'),
        '2H2 + O2 → 2H2O',
      );
    });
  });

  group('ReactionPredictor', () {
    test('discovers products from carbon dioxide and water', () {
      final result = ReactionPredictor.predict('co2+h2o');
      expect(result, isNotNull);
      expect(result!.equation, 'CO2 + H2O → H2CO3');
      expect(result.title, contains('ácido carbónico'));
    });

    test('discovers neutralization products', () {
      final result = ReactionPredictor.predict('hcl + koh');
      expect(result, isNotNull);
      expect(result!.equation, 'HCl + KOH → KCl + H2O');
    });

    test('explains soap as a general saponification reaction', () {
      final result = ReactionPredictor.predict('Sabão');
      expect(result, isNotNull);
      expect(result!.isGeneralReaction, isTrue);
      expect(result.equation, contains('RCOONa'));
      expect(result.note, contains('corrosivos'));
    });

    test('does not invent products for an unknown combination', () {
      expect(ReactionPredictor.predict('Na + H2O2'), isNull);
    });
  });

  group('ElectronConfigurationCalculator', () {
    test('calculates common configurations', () {
      expect(
        ElectronConfigurationCalculator.calculate(1).configuration,
        '1s¹',
      );
      expect(
        ElectronConfigurationCalculator.calculate(6).configuration,
        contains('2p²'),
      );
      final chromium = ElectronConfigurationCalculator.calculate(24);
      expect(chromium.configuration, contains('3d⁵'));
      expect(chromium.configuration, contains('4s¹'));
    });

    test('keeps electron totals equal to atomic number for all elements', () {
      for (var atomicNumber = 1; atomicNumber <= 118; atomicNumber++) {
        final result =
            ElectronConfigurationCalculator.calculate(atomicNumber);
        expect(result.totalElectrons, atomicNumber, reason: 'Z=$atomicNumber');
      }
    });
  });
}
