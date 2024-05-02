import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:flutter_driver/flutter_driver.dart' as dri;
import 'package:flutter_test/flutter_test.dart';
import 'package:usdol/app/core.dart';

Future<void> addDelay(int ms) async {
  await Future<void>.delayed(Duration(milliseconds: ms));
}

Future<bool> isPresent(dri.SerializableFinder finder, dri.FlutterDriver driver, {Duration timeout = const Duration(seconds: 1)}) async {
  try {
    await driver.waitFor(finder, timeout: timeout);
    return true;
  } catch (e) {
    return false;
  }
}

Future<void> scrollThePage(WidgetTester tester, {String scrollKey = "singleChildScrollView", bool scrollUp = false}) async {
  final listFinder = find.byKey(ValueKey(scrollKey));
  if (scrollUp) {
    await tester.fling(listFinder, const Offset(0, 500), 10000);
    await tester.pumpAndSettle();
  } else {
    await tester.fling(listFinder, const Offset(0, -500), 10000);
    await tester.pumpAndSettle();
  }
}

Future<void> scrollThePageTo(
  WidgetTester tester,
  Finder expected, {
  String scrollKey = "singleChildScrollView",
  bool scrollUp = false,
}) async {
  final listFinder = find.byKey(ValueKey(scrollKey));
  await tester.dragUntilVisible(
      expected, // what you want to find
      listFinder,
      // widget you want to scroll
      const Offset(0, 500) // delta to move
      );
}

Future<String> imageFileImport() async {
  String imgOnlinePath = "https://websitehcm.com/wp-content/uploads/2021/04/flutter-mobile-web-desktop.jpg";
  dio.Options options = dio.Options();
  options.responseType = dio.ResponseType.bytes;
  dio.Dio myDio = dio.Dio();
  try {
    Uri uriFile = Uri.parse(imgOnlinePath);
    myDio.options.baseUrl = uriFile.origin;
    var res = await myDio.get<List<int>>(uriFile.toString().replaceAll(uriFile.origin, ""), options: options);
    String fileName = uriFile.path.split('/').last;
    File file = await FileUtil.writeFileToStorage(res.data!, fileName);
    LogUtil.d("File Download: " + file.path);
    return file.path;
  } catch (e) {
    return "";
  }
}

int getRandomInt(int from, int to) {
  var rng = Random();
  return (rng.nextInt(to + from) - from);
}

double getRandomDouble(int from, int to) {
  var rng = Random();
  return (rng.nextDouble() * (to - from) + from);
}

String getRandomEmail() {
  return "app.intergration." + getRandomString(5) + getRandomInt(100, 999).toString() + "@usd.vnd";
}

String getRandomString(int length) {
  const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();
  return String.fromCharCodes(Iterable.generate(length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
}

Future<String?> getRandomLot() async {
  return null;
}

Future<String?> getFirstLot() async {
  return null;
}
