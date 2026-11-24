import 'package:flutter_test/flutter_test.dart';
import 'package:chemmaster/chemistry/equation_balancer.dart';
import 'package:chemmaster/chemistry/formula_parser.dart';
import 'package:chemmaster/data/periodic_elements.dart';
import 'package:chemmaster/data/curriculum.dart';
import 'package:chemmaster/data/quiz_bank.dart';
import 'package:chemmaster/services/progress_store.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('Formula parser', () {
    test('reads simple formulas', () {
      expect(FormulaParser.parse('H2SO4'), {'H': 2, 'S': 1, 'O': 4});
    });
    test('reads parentheses', () {
      expect(FormulaParser.parse('Ca(OH)2'), {'Ca': 1, 'O': 2, 'H': 2});
    });
    test('reads nested parentheses', () {
      expect(FormulaParser.parse('Al2(SO4)3'), {'Al': 2, 'S': 3, 'O': 12});
    });
  });
  group('Equation balancer', () {
    test('balances water formation', () {
      expect(EquationBalancer.balance('H2 + O2 -> H2O'), '2H2 + O2 → 2H2O');
    });
    test('balances potassium hydroxide neutralization', () {
      expect(EquationBalancer.balance('HCl + KOH -> KCl + H2O'), 'HCl + KOH → KCl + H2O');
    });
    test('balances metal and acid displacement', () {
      expect(EquationBalancer.balance('Zn + HCl -> ZnCl2 + H2'), 'Zn + 2HCl → ZnCl2 + H2');
    });
    test('balances compounds containing parentheses', () {
      expect(EquationBalancer.balance('Al + HCl -> AlCl3 + H2'), '2Al + 6HCl → 2AlCl3 + 3H2');
    });
    test('balances a polyatomic group unchanged', () {
      expect(EquationBalancer.balance('Ca(OH)2 + HCl -> CaCl2 + H2O'), 'Ca(OH)2 + 2HCl → CaCl2 + 2H2O');
    });
  });
  test('periodic table has all 118 atomic numbers in order', () {
    expect(periodicElements.length, 118);
    expect(periodicElements.map((e) => e.number).toList(), List.generate(118, (i) => i + 1));
  });
  test('curriculum contains the three first-cycle grades', () {
    expect(mozambiqueCurriculum.map((c) => c.grade).toList(), ['7.ª classe', '8.ª classe', '9.ª classe', '10.ª classe', '11.ª classe', '12.ª classe']);
  });
  test('local progress persists completed lessons and quiz scores', () async {
    SharedPreferences.setMockInitialValues({});
    await ProgressStore.completeLesson('lesson-a');
    await ProgressStore.saveQuiz('quiz-7', 4, 5);
    final data = await ProgressStore.read();
    expect(data['lessons'], contains('lesson-a'));
    expect((data['bestScores'] as Map<String, dynamic>)['quiz-7'], 4);
    expect((data['answers'] as Map<String, dynamic>)['quiz-7']['total'], 5);
  });
  test('quiz bank contains real questions', () {
    expect(quizBank.length, greaterThanOrEqualTo(10));
    for (final q in quizBank) {
      expect(q.answer, inInclusiveRange(0, q.options.length - 1));
      expect(q.explanation, isNotEmpty);
    }
  });
}
