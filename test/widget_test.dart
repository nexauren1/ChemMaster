import 'package:flutter_test/flutter_test.dart';
import 'package:chemmaster/main.dart';

void main() {
  testWidgets('ChemMaster opens the home screen', (tester) async {
    await tester.pumpWidget(const ChemMasterApp());
    expect(find.text('ChemMaster'), findsOneWidget);
    expect(find.text('Aprender • Praticar • Conquistar'), findsOneWidget);
  });
}
