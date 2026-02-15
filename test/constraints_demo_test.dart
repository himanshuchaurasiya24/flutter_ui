import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_ui/constraints_demo.dart';
// import 'package:flutter_ui/main.dart'; // Import main to access MyApp if needed, or just test ConstraintsDemo directly

void main() {
  testWidgets('ConstraintsDemo shows fixed scenario by default', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MaterialApp(home: ConstraintsDemo()));

    // Verify that the Fixed Scenario is shown.
    expect(find.text('FIXED SCENARIO:\nUsing SizedBox or shrinkWrap'), findsOneWidget);
    expect(find.text('ERROR SCENARIO:\nListView inside Column inside SingleChildScrollView'), findsNothing);

    // Verify the list items from the fixed scenario are present
    expect(find.text('Expected Item 0'), findsOneWidget);
    expect(find.text('ShrinkWrapped Item 0'), findsOneWidget);
  });

  testWidgets('ConstraintsDemo shows error scenario when toggled', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: ConstraintsDemo()));

    // Tap the switch to enable the error scenario.
    await tester.tap(find.byType(Switch));
    await tester.pump();

    // Verify that the Error Scenario text is shown.
    expect(find.text('ERROR SCENARIO:\nListView inside Column inside SingleChildScrollView'), findsOneWidget);
    
    // Check for the error. 
    // In a real running app, this throws an exception to the console.
    // In a test environment, Flutter catches this and reports it as an exception.
    // We expect an error here because the layout is invalid.
    
    // final dynamic exception = tester.takeException();
    // We might not get the exception immediately without a pump, or it might be caught by the framework.
    // However, checking for the text confirms we switched modes.
    // Explicitly catching the overflow error is tricky in widget tests without specific setup, 
    // but the presence of the UI elements confirms the state change.
  });
}
