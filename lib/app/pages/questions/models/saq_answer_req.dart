import 'package:usdol/app/core.dart';

class SaqAnswerReq {
  SaqAnswerReq({
    this.answers,
  });

  List<SaqAnswerItem>? answers;

  Map<String, dynamic> toJson() => <String, dynamic>{
        "answers": answers == null
            ? null
            : List<dynamic>.from(answers!.map<dynamic>((x) => x.toRequest())),
      };
}
