import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:usdol/app/core.dart';
import 'add_lots_test.dart';
import 'test_utils.dart';

class SellRobot {
  const SellRobot(this.tester);
  final WidgetTester tester;
  Future<void> sellOpen() async {
    await tester.pumpAndSettle();
    tester.printToConsole("======== Start sell ========");
    await tester.pumpAndSettle();
    final sellBtn = find.text("Sell").first;
    await tester.tap(sellBtn);
    await tester.pumpAndSettle();
    expect(find.text("Sell"), findsWidgets);
  }

  Future<void> inputData(List<String> lotIds) async {
    tester.printToConsole("Start Sell");
    Finder addLot = find.byKey(const ValueKey('addLot'));
    await tester.tap(addLot);
    await tester.pumpAndSettle();
    AddLotsRobot addLotsRobot = AddLotsRobot(tester);
    await addLotsRobot.inputData(lotIds);
    await tester.pumpAndSettle();

    Finder purchaser = find.byKey(const ValueKey('inputSearch'));
    Finder totalPrice = find.byKey(const ValueKey('totalPrice'));
    Finder currency = find.byKey(const ValueKey('currency'));
    Finder invoiceNumber = find.byKey(const ValueKey('invoiceNumber'));
    Finder packingNumber = find.byKey(const ValueKey('packingNumber'));
    Finder save = find.byKey(const ValueKey('save'));

    var sellController = Get.find<SellController>();

    //farmOrBroker
    await tester.tap(purchaser);
    await tester.pumpAndSettle();
    await addDelay(500);
    //select item in search
    List<InputItem> partners = await sellController.loadListPurchaser("");
    int lengthOfPartners = partners.length;
    //limit to run in a screen
    if(lengthOfPartners > 3){
      lengthOfPartners = 3;
    }
    final purchaserItem = find.byKey(ValueKey(partners[getRandomInt(0, lengthOfPartners)].value));
    await tester.tap(purchaserItem);
    await tester.pumpAndSettle();
    //currency
    await tester.tap(currency);
    await tester.pumpAndSettle();
    final currencyItem = find.byKey(ValueKey(currencyUnits[getRandomInt(0, currencyUnits.length)].value));
    await tester.tap(currencyItem);
    await tester.pumpAndSettle();
    //price
    await tester.enterText(totalPrice, getRandomInt(1, 300).toString());
    //invoiceNumber
    await tester.enterText(invoiceNumber, const Uuid().v1());
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pump();
    await scrollThePage(tester);
    //packingNumber
    await tester.enterText(packingNumber, const Uuid().v1());
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pump();
    await scrollThePage(tester);

    await addDelay(1000);

    await tester.pumpAndSettle();
    //
    tester.printToConsole("Filled sell");

    //import photo
    String pathImport = await imageFileImport();
    sellController.pickInvoice(pathImport);
    sellController.pickPacking(pathImport);
    //dateTime
    sellController.datetimeSelected = DateTime.now();

    await addDelay(1000);
    await tester.pumpAndSettle();
    //
    tester.printToConsole("Filled purchase");
    await tester.tap(save);
    await tester.pumpAndSettle();
    await addDelay(2000);
    expect(find.text("Data Saved!"), findsWidgets);
    Finder confirmNotice = find.byKey(const ValueKey("confirmNotice"));
    await tester.tap(confirmNotice);
    await tester.pumpAndSettle();
  }
}
