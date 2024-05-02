import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_utils.dart';

class AddLotsRobot {
  const AddLotsRobot(this.tester);
  final WidgetTester tester;

  Future<void> inputData(List<String> lotIds) async {
    tester.printToConsole("Add lots");
    await addDelay(500);
    expect(find.text("Lot List"), findsWidgets);
    Finder done = find.byKey(const ValueKey('done'));

    //lot
    await Future.forEach(lotIds, (String lot) async {
      Finder lotId = find.byKey(const ValueKey('lotId'));
      await tester.enterText(lotId, lot);
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();
      Finder addLot = find.byKey(const ValueKey('addLot'));
      await tester.tap(addLot);
      await tester.pumpAndSettle();
      await addDelay(1000);
    });
    await tester.tap(done);
    await tester.pumpAndSettle();
  }
}
