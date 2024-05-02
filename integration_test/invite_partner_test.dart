import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:usdol/app/core.dart';

import 'test_utils.dart';

class InvitePartnerRobot {
  const InvitePartnerRobot(this.tester);

  final WidgetTester tester;

  Future<void> openScreen() async {
    tester.printToConsole("======== Start Invite Partner ========");
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('menuButton')));
    await tester.pumpAndSettle();
    //1 Go to Manage Partner screen
    await tester.tap(find.byKey(const ValueKey('managePartners')));
    await tester.pumpAndSettle();
    expect(find.text("Manage Business Partners"), findsWidgets);
  }

  Future<void> inviteBrokerPartner() async {
    await scrollThePage(tester, scrollKey: 'manageBusinessScroll');
    //2 Go to Invite Farm screen
    await tester.tap(find.byKey(const ValueKey('BrokerButton')));
    await tester.pumpAndSettle();

    final signIn = find.byKey(const ValueKey('addPartnerButton'));
    await tester.tap(signIn);
    await tester.pumpAndSettle();

    final firstnameInput = find.byKey(const ValueKey('firstnameInput'));
    final lastnameInput = find.byKey(const ValueKey('lastnameInput'));
    final emailInput = find.byKey(const ValueKey('emailInput'));
    final phoneInput = find.byKey(const ValueKey('phoneInput'));
    final nameInput = find.byKey(const ValueKey('nameInput'));
    final streetAddressInput = find.byKey(const ValueKey('streetAddressInput'));
    final businessRegisterInput = find.byKey(const ValueKey('businessRegisterInput'));

    // Email validate
    await tester.enterText(emailInput, "abc");
    await tester.pumpAndSettle();
    expect(find.text('Please enter your email address in format: yourname@example.com'), findsOneWidget);
    await tester.enterText(emailInput, "abc@12");
    await tester.pumpAndSettle();
    expect(find.text('Please enter your email address in format: yourname@example.com'), findsOneWidget);
    await tester.enterText(emailInput, "abc@gmail.");
    await tester.pumpAndSettle();
    expect(find.text('Please enter your email address in format: yourname@example.com'), findsOneWidget);
    await tester.enterText(emailInput, "abc@gmail.com");
    await tester.pumpAndSettle();
    expect(find.text('Please enter your email address in format: yourname@example.com'), findsNothing);
    await tester.enterText(emailInput, getRandomEmail());
    await tester.pumpAndSettle();
    expect(find.text('Please enter your email address in format: yourname@example.com'), findsNothing);
    tester.printToConsole('Email validation done');
    await tester.pumpAndSettle();

    // Firstname validate
    await tester.enterText(firstnameInput, "Broker.app");
    await tester.pumpAndSettle();
    tester.printToConsole('Firstname validation done');

    // Lastname validate
    await tester.enterText(lastnameInput, getRandomString(10));
    await tester.pumpAndSettle();
    tester.printToConsole('Lastname validation done');

    // Phone validate
    await tester.enterText(phoneInput, getRandomInt(100000, 999999).toString());
    await tester.pumpAndSettle();
    tester.printToConsole('Phone validation done');

    // Business Register validate
    await tester.enterText(nameInput, "Broker.app-"+ getRandomString(5));
    await tester.pumpAndSettle();
    tester.printToConsole('Name validation done');

    // Stress Address validate
    await tester.enterText(streetAddressInput, getRandomString(10));
    await tester.pumpAndSettle();
    tester.printToConsole('Stress address validation done');

    // Stress Address validate
    await tester.enterText(businessRegisterInput, getRandomString(6));
    await tester.pumpAndSettle();
    tester.printToConsole('Business register validation done');

    // final countryDropdown = find.byKey(const ValueKey('countryDropdown'));
    // final provinceStateDropdown = find.byKey(const ValueKey('provinceStateDropdown'));
    // final districtDropdown = find.byKey(const ValueKey('districtDropdown'));

    // expect(find.text('Province/State'), findsNothing);

    // expect(find.text('District'), findsNothing);

    // final controller = Get.find<AddPartnerController>();
    // await tester.pumpAndSettle();

    // final country = controller.countries[getRandomInt(0, controller.countries.length > 5 ? 5 : controller.countries.length)];

    // await tester.tap(countryDropdown);
    // await tester.pumpAndSettle();
    // expect(find.text(country.displayLabel), findsWidgets);

    // await tester.tap(find.byKey(ValueKey(country.value)));
    // await tester.pumpAndSettle();
    // expect(find.text(country.displayLabel), findsWidgets);

    // final province = controller.providerState[getRandomInt(0, controller.providerState.length > 10 ? 10 : controller.providerState.length)];

    // await tester.tap(provinceStateDropdown);
    // await tester.pumpAndSettle();
    // expect(find.text(province.displayLabel), findsWidgets);

    // await tester.tap(find.byKey(ValueKey(province.value)));
    // await tester.pumpAndSettle();
    // expect(find.text(province.displayLabel), findsWidgets);

    // await scrollThePage(tester, scrollKey: 'addPartnerScroll');

    // final district = controller.districts[getRandomInt(0, controller.districts.length > 10 ? 10 : controller.districts.length)];

    // await tester.tap(districtDropdown);
    // await tester.pumpAndSettle();
    // expect(find.text(district.displayLabel), findsWidgets);

    // await tester.tap(find.byKey(ValueKey(district.value)));
    // await tester.pumpAndSettle();
    // expect(find.text(district.displayLabel), findsWidgets);

    final addChildPartnerButton = find.byKey(const ValueKey('addChildPartnerButton'));
    await tester.tap(addChildPartnerButton);
    await tester.pumpAndSettle();

    final firstnameChildInput = find.byKey(const ValueKey('firstnameChildInput'));
    final lastnameChildInput = find.byKey(const ValueKey('lastnameChildInput'));
    final emailChildInput = find.byKey(const ValueKey('emailChildInput'));
    final phoneChildInput = find.byKey(const ValueKey('phoneChildInput'));
    final nameChildInput = find.byKey(const ValueKey('nameChildInput'));
    final streetAddressChildInput = find.byKey(const ValueKey('streetAddressChildInput'));

    await tester.enterText(emailChildInput, getRandomEmail());
    await tester.pumpAndSettle();
    expect(find.text('Please enter your email address in format: yourname@example.com'), findsNothing);
    tester.printToConsole('Email validation done');
    await tester.pumpAndSettle();

    // Firstname validate
    await tester.enterText(firstnameChildInput, "Farm.app");
    await tester.pumpAndSettle();
    tester.printToConsole('Firstname validation done');

    // Lastname validate
    await tester.enterText(lastnameChildInput, getRandomString(10));
    await tester.pumpAndSettle();
    tester.printToConsole('Lastname validation done');

    // Phone validate
    await tester.enterText(phoneChildInput, getRandomInt(100000, 999999).toString());
    await tester.pumpAndSettle();
    tester.printToConsole('Phone validation done');

    // Business Register validate
    await tester.enterText(nameChildInput, "Farm.app-" + getRandomString(5));
    await tester.pumpAndSettle();
    tester.printToConsole('Business register validation done');

    // Stress Address validate
    await tester.enterText(streetAddressChildInput, getRandomString(10));
    await tester.pumpAndSettle();
    tester.printToConsole('Business register validation done');

    // final countryChildDropdown = find.byKey(const ValueKey('countryChildDropdown'));
    // final provinceStateChildDropdown = find.byKey(const ValueKey('provinceStateChildDropdown'));
    // final districtChildDropdown = find.byKey(const ValueKey('districtChildDropdown'));
    final partnerTypeDropdown = find.byKey(const ValueKey('partnerTypeDropdown'));
    
    final controllerChild = Get.find<AddChildPartnerController>();
    final randomType = controllerChild.typesPartner [0];

    await tester.tap(partnerTypeDropdown);
    await tester.pumpAndSettle();
    expect(find.text(randomType.displayLabel), findsWidgets);

    await tester.tap(find.byKey(ValueKey(randomType.value)));
    await tester.pumpAndSettle();
    expect(find.text(randomType.displayLabel), findsWidgets);

    // expect(find.text('Province/State'), findsNothing);

    // expect(find.text('District'), findsNothing);
    // await tester.pumpAndSettle();

    // final countryChild = controllerChild.countries[getRandomInt(0, controllerChild.countries.length > 5 ? 5 : controllerChild.countries.length)];

    // await tester.tap(countryChildDropdown);
    // await tester.pumpAndSettle();
    // expect(find.text(countryChild.displayLabel), findsWidgets);

    // await tester.tap(find.byKey(ValueKey(countryChild.value)));
    // await tester.pumpAndSettle();
    // expect(find.text(countryChild.displayLabel), findsWidgets);

    // final provinceChild =
    //     controllerChild.providerState[getRandomInt(0, controllerChild.providerState.length > 5 ? 5 : controllerChild.providerState.length)];

    // await tester.tap(provinceStateChildDropdown);
    // await tester.pumpAndSettle();
    // expect(find.text(provinceChild.displayLabel), findsWidgets);

    // await tester.tap(find.byKey(ValueKey(provinceChild.value)));
    // await tester.pumpAndSettle();
    // expect(find.text(provinceChild.displayLabel), findsWidgets);

    // await scrollThePage(tester, scrollKey: 'addPartnerChildScroll');

    // final districtChild = controllerChild.districts[getRandomInt(0, controllerChild.districts.length > 5 ? 5 : controllerChild.districts.length)];

    // await tester.tap(districtChildDropdown);
    // await tester.pumpAndSettle();
    // expect(find.text(districtChild.displayLabel), findsWidgets);

    // await tester.tap(find.byKey(ValueKey(districtChild.value)));
    // await tester.pumpAndSettle();
    // expect(find.text(districtChild.displayLabel), findsWidgets);

    await tester.tap(find.byKey(const ValueKey('addChildPartnerChildButton')));
    await tester.pumpAndSettle();
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const ValueKey('addPartnerButton')));
    await tester.pumpAndSettle();
    await tester.pumpAndSettle();
  }

  Future<void> inviteTransporterPartner() async {
    await scrollThePage(tester, scrollKey: 'manageBusinessScroll');

    //2 Go to Invite Farm screen
    await tester.tap(find.byKey(const ValueKey('TransporterButton')));
    await tester.pumpAndSettle();

    final signIn = find.byKey(const ValueKey('addPartnerButton'));
    await tester.tap(signIn);
    await tester.pumpAndSettle();

    final firstnameInput = find.byKey(const ValueKey('firstnameInput'));
    final lastnameInput = find.byKey(const ValueKey('lastnameInput'));
    final emailInput = find.byKey(const ValueKey('emailInput'));
    final phoneInput = find.byKey(const ValueKey('phoneInput'));
    final nameInput = find.byKey(const ValueKey('nameInput'));
    final streetAddressInput = find.byKey(const ValueKey('streetAddressInput'));
    final businessRegisterInput = find.byKey(const ValueKey('businessRegisterInput'));

    // Email validate
    await tester.enterText(emailInput, "abc");
    await tester.pumpAndSettle();
    expect(find.text('Please enter your email address in format: yourname@example.com'), findsOneWidget);
    await tester.enterText(emailInput, "abc@12");
    await tester.pumpAndSettle();
    expect(find.text('Please enter your email address in format: yourname@example.com'), findsOneWidget);
    await tester.enterText(emailInput, "abc@gmail.");
    await tester.pumpAndSettle();
    expect(find.text('Please enter your email address in format: yourname@example.com'), findsOneWidget);
    await tester.enterText(emailInput, "abc@gmail.com");
    await tester.pumpAndSettle();
    expect(find.text('Please enter your email address in format: yourname@example.com'), findsNothing);
    await tester.enterText(emailInput, getRandomEmail());
    await tester.pumpAndSettle();
    expect(find.text('Please enter your email address in format: yourname@example.com'), findsNothing);
    tester.printToConsole('Email validation done');
    await tester.pumpAndSettle();

    // Firstname validate
    await tester.enterText(firstnameInput, "Transporter.app");
    await tester.pumpAndSettle();
    tester.printToConsole('Firstname validation done');

    // Lastname validate
    await tester.enterText(lastnameInput, getRandomString(10));
    await tester.pumpAndSettle();
    tester.printToConsole('Lastname validation done');

    // Phone validate
    await tester.enterText(phoneInput, getRandomInt(100000, 999999).toString());
    await tester.pumpAndSettle();
    tester.printToConsole('Phone validation done');

    // Business Register validate
    await tester.enterText(nameInput, "Transporter.app-" + getRandomString(5));
    await tester.pumpAndSettle();
    tester.printToConsole('Name validation done');

    // Stress Address validate
    await tester.enterText(streetAddressInput, getRandomString(10));
    await tester.pumpAndSettle();
    tester.printToConsole('Stress address validation done');

    // Stress Address validate
    await tester.enterText(businessRegisterInput, getRandomString(10));
    await tester.pumpAndSettle();
    tester.printToConsole('Business register validation done');

    // final countryDropdown = find.byKey(const ValueKey('countryDropdown'));
    // final provinceStateDropdown = find.byKey(const ValueKey('provinceStateDropdown'));
    // final districtDropdown = find.byKey(const ValueKey('districtDropdown'));

    // expect(find.text('Province/State'), findsNothing);

    // expect(find.text('District'), findsNothing);

    // final controller = Get.find<AddPartnerController>();
    // await tester.pumpAndSettle();

    // final country = controller.countries[getRandomInt(0, controller.countries.length > 5 ? 5 : controller.countries.length)];

    // await tester.tap(countryDropdown);
    // await tester.pumpAndSettle();
    // expect(find.text(country.displayLabel), findsWidgets);

    // await tester.tap(find.byKey(ValueKey(country.value)));
    // await tester.pumpAndSettle();
    // expect(find.text(country.displayLabel), findsWidgets);

    // final province = controller.providerState[getRandomInt(0, controller.providerState.length > 5 ? 5 : controller.providerState.length)];

    // await tester.tap(provinceStateDropdown);
    // await tester.pumpAndSettle();
    // expect(find.text(province.displayLabel), findsWidgets);

    // await tester.tap(find.byKey(ValueKey(province.value)));
    // await tester.pumpAndSettle();
    // expect(find.text(province.displayLabel), findsWidgets);

    // await scrollThePage(tester, scrollKey: 'addPartnerScroll');

    // final district = controller.districts[getRandomInt(0, controller.districts.length > 5 ? 5 : controller.districts.length)];

    // await tester.tap(districtDropdown);
    // await tester.pumpAndSettle();
    // expect(find.text(district.displayLabel), findsWidgets);

    // await tester.tap(find.byKey(ValueKey(district.value)));
    // await tester.pumpAndSettle();
    // expect(find.text(district.displayLabel), findsWidgets);

    await tester.tap(find.byKey(const ValueKey('addPartnerButton')));
    await tester.pumpAndSettle();
    await tester.pumpAndSettle();
  }

  Future<void> inviteSpinnerPartner() async {
    await scrollThePage(tester, scrollKey: 'manageBusinessScroll');

    //2 Go to Invite Farm screen
    await tester.tap(find.byKey(const ValueKey('SpinnerButton')));
    await tester.pumpAndSettle();

    final signIn = find.byKey(const ValueKey('addPartnerButton'));
    await tester.tap(signIn);
    await tester.pumpAndSettle();

    final firstnameInput = find.byKey(const ValueKey('firstnameInput'));
    final lastnameInput = find.byKey(const ValueKey('lastnameInput'));
    final emailInput = find.byKey(const ValueKey('emailInput'));
    final phoneInput = find.byKey(const ValueKey('phoneInput'));
    final nameInput = find.byKey(const ValueKey('nameInput'));

    // Email validate
    await tester.enterText(emailInput, "abc");
    await tester.pumpAndSettle();
    expect(find.text('Please enter your email address in format: yourname@example.com'), findsOneWidget);
    await tester.enterText(emailInput, "abc@12");
    await tester.pumpAndSettle();
    expect(find.text('Please enter your email address in format: yourname@example.com'), findsOneWidget);
    await tester.enterText(emailInput, "abc@gmail.");
    await tester.pumpAndSettle();
    expect(find.text('Please enter your email address in format: yourname@example.com'), findsOneWidget);
    await tester.enterText(emailInput, "abc@gmail.com");
    await tester.pumpAndSettle();
    expect(find.text('Please enter your email address in format: yourname@example.com'), findsNothing);
    await tester.enterText(emailInput, getRandomEmail());
    await tester.pumpAndSettle();
    expect(find.text('Please enter your email address in format: yourname@example.com'), findsNothing);
    tester.printToConsole('Email validation done');
    await tester.pumpAndSettle();

    // Firstname validate
    await tester.enterText(firstnameInput, "Spinner.app");
    await tester.pumpAndSettle();
    tester.printToConsole('Firstname validation done');

    // Lastname validate
    await tester.enterText(lastnameInput, getRandomString(10));
    await tester.pumpAndSettle();
    tester.printToConsole('Lastname validation done');

    // Phone validate
    await tester.enterText(phoneInput, getRandomInt(100000, 999999).toString());
    await tester.pumpAndSettle();
    tester.printToConsole('Phone validation done');

    // Business Register validate
    await tester.enterText(nameInput, "Spinner.app-"+ getRandomString(5));
    await tester.pumpAndSettle();
    tester.printToConsole('Business register validation done');

    await tester.tap(find.byKey(const ValueKey('addPartnerButton')));
    await tester.pumpAndSettle();
    await tester.pumpAndSettle();
  }
}
