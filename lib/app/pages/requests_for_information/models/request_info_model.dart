import 'package:usdol/app/core.dart';

class RequestInfoModel {
  String? title;
  String? source;
  String? location;
  String? message;
  DateTime? submissionAt;
  List<RespondModel>? respondedList;

  RequestInfoModel({
    this.title,
    this.location,
    this.message,
    this.source,
    this.submissionAt,
    this.respondedList,
  });
}
