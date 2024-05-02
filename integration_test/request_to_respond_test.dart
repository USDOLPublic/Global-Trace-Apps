import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:usdol/app/core.dart';

import 'test_utils.dart';

class RequestToRespondRobot {
  const RequestToRespondRobot(this.tester);

  final WidgetTester tester;

  Future<void> requestForInformationOpen() async {
    await tester.pumpAndSettle();
    tester.printToConsole("======== Start Request for information ========");
    await tester.pumpAndSettle();
    final enterBtn = find.byKey(const ValueKey('requestForInformation'));
    await tester.tap(enterBtn);
    await tester.pumpAndSettle();
    expect(find.text("Requests for Information"), findsWidgets);


    tester.printToConsole("======== Start Detail Request for information ========");

    final controller = Get.find<RequestsInfoController>();
    await addDelay(1000);

    if (controller.requestInformation.isEmpty) {
      return;
    }

    final requestInfo = controller.requestInformation[0];

    final request = find.byKey(const ValueKey('requestInfo')).first;
    await tester.tap(request);
    await tester.pumpAndSettle();
    expect(find.text(requestInfo.title), findsWidgets);

    tester.printToConsole("======== Start Respond to Request ========");

    final responseToRequestButton = find.byKey(const ValueKey('respondToRequest'));
    await tester.tap(responseToRequestButton);
    await tester.pumpAndSettle();
    expect(find.text("Respond to request"), findsWidgets);
  }

  Future<void> inputData() async {
    tester.printToConsole("Start Response");

    final controller = Get.find<RespondToRequestController>();
    await addDelay(1000);

    final dateTime = find.byKey(const ValueKey('startDateTimePicker'));
    final indicator = find.byKey(const ValueKey('indicatorDropdown'));
    final severityDropdown = find.byKey(const ValueKey('severityDropdown'));
    final noteInput = find.byKey(const ValueKey('noteInput'));
    final submitResponse = find.byKey(const ValueKey('submitResponse'));

    // Date Time selected
    await tester.tap(dateTime);
    await tester.pumpAndSettle();

    final done = find.byKey(const ValueKey('done'));
    await tester.tap(done);
    await tester.pumpAndSettle();

    // Indicator Selected
    await tester.tap(indicator);
    await tester.pumpAndSettle();

    final indicatorSelected = find.byKey(ValueKey(controller.indicators[getRandomInt(0, controller.indicators.length)].value));
    await tester.tap(indicatorSelected);
    await tester.pumpAndSettle();

    // Certification Selected
    await tester.tap(severityDropdown);
    await tester.pumpAndSettle();

    final certificationSelected = find.byKey(ValueKey(controller.severities[getRandomInt(0, controller.severities.length)].value));
    await tester.tap(certificationSelected);
    await tester.pumpAndSettle();

    // Note input
    await tester.enterText(noteInput, getRandomString(260));
    await addDelay(300);
    expect(find.text('Message must be shorter than or equal to 255 characters'), findsWidgets);
    await tester.enterText(noteInput, getRandomString(250));
    await addDelay(300);
    expect(find.text('Message must be shorter than or equal to 255 characters'), findsNothing);

    await addDelay(1000);
    await tester.pumpAndSettle();

    tester.printToConsole("Filled Response");
    await tester.tap(submitResponse);
    await tester.pumpAndSettle();
    await addDelay(1000);
    expect(find.text("Response Submitted!"), findsWidgets);
  }
}