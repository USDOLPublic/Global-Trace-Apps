import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'test_define.dart';
import 'test_utils.dart';

class AuthRobot {
  AuthRobot(this.tester);
  final WidgetTester tester;

  int roleLoginTestIdx = 0;

  String? errorText(String? value) => '$value/error';
  Future<void> loginFormValid() async {
    tester.printToConsole('SignIn screen open');
    await addDelay(1000);
    await tester.pumpAndSettle();
    final emalFind = find.byKey(const ValueKey('emailSignUpField'));
    final password = find.byKey(const ValueKey('passwordSignUpField'));
    final signIn = find.byKey(const ValueKey('signInButton'));
    await tester.tap(signIn);
    expect(find.text("Sign in"), findsWidgets);
    await addDelay(500);
    //

    await tester.enterText(emalFind, "abc");
    await tester.pumpAndSettle();
    expect(find.text('Please enter your email address in format: yourname@example.com'), findsOneWidget);
    await tester.enterText(emalFind, "abc@12");
    await tester.pumpAndSettle();
    expect(find.text('Please enter your email address in format: yourname@example.com'), findsOneWidget);
    await tester.enterText(emalFind, "abc@gmail.");
    await tester.pumpAndSettle();
    expect(find.text('Please enter your email address in format: yourname@example.com'), findsOneWidget);
    await tester.enterText(emalFind, "abc@gmail.com");
    await tester.pumpAndSettle();
    expect(find.text('Please enter your email address in format: yourname@example.com'), findsNothing);
    await tester.enterText(emalFind, "abc@gmail.com.abc");
    await tester.pumpAndSettle();
    expect(find.text('Please enter your email address in format: yourname@example.com'), findsNothing);
    tester.printToConsole('Email validation done');
    await tester.pumpAndSettle();
    //Password
    await tester.enterText(password, "123");
    await tester.pumpAndSettle();
    expect(find.text('At least eight characters'), findsOneWidget);
    await tester.enterText(password, "12345678");
    await tester.pumpAndSettle();
    expect(find.text('At least one letter'), findsOneWidget);
    await tester.enterText(password, "1234567a");
    await tester.pumpAndSettle();
    expect(find.text('At least one capital letter'), findsOneWidget);
    tester.printToConsole('Password validation done');
    await tester.pumpAndSettle();
  }

  Future<void> login() async {
    if (roleLoginTestIdx < roleEmails.length) {
      String email = roleEmails[roleLoginTestIdx];
      tester.printToConsole('SignIn screen open');
      await tester.pumpAndSettle();
      tester.printToConsole('Email login: $email');
      await tester.enterText(find.byKey(const ValueKey('emailSignUpField')), email);
      await tester.enterText(find.byKey(const ValueKey('passwordSignUpField')), defautPassword);
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();

      await addDelay(1000);
      await tester.pumpAndSettle();
      roleLoginTestIdx++;
      tester.printToConsole('SignUp role idx: $roleLoginTestIdx');
      //
      if (email.startsWith("ginner")) {
        expect(find.text("Purchase"), findsOneWidget);
        await logout();
      } else if (email.startsWith("farmmonitor")) {
        expect(find.text("Community Risk Scan"), findsOneWidget);
        await logout();
      } else {
        expect(find.text("Sign in"), findsWidgets);
        await login();
      }
    }
  }

//1
  Future<void> logout() async {
    //2
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('menuButton')));
    await tester.pumpAndSettle();
    //3
    await tester.tap(find.byKey(const ValueKey('logoutButton')));

    //4
    await tester.pumpAndSettle();
    tester.printToConsole('Login screen opens');
    await login();
  }

  Future<void> loginWithGinnerSAQ() async {
    await loginWith(ginnerDefaultNewAccount, defautPassword);
  }

  Future<void> loginWithGinner() async {
    await loginWith(ginnerDefaultAccount, defautPassword);
  }

  Future<void> loginWithFarmMonitor() async {
    await loginWith(farmmonitorDefaultAccount, defautPassword);
  }

  Future<void> loginWith(String email, String password) async {
    await tester.pumpAndSettle();
    tester.printToConsole("======== Login ========");
    await tester.enterText(find.byKey(const ValueKey('emailSignUpField')), email);
    await tester.enterText(find.byKey(const ValueKey('passwordSignUpField')), password);
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();
    await addDelay(1000);
  }
}
