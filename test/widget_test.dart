import 'package:flutter_test/flutter_test.dart';
import 'package:rushi_app/app.dart';

void main() {
  testWidgets('App should render home page', (WidgetTester tester) async {
    await tester.pumpWidget(const RushiaApp());
    expect(find.text('如释'), findsOneWidget);
    expect(find.text('放松身心，自然如释'), findsOneWidget);
  });
}
