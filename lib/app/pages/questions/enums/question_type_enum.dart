abstract class QuestionType {
  static const String yesNo = "YES_NO";
  static const String checkbox = "MULTI_CHOICE";
  static const String numeric = "NUMBER";
  static const String radio = "ONE_CHOICE";
  static const String freeText = "FREE_TEXT";

  static int getOrderWeight(String type) {
    switch (type) {
      case checkbox:
        return 5;
      case yesNo:
        return 4;
      case numeric:
        return 3;
      case freeText:
        return 2;
      case radio:
        return 1;
    }
    return 0;
  }
}
