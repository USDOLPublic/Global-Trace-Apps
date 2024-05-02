import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:usdol/app/core.dart';

import 'test_define.dart';
import 'test_utils.dart';

class ProfileRobot {
  const ProfileRobot(this.tester);

  final WidgetTester tester;

  Future<void> openScreen() async {
    tester.printToConsole("======== Start Profile ========");
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('menuButton')));

    await tester.pumpAndSettle();
    //1 Go to Profile screen
    await tester.tap(find.byKey(const ValueKey('profileButton')));
    await tester.pumpAndSettle();

    await tester.pumpAndSettle();
    //2 Go to Edit profile screen
    await tester.tap(find.byKey(const ValueKey('editButton')));
    await tester.pumpAndSettle();
  }

  Future<void> profile() async {
    final firstNameInput = find.byKey(const ValueKey('firstNameInput'));
    final lastNameInput = find.byKey(const ValueKey('lastNameInput'));
    final phoneInput = find.byKey(const ValueKey('phoneInput'));
    final emailInput = find.byKey(const ValueKey('emailInput'));
    final businessRegisterNumber = find.byKey(const ValueKey('businessRegisterNumber'));

    // Email validate
    await tester.enterText(emailInput, "abc");
    await tester.pumpAndSettle();
    expect(find.text('Please enter your email address in format: yourname@example.com'), findsWidgets);
    await tester.enterText(emailInput, "abc@12");
    await tester.pumpAndSettle();
    expect(find.text('Please enter your email address in format: yourname@example.com'), findsWidgets);
    await tester.enterText(emailInput, "abc@gmail.");
    await tester.pumpAndSettle();
    expect(find.text('Please enter your email address in format: yourname@example.com'), findsWidgets);
    await tester.enterText(emailInput, "abc@gmail.com");
    await tester.pumpAndSettle();
    expect(find.text('Please enter your email address in format: yourname@example.com'), findsNothing);
    await tester.enterText(emailInput, ginnerDefaultAccount);
    await tester.pumpAndSettle();
    expect(find.text('Please enter your email address in format: yourname@example.com'), findsNothing);
    tester.printToConsole('Email validation done');
    await addDelay(500);

    // Firstname validate
    await tester.enterText(firstNameInput, "Ginner");
    await tester.pumpAndSettle();
    tester.printToConsole('Firstname validation done');

    // Lastname validate
    await tester.enterText(lastNameInput, const Uuid().v1());
    await tester.pumpAndSettle();
    tester.printToConsole('Lastname validation done');

    // Phone validate
    await tester.enterText(phoneInput, "12345" + getRandomInt(1, 100).toString());
    await tester.pumpAndSettle();
    tester.printToConsole('Phone validation done');

    // Business Register validate
    await tester.enterText(businessRegisterNumber, const Uuid().v1().substring(0, 5));
    await tester.pumpAndSettle();
    tester.printToConsole('Business register validation done');

    //Scroll
    await scrollThePage(tester, scrollKey: "editProfileScroll");
    final certificationDropdown = find.byKey(const ValueKey('certificationDropdown'));
    final chainDropdown = find.byKey(const ValueKey('chainDropdown'));

    int lengthOfCer = profileCertificationsDef.length;
    //limit to run in a screen
    if (lengthOfCer > 3) {
      lengthOfCer = 3;
    }
    final certification = profileCertificationsDef[getRandomInt(0, lengthOfCer)];

    await tester.tap(certificationDropdown);
    await tester.pumpAndSettle();
    expect(find.text(certification.displayLabel), findsWidgets);
    final cerFinder = find.byKey(ValueKey(certification.value));
    await tester.tap(cerFinder);
    await tester.pumpAndSettle();
    expect(find.text(certification.displayLabel), findsWidgets);
    await tester.tap(chainDropdown);
    await tester.pumpAndSettle();
    expect(find.text('Product Segregation'), findsWidgets);

    await tester.tap(find.byKey(const ValueKey('PRODUCT_SEGREGATION')));
    await tester.pumpAndSettle();

    expect(find.text('Reconciliation Window Start Date'), findsNothing);

    expect(find.text('Reconciliation Window Duration'), findsNothing);

    expect(find.text('Product Segregation'), findsWidgets);

    //3 Go to Profile screen
    await tester.tap(find.byKey(const ValueKey('nextButton')));
    await tester.pumpAndSettle();
    await tester.pumpAndSettle();
    expect(find.text('My Profile'), findsWidgets);
  }
}
