import 'package:flutter/material.dart';
import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'app/core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterBranchSdk.init(
    useTestKey: false,
    enableLogging: true,
    disableTracking: false,
  );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MyApp();
  }

  static _MyApp? of(BuildContext context) =>
      context.findAncestorStateOfType<_MyApp>();
}

class _MyApp extends State<MyApp> {
  late Locale _locale;
  late ThemeData _themeData;

  @override
  void initState() {
    _locale = const Locale("en", "US");
    _themeData = lightTheme;
    //init build config
    BuildConfig().setupEnvironment();
    //Development mode config
    LogUtil.init(isDebug: BuildConfig().isDebug, tag: "Global Trace");
    Prefs.load();
    //Dev testing
    loadSavedEnvironment();
    super.initState();
    WidgetsBinding.instance.addObserver(
      LifecycleEventHandler(),
    );
  }

  @override
  Widget build(BuildContext context) {
    AppOrientation.setPreferredOrientationPortrait();
    return DismissKeyboard(
      child: LimitedScaleFactor(
        child: GetMaterialApp(
          title: "GlobalTrace",
          debugShowCheckedModeBanner: false,
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate
          ],
          navigatorObservers: [
            LocalNotificationObserver(),
          ],
          supportedLocales: S.delegate.supportedLocales,
          locale: _locale,
          theme: _themeData,
          themeMode: ThemeMode.light,
          defaultTransition: Transition.cupertino,
          opaqueRoute: Get.isOpaqueRouteDefault,
          popGesture: Get.isPopGestureEnable,
          transitionDuration:
              const Duration(milliseconds: Defines.navTransitionDuration),
          initialBinding: MainBinding(),
          initialRoute: AppPages.intilial,
          getPages: AppPages.routes,
        ),
      ),
    );
  }

  Future<void> setLanguage(String lang, String country) async {
    Locale locale = Locale(lang, country);
    await S.load(locale);
    await Future.delayed(const Duration(milliseconds: 300), () => null);
    setState(() {
      _locale = locale;
    });
    Certification.definition();
    await Get.forceAppUpdate();
  }
}
