import 'package:flutter/material.dart';
import 'package:usdol/app/core.dart';

abstract class AuthController extends GetxController {
  late Rx<InputItem> _langSelected;
  InputItem get langSelected => _langSelected.value;
  set langSelected(InputItem value) => _langSelected.value = value;

  List<InputItem> languageSupports = [];

  @override
  @mustCallSuper
  void onInit() {
    _initLanguages();
    super.onInit();
  }

  void _initLanguages() {
    AppLanguage.supportLanguages.forEach((key, value) {
      languageSupports.add(
        InputItem(
          displayLabel: value.displayLabel,
          value: key,
          icon: value.value,
        ),
      );
    });

    String selected = Prefs.getString(
      Defines.languageKey,
      defaultValue: AppLanguage.defaultLanguage,
    );
    _langSelected = (languageSupports
                .firstWhereOrNull((element) => element.value == selected) ??
            languageSupports.first)
        .obs;
  }

  Future<void> changeLanguage(BuildContext context, InputItem? lang) async {
    if (lang == null) return;
    await Prefs.saveString(Defines.languageKey, lang.value);
    DioHelper.updateHeader(
      DioHelper.currentDio(),
      {
        "language": lang.value,
      },
    );
    await MyApp.of(context)?.setLanguage(lang.value, 'US');
    langSelected = lang;
  }
}
