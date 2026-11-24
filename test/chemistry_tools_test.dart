import 'package:flutter_test/flutter_test.dart';
import 'package:chemmaster/main.dart';

void main() {
  group('ChemMaster equation balancer', () {
    test('balances water formation', () {
      expect(Balancer.balance('H2 + O2 -> H2O'), '2H2 + O2 → 2H2O');
    });

    test('keeps an already balanced neutralization equation', () {
      expect(Balancer.balance('HCl + KOH -> KCl + H2O'), 'HCl + KOH → KCl + H2O');
    });

    test('balances metal and acid displacement', () {
      expect(Balancer.balance('Zn + HCl -> ZnCl2 + H2'), 'Zn + 2HCl → ZnCl2 + H2');
    });
  });
}
