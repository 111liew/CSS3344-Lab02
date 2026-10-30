
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:first_flutter_app/main.dart';

void main() {
  testWidgets('Student Profile App loads successfully',
          (WidgetTester tester) async {
        await tester.pumpWidget(const StudentInfoApp());

        expect(find.byType(MaterialApp), findsOneWidget);
      });
}
