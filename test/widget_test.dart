import 'package:flutter_test/flutter_test.dart';
import 'package:chemmaster/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('ChemMaster opens the home screen', (tester) async {
    SharedPreferences.setMockInitialValues({});
    await tester.pumpWidget(const ChemMasterApp());
    expect(find.text('ChemMaster'), findsOneWidget);
    expect(find.text('Química, com mais clareza.'), findsOneWidget);
  });
}
