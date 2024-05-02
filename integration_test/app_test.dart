import 'package:integration_test/integration_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:usdol/app/core.dart';

import 'auth_test.dart';
import 'community_risk_scan_test.dart';
import 'invite_partner_test.dart';
import 'profile_test.dart';
import 'purchase_test.dart';
import 'request_to_respond_test.dart';
import 'saq_question_test.dart';
import 'sell_test.dart';
import 'test_utils.dart';
import 'transport_test.dart';

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  // ignore: unnecessary_type_check
  if (binding is LiveTestWidgetsFlutterBinding) {
    binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

    ///
    /// Test authentication
    ///
    testWidgets('Authentication Testing', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      await addDelay(1200);
      await tester.pumpAndSettle();
      AuthRobot authRobot = AuthRobot(tester);
      await authRobot.loginFormValid();
      await authRobot.login();
    });

    ///
    /// Test Purchase
    /// Step 1: Login with Ginner account
    /// Step 2: Open Purchase screen
    /// Step 3: Fill random value
    /// Step 4: Submit data
    /// Expected 1: show popup "Data Saved!"
    /// Expected 2: History updated with
    /// "{weight} {unit} / {trashContent}, {moistureLevel}%"
    ///
    testWidgets('Purchase Testing', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      await addDelay(1200);
      await tester.pumpAndSettle();
      AuthRobot authRobot = AuthRobot(tester);
      await authRobot.loginWithGinner();

      PurchaseRobot purchaseRobot = PurchaseRobot(tester);
      await purchaseRobot.purchaseOpen();
      await purchaseRobot.inputData();
    });

    ///
    /// Test Sell
    /// Step 1: Login with Ginner account
    /// Step 2: Open Sell screen
    /// Step 3: Open Lot List screen
    /// Step 4: Add lot list with LotIds
    /// Step 5: Click "Done"
    /// Step 6: Fill Sell random value
    /// Step 7: Submit data
    /// Expected 1: show popup "Data Saved!"
    /// Expected 2: History updated with
    /// "{price} {currency}"
    ///
    testWidgets('Sell Testing', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      await addDelay(1200);
      await tester.pumpAndSettle();
      AuthRobot authRobot = AuthRobot(tester);
      await authRobot.loginWithGinner();

      //Create lot:
      
      //Sell
      SellRobot sellRobot = SellRobot(tester);
      //LotIds
      await sellRobot.sellOpen();
    });

    ///
    /// Test Transport
    /// Step 1: Login with Ginner account
    /// Step 2: Open Transport screen
    /// Step 3: Open Lot List screen
    /// Step 4: Add lot list with LotIds
    /// Step 5: Click "Done"
    /// Step 6: Fill Transport random value
    /// Step 7: Submit data
    /// Expected 1: show popup "Data Saved!"
    ///
    testWidgets('Transport Testing', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      await addDelay(1200);
      await tester.pumpAndSettle();
      AuthRobot authRobot = AuthRobot(tester);
      await authRobot.loginWithGinner();

      //Transport
      TransportRobot transportRobot = TransportRobot(tester);
      //LotIds
      await transportRobot.transportOpen();
    });

    ///
    /// Test Invite Partner
    /// Step 1: Login with Ginner account
    /// Step 2: Open Manage Partner screen
    /// Step 3: Open Add Farm Partner
    /// Step 4: Input Data
    /// Step 5: Click "Add"
    /// Expected 1: show popup "Farm is added!"
    /// Step 6: Open Add Broker Partner
    /// Step 7: Input Data
    /// Step 8: Click "Add"
    /// Expected 2: show popup "Broker is added!"
    /// Step 9: Open Add Transporter Partner
    /// Step 10: Input Data
    /// Step 11: Click "Add"
    /// Expected 3: show popup "Transporter is added!"
    /// Step 12: Open Add Spinner Partner
    /// Step 13: Input Data
    /// Step 14: Click "Add"
    /// Expected 1: show popup "Spinner is added!"
    ///
    testWidgets('Invite Partner Testing', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      await addDelay(1200);
      await tester.pumpAndSettle();
      AuthRobot authRobot = AuthRobot(tester);
      await authRobot.loginWithGinner();

      InvitePartnerRobot invitePartnerRobot = InvitePartnerRobot(tester);
      await invitePartnerRobot.openScreen();
      await invitePartnerRobot.inviteBrokerPartner();
      await invitePartnerRobot.inviteTransporterPartner();
      await invitePartnerRobot.inviteSpinnerPartner();
    });

    ///
    /// Test Profile
    /// Step 1: Login with Ginner account
    /// Step 2: Open Manage Partner screen
    /// Step 3: Open Add Farm Partner
    /// Step 4: Input Data
    /// Step 5: Click "Add"
    /// Expected 1: show popup "Farm is added!"
    ///
    testWidgets('Profile Testing', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      await addDelay(1200);
      await tester.pumpAndSettle();
      AuthRobot authRobot = AuthRobot(tester);
      await authRobot.loginWithGinner();

      ProfileRobot profileRobot = ProfileRobot(tester);
      await profileRobot.openScreen();
      await profileRobot.profile();
    });

    ///
    /// Test Community Risk Scan
    /// Step 1: Login with Farm Monitor account
    /// Step 2: Open Community Risk Scan screen
    /// Step 3: Input Data
    /// Step 4: Click "Submit"
    /// Expected 1: show popup "Response Submitted"
    ///
    testWidgets('Community Risk Scan Testing', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      await addDelay(1200);
      await tester.pumpAndSettle();
      AuthRobot authRobot = AuthRobot(tester);
      await authRobot.loginWithFarmMonitor();

      CommunityRiskScanRobot communityRiskScanRobot = CommunityRiskScanRobot(tester);
      await communityRiskScanRobot.communityRiskScanOpen();
      await communityRiskScanRobot.inputData();
    });

    ///
    /// Test Request for Information
    /// Step 1: Login with Farm Monitor account
    /// Step 2: Open Request For Information
    /// Step 3: Open Detail Request for Information
    /// Step 4: Open Response To Request
    /// Step 3: Input Data
    /// Step 4: Click "Submit"
    /// Expected 1: show popup "Response Submitted!"
    ///
    testWidgets('Request For Information Testing', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      await addDelay(1200);
      await tester.pumpAndSettle();
      AuthRobot authRobot = AuthRobot(tester);
      await authRobot.loginWithFarmMonitor();

      RequestToRespondRobot requestToRespondRobot = RequestToRespondRobot(tester);
      await requestToRespondRobot.requestForInformationOpen();
      await requestToRespondRobot.inputData();
    });

    ///
    /// Test SAQ Question
    /// Step 1: Login with Ginner account
    /// Step 2: Open SAQ screen from onboard
    /// Step 3: Fill random data
    /// Step 4: Next to end page
    ///
    testWidgets('SAQ Question Testing', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      await addDelay(1200);
      await tester.pumpAndSettle();
      AuthRobot authRobot = AuthRobot(tester);
      await authRobot.loginWithGinnerSAQ();

      SAQQuestionRobot saqQuestionRobot = SAQQuestionRobot(tester);
      await saqQuestionRobot.openScreen();
      await saqQuestionRobot.updateSAQQuestion();
    });
  }
}
