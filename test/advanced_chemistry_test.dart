import 'package:flutter_test/flutter_test.dart';
import 'package:chemmaster/chemistry/electron_configuration.dart';
import 'package:chemmaster/chemistry/equation_balancer.dart';
import 'package:chemmaster/chemistry/equation_analysis.dart';
import 'package:chemmaster/chemistry/formula_parser.dart';
import 'package:chemmaster/chemistry/reaction_predictor.dart';
import 'package:chemmaster/data/chemical_catalog.dart';
import 'package:chemmaster/data/chemistry_glossary.dart';
import 'package:chemmaster/data/reaction_localization.dart';

void main() {
  group('FormulaParser', () {
    test('accepts lowercase formulas without spaces', () {
      expect(FormulaParser.parse('co2'), {'C': 1, 'O': 2});
      expect(FormulaParser.parse('CO2'), {'C': 1, 'O': 2});
      expect(FormulaParser.parse('naoh'), {'Na': 1, 'O': 1, 'H': 1});
      expect(FormulaParser.parse('ca(oh)2'), {'Ca': 1, 'O': 2, 'H': 2});
      expect(FormulaParser.parse('sio2'), {'Si': 1, 'O': 2});
      expect(FormulaParser.parse('no2'), {'N': 1, 'O': 2});
      expect(FormulaParser.parse('po4'), {'P': 1, 'O': 4});
      expect(FormulaParser.parse('cocl2'), {'Co': 1, 'Cl': 2});
      expect(FormulaParser.parse('nh3'), {'N': 1, 'H': 3});
    });

    test('accepts subscript characters and spaces', () {
      expect(FormulaParser.parse(' H₂ SO₄ '), {'H': 2, 'S': 1, 'O': 4});
    });

    test('preserves correct mixed-case element symbols', () {
      expect(FormulaParser.parse('Co2'), {'Co': 2});
      expect(FormulaParser.parse('Ca(OH)2'), {'Ca': 1, 'O': 2, 'H': 2});
    });
  });



  group('Chemistry glossary', () {
    test('contains useful bilingual chemistry learning terms', () {
      expect(chemistryGlossary.length, greaterThanOrEqualTo(30));
      expect(chemistryGlossary.any((term) => term.id == 'coefficient'), isTrue);
      expect(chemistryGlossary.any((term) => term.id == 'isotope'), isTrue);
      expect(chemistryGlossary.any((term) => term.id == 'mole'), isTrue);
      expect(chemistryGlossary.every((term) =>
        term.termPt.isNotEmpty &&
        term.termEn.isNotEmpty &&
        term.definitionPt.isNotEmpty &&
        term.definitionEn.isNotEmpty), isTrue);
    });
  });

  group('Chemical catalog', () {
    test('contains all 118 elements and separates compound entries', () {
      expect(periodicSpecies.length, 118);
      expect(periodicSpecies.every((item) => item.isElement), isTrue);
      expect(commonSubstances.every((item) => !item.isElement), isTrue);
      expect(chemicalCatalog.length, periodicSpecies.length + commonSubstances.length);
    });

    test('uses molecular forms for common elemental reactants', () {
      final sulfur = periodicSpecies.firstWhere((item) => item.elementSymbol == 'S');
      final phosphorus = periodicSpecies.firstWhere((item) => item.elementSymbol == 'P');
      final oxygen = periodicSpecies.firstWhere((item) => item.elementSymbol == 'O');
      expect(formulaForReaction(sulfur), 'S8');
      expect(formulaForReaction(phosphorus), 'P4');
      expect(formulaForReaction(oxygen), 'O2');
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


  group('EquationAnalysis', () {
    test('checks every element on both sides of a balanced equation', () {
      final result = EquationAnalysis.analyze(
        'CH4 + 2O2 → CO2 + 2H2O',
      );
      expect(result['C']!.reactants, 1);
      expect(result['C']!.products, 1);
      expect(result['H']!.reactants, 4);
      expect(result['H']!.products, 4);
      expect(result['O']!.reactants, 4);
      expect(result['O']!.products, 4);
      expect(EquationAnalysis.isBalanced('CH4 + 2O2 → CO2 + 2H2O'), isTrue);
    });

    test('detects an equation with missing oxygen atoms', () {
      expect(EquationAnalysis.isBalanced('CH4 + O2 → CO2 + H2O'), isFalse);
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


    test('recognizes elemental sulfur in its molecular form', () {
      final result = ReactionPredictor.predict('fe + s8');
      expect(result, isNotNull);
      expect(result!.equation, '8Fe + S8 → 8FeS');
    });

    test('discovers common decomposition and combustion examples', () {
      final decomposition = ReactionPredictor.predict('h2o2');
      expect(decomposition, isNotNull);
      expect(decomposition!.equation, '2H2O2 → 2H2O + O2');

      final propane = ReactionPredictor.predict('c3h8 + o2');
      expect(propane, isNotNull);
      expect(propane!.equation, 'C3H8 + 5O2 → 3CO2 + 4H2O');
    });

    test('reaction result can be presented in English', () {
      final result = ReactionPredictor.predict('co2 + h2o')!;
      final english = localizedReactionText(result, true);
      expect(english.title, 'Formation of carbonic acid');
      expect(english.explanations, isNotEmpty);
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
