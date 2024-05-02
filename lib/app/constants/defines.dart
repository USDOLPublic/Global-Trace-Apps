import 'package:flutter/material.dart';
import 'package:usdol/app/core.dart';

class Defines {
  static const unGroupId = "un-group";
  static const languageKey = "app-language-key";
  static const recorationKey = "recoration-key";
  static const themModeKey = "theme-key";
  static const tutorialKey = "tutorial-key";
  static const saqLatestDataKey = "saq-latest-key";
  static const saqAnswerDataKey = "saq-answer-key";
  static const commoditiesDataKey = "commodities-data-key";
  static const purchaseProductDefinitionKey = "purchase-product-definition-key";
  static const soldProductDefinitionKey = "sold-product-definition-key";
  static const purchaseSellerConfigKey = "purchase-seller-config-key";
  static const importLocationDataKey = "import-location-data-key";
  static const seasonTimeKey = "season-time-key";

  //animation time duration
  static const navTransitionDuration = 200; //milisecond

  //Design size
  static const Size designSign = Size(360, 640);

  static const imageFormatsSupported = ['jpg', 'png', 'jpeg'];
}

class AppColors {
  static const main = Color(0xff3E415B);
  static const green = Color(0xff36C67E);
  static const red = Color(0xffFF8888);
  static const black = Color(0xff000000);
  static const white = Color(0xffFFFFFF);
  static const green800 = Color(0xff6E906B);
  static const green700 = Color(0xff91B18E);
  static const green600 = Color(0xffD8E5D6);
  static const orange800 = Color(0xffD4903E);
  static const orange700 = Color(0xffF2B062);
  static const orange600 = Color(0xffF4DFC2);
  static const grey800 = Color(0xff2D2D34);
  static const grey700 = Color(0xff515157);
  static const grey600 = Color(0xff6D6F7E);
  static const grey300 = Color(0xffA6A7B4);
  static const grey200 = Color(0xffCBCCD6);
  static const grey100 = Color(0xffF5F5F5);
  static const k4B4B45 = Color(0xff4B4B45);
  static const kE5E5E5 = Color(0xffE5E5E5);
  static const k555555 = Color(0xff555555);
}

class AppElevation {
  static const card = .5;
  static const button = 1;
  static const navigationBar = 2;
  static const popup = 2;
}

class AppProperties {
  static const double contentMargin = 16;
  static const double inputHight = 62;
  static const double circleRadius = 8;
  static const double lineSpace = 8;
  static const String dateFormatDefault = "dd/MM/yyyy";
  static const String dateTimeFormatDefault = "dd/MM/yyyy HH:mm";
}

class AppThemeMode {
  static const dark = 1;
  static const light = 0;
}

class HistoryStatus {
  static const complete = "Complete";
  static const pending = "Pending";
  static const failed = "Failed";

  static String getStatusString(BuildContext context, String status) {
    switch (status) {
      case complete:
        return S.of(context).completed;
      case pending:
        return S.of(context).pending;
      case failed:
        return S.of(context).failed;
      default:
        return '';
    }
  }
}

class OfflineHttpStatus {
  static const List<int> pendingStatus = [
    status401Unauthorized,
    status403Forbidden,
    status408RequestTimeout,
    status429TooManyRequests,
    status440LoginTimeout,
    status460ClientClosedRequest,
    status499ClientClosedRequest,
    status503ServiceUnavailable,
    status504GatewayTimeout,
    status521WebServerIsDown,
    status522ConnectionTimedOut,
    status524TimeoutOccurred,
  ];
}

class ActionKey {
  static const updateProfile = "update_profile";
  static const updateSaq = "update_saq";
  static const editTransformationPartner = "edit_transformation_partner";
  static const loginAndLogout = "login_logout";
}

int indicatorType = 1;
int subIndicatorType = 2;

class AppLanguage {
  static const defaultLanguage = "en";
  static Map<String, InputItem> supportLanguages = <String, InputItem>{
    'en': InputItem(
      displayLabel: 'Eng',
      value: AssetsConst.icUSFlag,
    ),
    'ur': InputItem(
      displayLabel: 'اردو',
      value: AssetsConst.icURFlag,
    ),
  };
}
