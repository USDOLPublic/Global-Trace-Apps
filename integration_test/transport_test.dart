import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:usdol/app/core.dart';
import 'add_lots_test.dart';
import 'test_utils.dart';

class TransportRobot {
  const TransportRobot(this.tester);
  final WidgetTester tester;
  Future<void> transportOpen() async {
    await tester.pumpAndSettle();
    tester.printToConsole("======== Start transport ========");
    await tester.pumpAndSettle();
    final transportBtn = find.text("Transport").first;
    await tester.tap(transportBtn);
    await tester.pumpAndSettle();
    expect(find.text("Transport"), findsWidgets);
  }

  Future<void> inputData(List<String> lotIds) async {
    tester.printToConsole("Start input transport");
    Finder addLot = find.byKey(const ValueKey('addLot'));
    await tester.tap(addLot);
    await tester.pumpAndSettle();
    AddLotsRobot addLotsRobot = AddLotsRobot(tester);
    await addLotsRobot.inputData(lotIds);
    await tester.pumpAndSettle();

    Finder transporter = find.byKey(const ValueKey('transporter'));
    //Finder totalWeight = find.byKey(const ValueKey('totalWeight'));
    //Finder unit = find.byKey(const ValueKey('unit'));
    Finder packingListNumber = find.byKey(const ValueKey('packingListNumber'));
    Finder save = find.byKey(const ValueKey('save'));

    var _transportPartnerCache = Get.find<TransportPartnerCacheService>();
    List<TransportPartner> partners = _transportPartnerCache.repo.getAllValues().values.toList();

    //transporter
    await tester.tap(transporter);
    await tester.pumpAndSettle();
    final transporterItem = find.byKey(ValueKey(partners[getRandomInt(0, partners.length)].id));
    await tester.tap(transporterItem);
    await tester.pumpAndSettle();
    //unit
    //await tester.tap(unit);
    //await tester.pumpAndSettle();
    //final unitItem = find.byKey(ValueKey(ginnerTransportWeightUnits[getRandomInt(0, ginnerTransportWeightUnits.length)].value));
    //await tester.tap(unitItem);
    //await tester.pumpAndSettle();
    //totalWeight
    //await tester.enterText(totalWeight, getRandomInt(1, 200).toString());
    //packingListNumber
    await tester.enterText(packingListNumber, const Uuid().v1());
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pump();
    await tester.pumpAndSettle();
    //
    tester.printToConsole("Filled purchase");

    //import photo
    var transportController = Get.find<TransportController>();
    String pathImport = await imageFileImport();
    transportController.pickPackingFile(pathImport);
    //dateTime
    transportController.datetimeSelected = DateTime.now();

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
