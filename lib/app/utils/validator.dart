import 'package:usdol/app/core.dart';

class Validator {
  static String? emailValidation(String? value) {
    if (value != null && StringExtensions(value).isEmail()) {
      return null;
    } else {
      if (value == null || value.isEmpty) {
        return S.current.emailLength;
      } else {
        return S.current.invalidEmailAddress;
      }
    }
  }

  static String? firstNameValidation(String? value) {
    if (value != null && value.isNotEmpty) {
      return null;
    } else {
      return S.current.firstNameLength;
    }
  }

  static String? lastNameValidation(String? value) {
    if (value != null && value.isNotEmpty) {
      return null;
    } else {
      return S.current.lastNameLength;
    }
  }

  static String? nameValidation(String? value) {
    if (value == null || value.isEmpty) {
      return S.current.nameLength;
    }

    return null;
  }

  static String? businessNameValidation(String? value) {
    if (value == null || value.isEmpty) {
      return S.current.bussinessNameLength;
    }

    return null;
  }

  static String? businessValidation(String? value) {
    if (value != null && value.isNotEmpty) {
      return null;
    } else {
      return S.current.businessSpecial;
    }
  }

  static String? oarIdValidation(String? value) {
    if (value != null && value.isNotEmpty) {
      return null;
    } else {
      return S.current.osIdLength;
    }
  }
}
