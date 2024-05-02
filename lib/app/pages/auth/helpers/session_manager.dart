import 'package:usdol/app/core.dart';

class SessionManager {
  SessionModel? session;
  final SessionStore store;
  final AuthHttpService authService;

  SessionManager({required this.store, required this.authService});

  Future<bool> initSession(SessionModel session) async {
    //
    await saveSession(session);
    DioHelper.updateHeader(
      DioHelper.currentDio(),
      {
        "Authorization": "Bearer ${session.accessToken}",
      },
    );
    DioHelper.setInterceptorRefreshToken(
        dio: DioHelper.currentDio(),
        refreshToken: () async {
          bool haveConnection = await NetworkUtil.isConnected();
          if (!haveConnection) {
            return RefreshTokenRes<String>(
              status: RefreshTokenStatus.cancel,
            );
          }
          var result = await renewSession();
          if (result != null && result.accessToken.isNotEmpty) {
            return RefreshTokenRes(
              status: RefreshTokenStatus.success,
              data: result.accessToken,
              authorizationHeader: <String, dynamic>{
                "Authorization": "Bearer ${result.accessToken}"
              },
            );
          } else {
            return RefreshTokenRes<String>(
              status: RefreshTokenStatus.failed,
            );
          }
        });
    if (BuildConfig().isDebug) {
      DioHelper.setInterceptorLogger(
        DioHelper.currentDio(),
        printOnSuccess: true,
      );
    }
    //update session info from User Info
    return true;
  }

  Future<void> saveSession(SessionModel? session) async {
    this.session = session;
    if (session != null) {
      await store.save(session);
    }
  }

  void loadSession() {
    session = store.getSession();
  }

  bool hasSession() {
    if (session == null) loadSession();
    return session != null;
  }

  bool hasSessionExpired() {
    //5-minute clock skew. offset for pre renew token
    // var skewSeconds = 60 * 5;
    int currentMillis = DateTime.now().millisecondsSinceEpoch;
    int valueToCompare = session?.expireAt ?? 0;
    return hasSession() && currentMillis > valueToCompare;
  }

  Future<SessionModel?> renewSession() async {
    if (hasSession()) {
      BaseResp<LoginResp> resp =
          await authService.refreshToken(session?.refreshToken ?? "");
      if (resp.isSuccess() && resp.data != null) {
        session?.accessToken = resp.data!.token ?? "";
        session?.expireAt = resp.data!.expireAt ?? 0;
        session?.refreshToken = resp.data!.refreshToken ?? "";
        await saveSession(session);
        //setup header for service
        DioHelper.updateHeader(
          DioHelper.currentDio(),
          {
            "Authorization": "Bearer ${session?.accessToken}",
          },
        );
        return session;
      } else {
        //handle user account invalid for refresh token
        if (resp.statusCode == 404 || resp.statusCode == 400) {
          await cleanSession();
          Get.offAllNamed<void>(Routes.login);
        }
      }
    }
    return null;
  }

  Future<bool> cleanSession() async {
    await Prefs.removeKey(Defines.tutorialKey);
    await HiveManager.clearAllData();
    if (hasSession()) {
      session = null;
      await store.clear();
      DioHelper.updateHeader(
        DioHelper.currentDio(),
        {
          "Authorization": "",
        },
      );
      DioHelper.clearInterceptors(DioHelper.currentDio());
      return true;
    } else {
      return true;
    }
  }
}
