import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:usdol/app/core.dart';
import 'test_utils.dart';

class CommunityRiskScanRobot {
  const CommunityRiskScanRobot(this.tester);
  final WidgetTester tester;
  Future<void> communityRiskScanOpen() async {
    await tester.pumpAndSettle();
    tester.printToConsole("======== Start Community Risk Scan ========");
    await tester.pumpAndSettle();
    final enterBtn = find.text("Community Risk Scan").first;
    await tester.tap(enterBtn);
    await tester.pumpAndSettle();
    expect(find.text("Community Risk Scan"), findsWidgets);
  }

  Future<void> inputData() async {
    tester.printToConsole("Start input");
    Finder facilitySearch = find.byKey(const ValueKey('inputSearch'));
    Finder locationInput = find.byKey(const ValueKey('location'));
    Finder priorities = find.byKey(const ValueKey('priority'));
    Finder notes = find.byKey(const ValueKey('notes'));
    Finder submit = find.byKey(const ValueKey('bottomAction'));
    RiskScanController riskScanController = Get.find<RiskScanController>();
    //SEARCH
    await tester.tap(facilitySearch);
    await tester.pumpAndSettle();
    await addDelay(500);
    //select item in search
    List<FacilityRespModel> facilities = await riskScanController.loadListFacility("");
    int lengthOfFacility = facilities.length;
    //limit to run in a screen
    if(lengthOfFacility > 3){
      lengthOfFacility = 3;
    }
    final facilityItem = find.byKey(ValueKey(facilities[getRandomInt(0, lengthOfFacility)].id));
    await tester.tap(facilityItem);
    await tester.pumpAndSettle();
    //locationInput
    await tester.enterText(locationInput, const Uuid().v1());
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();

    //severitys
    await tester.tap(priorities);
    await tester.pumpAndSettle();
    final prioritiesItem = find.byKey(ValueKey(
      riskScanController.priorities[getRandomInt(0, riskScanController.priorities.length)].value,
    ));
    await tester.tap(prioritiesItem);
    await tester.pumpAndSettle();

    //     //indicator
    // await tester.tap(priorities);
    // await tester.pumpAndSettle();
    // final prioritiesItem = find.byKey(ValueKey(
    //   riskScanController.priorities[getRandomInt(0, riskScanController.priorities.length)].value,
    // ));
    await tester.tap(prioritiesItem);
    await tester.pumpAndSettle();

    //notes
    await tester.enterText(notes, const Uuid().v1());
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pump();
    
    //import photo

    String pathImport = await imageFileImport();
    riskScanController.pickFile(pathImport);
    //dateTime
    riskScanController.datetimeSelected = DateTime.now();

    await addDelay(1000);
    await tester.pumpAndSettle();
    //
    tester.printToConsole("Filled risk scan");
    await tester.tap(submit);
    await tester.pumpAndSettle();
    await addDelay(2000);
    expect(find.text("Response Submitted!"), findsWidgets);
    Finder confirmNotice = find.byKey(const ValueKey("confirmNotice"));
    await tester.tap(confirmNotice);
    await tester.pumpAndSettle();
  }
}
