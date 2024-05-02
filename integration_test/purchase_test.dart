import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:usdol/app/core.dart';
import 'test_utils.dart';

class PurchaseRobot {
  const PurchaseRobot(this.tester);
  final WidgetTester tester;
  Future<void> purchaseOpen() async {
    await tester.pumpAndSettle();
    tester.printToConsole("======== Start purchase ========");
    await tester.pumpAndSettle();
    final purchaseBtn = find.text("Purchase").first;
    await tester.tap(purchaseBtn);
    await tester.pumpAndSettle();
    expect(find.text("Purchase"), findsWidgets);
  }

  Future<void> inputData() async {
    tester.printToConsole("Start purchase");
    Finder sellerSearch = find.byKey(const ValueKey('inputSearch'));
    Finder trashContent = find.byKey(const ValueKey('trashContent'));
    Finder moistureLevel = find.byKey(const ValueKey('moistureLevel'));
    Finder cottonCertification = find.byKey(const ValueKey('cottonCertification'));
    Finder grade = find.byKey(const ValueKey('grade'));
    Finder totalWeight = find.byKey(const ValueKey('totalWeight'));
    Finder unit = find.byKey(const ValueKey('unit'));
    Finder price = find.byKey(const ValueKey('price'));
    Finder currency = find.byKey(const ValueKey('currency'));
    Finder purchaseOrderNumber = find.byKey(const ValueKey('purchaseOrderNumber'));
    Finder save = find.byKey(const ValueKey('save'));

    final purchaseController = Get.find<PurchaseController>();
    
    //sellerSearch
    await tester.tap(sellerSearch);
    await tester.pumpAndSettle();
    await addDelay(500);
    //select item in search
    List<InputItem> partners = await purchaseController.loadListSeller("");
    int lengthOfPartners = partners.length;
    //limit to run in a screen
    if(lengthOfPartners > 3){
      lengthOfPartners = 3;
    }
    final farmOrBrokerItem = find.byKey(ValueKey(partners[getRandomInt(0, lengthOfPartners)].value));
    await tester.tap(farmOrBrokerItem);
    await tester.pumpAndSettle();
    //trashContent
    await tester.tap(trashContent);
    await tester.pumpAndSettle();
    await tester.pumpAndSettle();
    //cottonCertification
    await tester.tap(cottonCertification);
    await tester.pumpAndSettle();
    int lengthOfCer = cottonsCertification.length;
    //limit to run in a screen
    if(lengthOfCer > 3){
      lengthOfCer = 3;
    }
    final cottonCertificationItem = find.byKey(ValueKey(cottonsCertification[getRandomInt(0, lengthOfCer)].value));
    await tester.tap(cottonCertificationItem);
    await tester.pumpAndSettle();
    //grade
    await tester.tap(grade);
    await tester.pumpAndSettle();
    int lengthOfGrade = gradeGinnerForPurchaseOfCotton.length;
    //limit to run in a screen
    if (lengthOfGrade > 3) {
      lengthOfGrade = 3;
    }
    final gradeItem = find.byKey(ValueKey(gradeGinnerForPurchaseOfCotton[getRandomInt(0, lengthOfGrade)].value));
    await tester.tap(gradeItem);
    await tester.pumpAndSettle();
    //unit
    await tester.tap(unit);
    await tester.pumpAndSettle();
    InputItem unitInput = ginnerPurchaseWeightUnits[getRandomInt(0, ginnerPurchaseWeightUnits.length)];
    final unitItem = find.byKey(ValueKey(unitInput.value));
    await tester.tap(unitItem);
    await tester.pumpAndSettle();
    //currency
    await tester.tap(currency);
    await tester.pumpAndSettle();
    final currencyItem = find.byKey(ValueKey(currencyUnits[getRandomInt(0, currencyUnits.length)].value));
    await tester.tap(currencyItem);
    await tester.pumpAndSettle();
    //moistureLevel
    double moistureInput = getRandomDouble(1, 100);
    String moistureStr = moistureInput.toNumericFormat();
    await tester.enterText(moistureLevel, moistureStr);
    //totalWeight
    int weightInput = getRandomInt(500, 1000);
    await tester.enterText(totalWeight, weightInput.toString());
    //price
    await tester.enterText(price, getRandomInt(1, 300).toString());
    //purchaseOrderNumber
    await tester.enterText(purchaseOrderNumber, const Uuid().v1());
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pump();
    await scrollThePage(tester);
    //import photo
    String pathImport = await imageFileImport();
    purchaseController.pickSlip(pathImport);
    //dateTime
    purchaseController.datetimeSelected = DateTime.now();

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
