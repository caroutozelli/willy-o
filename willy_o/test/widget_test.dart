import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:willy_o/app.dart';

void main() {
  testWidgets('App renders correctly', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: App()));
    expect(find.text('Willy-O'), findsOneWidget);
  });
}
