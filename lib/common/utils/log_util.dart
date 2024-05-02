import 'dart:developer';
/// Log Util.
class LogUtil {
  static const String _defTag = 'common';
  static bool _debugMode = false;
  static int _maxLen = 9999;
  static String _tagValue = _defTag;

  static void init({
    String tag = _defTag,
    bool isDebug = false,
    int maxLen = 9999,
  }) {
    _tagValue = tag;
    _debugMode = isDebug;
    _maxLen = maxLen;
  }

  static void d(Object object, {String? tag}) {
    if (_debugMode) {
      _printLog(tag, ' d ', object);
    }
  }

  static void e(Object object, {String? tag}) {
    if (_debugMode) {
      _printLog(tag, ' e ', object);
    }
  }

  static void v(Object object, {String? tag}) {
    if (_debugMode) {
      _printLog(tag, ' v ', object);
    }
  }

  static void _printLog(String? tag, String? stag, Object? object) {
    String da = object?.toString() ?? 'null';
    if(da.length > _maxLen){
      da = da.substring(0, _maxLen) + '<…>';
    }
    tag = tag ?? _tagValue;
      log('$tag$stag $da');
      return;
    }
}
