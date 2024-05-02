import 'package:usdol/app/core.dart';

class BuildConfig {
  static final BuildConfig _instance = BuildConfig._internal();
  factory BuildConfig() {
    return _instance;
  }
  BuildConfig._internal();
  bool _isDebug = true;
  bool get isDebug => _isDebug;
  set isDebug(bool value) {
    _isDebug = value;
    LogUtil.d("Changed Debug to $_isDebug");
  }

  bool isEnableSwitchEnv = false;

  Env _env = Env.dev();
  Env get env => _env;
  set env(Env value) {
    _env = value;
    LogUtil.d("Changed Environment to ${_env.buildType}");
  }

  Future<void> setupEnvironment() async {
    //Get config from --dart-define
    isDebug = const String.fromEnvironment('APP_IS_DEBUG', defaultValue: 'n') == 'y';
    isEnableSwitchEnv = const String.fromEnvironment('APP_IS_ENABLE_SWITCH_ENV', defaultValue: 'n') == 'y';
    String envStr = const String.fromEnvironment('APP_ENVIRONMENT_TYPE', defaultValue: "production");
    final EnvType envType = EnumUtil.enumValueFromString<EnvType>(envStr, EnvType.values) ?? EnvType.production;
    env = Env.fromType(envType);
  }
}
