import '../core.dart';

///Developnent environment
class DevEnv extends Env {
  DevEnv();

  @override
  String appId = "";

  @override
  String baseApi = "https://globaltrace-api.dev.dgnx.io";

  @override
  EnvType buildType = EnvType.dev;

  @override
  String dbName = "usdol-db-dev1";

  @override
  String dbVersion = "1.0";
}

///User Acceptance Testing environment
class QAEnv extends Env {
  QAEnv();
  @override
  String appId = "";

  @override
  String baseApi = "https://globaltrace-api.qa.dgnx.io/";

  @override
  EnvType buildType = EnvType.qa;

  @override
  String dbName = "usdol-db-qa";

  @override
  String dbVersion = "1.0";
}

///User Acceptance Testing environment
class UATEnv extends Env {
  UATEnv();
  @override
  String appId = "";

  @override
  String baseApi = "https://globaltrace-api.uat.dgnx.io";

  @override
  EnvType buildType = EnvType.uat;

  @override
  String dbName = "usdol-db-uat";

  @override
  String dbVersion = "1.0";
}

///User Acceptance Testing environment
class UAT2Env extends Env {
  UAT2Env();
  @override
  String appId = "";

  @override
  String baseApi = "https://globaltrace-api.uat2.dgnx.io";

  @override
  EnvType buildType = EnvType.uat2;

  @override
  String dbName = "usdol-db-uat2";

  @override
  String dbVersion = "1.0";
}

///Staging environment
class StagingEnv extends Env {
  StagingEnv();
  @override
  String appId = "";

  @override
  String baseApi = "https://globaltrace-api.staging.dgnx.io";

  @override
  EnvType buildType = EnvType.staging;

  @override
  String dbName = "usdol-db-stg";

  @override
  String dbVersion = "1.0";
}

///Production environment
class ProductionEnv extends Env {
  ProductionEnv();
  @override
  String appId = "";

  @override
  String baseApi = "https://globaltrace-api.uat.dgnx.io";

  @override
  EnvType buildType = EnvType.production;

  @override
  String dbName = "global-trace-pakistan-prod";

  @override
  String dbVersion = "1.0";
}

///
///Environment
///
abstract class Env {
  Env();
  abstract String baseApi;
  abstract String dbName;
  abstract String dbVersion;
  abstract String appId;
  abstract EnvType buildType;

  factory Env.dev() => DevEnv();
  factory Env.uat() => UATEnv();
  factory Env.uat2() => UAT2Env();
  factory Env.staging() => StagingEnv();
  factory Env.prod() => ProductionEnv();
  factory Env.qa() => QAEnv();

  factory Env.fromType(EnvType type) {
    switch (type) {
      case EnvType.dev:
        return Env.dev();
      case EnvType.uat:
        return Env.uat();
      case EnvType.uat2:
        return Env.uat2();
      case EnvType.staging:
        return Env.staging();
      case EnvType.production:
        return Env.prod();
      case EnvType.qa:
        return Env.qa();
    }
  }

  String getInfo() {
    String envStr = EnumUtil.enumValueToString(buildType);
    return "[$envStr] - API[$baseApi]";
  }
}

enum EnvType { dev, qa, uat, uat2, staging, production }
