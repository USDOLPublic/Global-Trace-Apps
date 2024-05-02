import 'package:usdol/app/core.dart';

class SessionStore {
  SessionModel? getSession() {
    String token = Prefs.getString(SessionStoreKey.accessTokenKey, defaultValue: "");
    String userId = Prefs.getString(SessionStoreKey.userIdKey, defaultValue: "");
    if (token.isEmpty || userId.isEmpty) {
      return null;
    }
    SessionModel session = SessionModel();
    session.accessToken = token;
    session.userId = userId;
    session.expireAt = Prefs.getInt(SessionStoreKey.expireAt);
    session.refreshToken = Prefs.getString(SessionStoreKey.refreshTokenKey);
    return session;
  }

  Future<void> save(SessionModel session) async {
    await Prefs.saveString(SessionStoreKey.accessTokenKey, session.accessToken);
    await Prefs.saveString(SessionStoreKey.userIdKey, session.userId);
    await Prefs.saveString(SessionStoreKey.refreshTokenKey, session.refreshToken);
    await Prefs.saveInt(SessionStoreKey.expireAt, session.expireAt);
  }

  Future<void> clear() async {
    await Prefs.removeKey(SessionStoreKey.accessTokenKey);
    await Prefs.removeKey(SessionStoreKey.userIdKey);
    await Prefs.removeKey(SessionStoreKey.refreshTokenKey);
    await Prefs.removeKey(SessionStoreKey.expireAt);
  }
}

class SessionStoreKey {
  static const String accessTokenKey = "ACCESS_TOKEN_KEY";
  static const String refreshTokenKey = "REFRESH_TOKEN_KEY";
  static const String expireAt = "EXPIRATION_KEY";
  static const String userIdKey = "USER_ID_KEY";
  static const String userEmailKey = "USER_EMAIL_KEY";
  static const String userFirstNameKey = "USER_FIRST_NAME_KEY";
  static const String userLastNameKey = "USER_LAS_NAME_KEY";
}
