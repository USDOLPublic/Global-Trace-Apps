import 'package:flutter/widgets.dart';
import 'package:usdol/app/core.dart';

abstract class RequestInformationEnum {
  static const int labourLink = 1;
  static const int hotline = 2;
  static const int farmMonitorApp = 3;
  static const int admin = 4;
  static const int farmMonitorWeb = 5;

  static String getTitle(int type) {
    switch (type) {
      case labourLink:
        return 'LabourLink';
      case hotline:
        return 'Hotline';
      case farmMonitorApp:
        return 'FarmMonitorApp';
      case farmMonitorWeb:
        return 'FarmMonitorWeb';
      default:
        return '';
    }
  }
}

abstract class ReportStatusEnum {
  static const int newStatus = 1;
  static const int viewedStatus = 2;
  static const int respondedSendStatus = 3;

  static String getReportStatus(int type, BuildContext context) {
    switch (type) {
      case newStatus:
        return S.of(context).newStatus;
      case viewedStatus:
        return S.of(context).viewed;
      case respondedSendStatus:
        return S.of(context).responseSent;
      default:
        return '';
    }
  }
}
