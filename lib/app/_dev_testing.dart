import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:usdol/app/core.dart';

const _environmentKey = "environment-key";

Future<EnvType?> _getEnvSaved() async {
  await Prefs.load();
  String envStrSaved = Prefs.getString(_environmentKey);
  return EnumUtil.enumValueFromString<EnvType>(envStrSaved, EnvType.values);
}

///
///Load saved environment for testing with switch environment in runtime
///
Future<void> loadSavedEnvironment() async {
  if (BuildConfig().isEnableSwitchEnv) {
    EnvType? envSaved = await _getEnvSaved();
    if (envSaved != null) {
      BuildConfig().env = Env.fromType(envSaved);
    }
  }
}

void showHistoryDebugLog(HistoryModel history) {
  if (BuildConfig().isDebug) {
    Clipboard.setData(ClipboardData(text: history.note ?? ""));
    SnackBars.info(message: "Cause: " + (history.note ?? "")).show();
  }
}

void changeEnvironment() {
  if (BuildConfig().isEnableSwitchEnv) {
    Get.dialog<void>(
      BasePopup(
        title: const Text("App Environments"),
        body: SizedBox(
          height: Get.height * .45,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: const Text("Development Environment"),
                    onTap: () {
                      Get.back<void>();
                      _changeEnvironment(Env.dev());
                    },
                    leading: const Icon(Icons.api_rounded),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    tileColor: BuildConfig().env is DevEnv ? Theme.of(Get.context!).primaryColorLight : Theme.of(Get.context!).dividerColor,
                  ),
                  const SizedBox(height: 8),
                  ListTile(
                    title: const Text("User Acceptance Testing Environment"),
                    onTap: () {
                      Get.back<void>();
                      _changeEnvironment(UATEnv());
                    },
                    leading: const Icon(Icons.api_rounded),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    tileColor: BuildConfig().env is UATEnv ? Theme.of(Get.context!).primaryColorLight : Theme.of(Get.context!).dividerColor,
                  ),
                  const SizedBox(height: 8),
                  ListTile(
                    title: const Text("Production Environment"),
                    onTap: () {
                      Get.back<void>();
                      _changeEnvironment(ProductionEnv());
                    },
                    leading: const Icon(Icons.api_rounded),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    tileColor: BuildConfig().env is ProductionEnv ? Theme.of(Get.context!).primaryColorLight : Theme.of(Get.context!).dividerColor,
                  ),
                ],
              ),
            ),
          ),
        ),
        isSmallAlert: false,
        actions: [
          TextButton(
            onPressed: () async {
              Get.back<void>();
            },
            child: const Text("Done"),
          ),
        ],
      ),
    );
  }
}

void _changeEnvironment(Env env) async {
  BuildConfig().env = env;
  DioHelper.updateBaseUrl(DioHelper.currentDio(), Uri.parse(BuildConfig().env.baseApi));
  SnackBars.info(message: "Changing to Environment ->[" + BuildConfig().env.getInfo() + "]").show();
  await Prefs.saveString(_environmentKey, EnumUtil.enumValueToString(BuildConfig().env.buildType));
  //Get.offAndToNamed<void>("/");
}

void showAppVersion() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  Connectivity connectivity = Connectivity();
  ConnectivityResult connectResult = await connectivity.checkConnectivity();
  Get.dialog<void>(
    BasePopup(
      title: const Text("App Information"),
      body: SizedBox(
        height: Get.height * .45,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildLineInfo("App name: ", packageInfo.appName),
                _buildLineInfo("Version: ", packageInfo.version),
                _buildLineInfo("Build number: ", packageInfo.buildNumber),
                _buildLineInfo("Build signature: ", packageInfo.buildSignature),
                _buildLineInfo("Environment: ", BuildConfig().env.getInfo()),
                const Divider(),
                _buildLineInfo("Platform OS: ", (Platform.operatingSystem)),
                _buildLineInfo("Platform version: ", (Platform.version)),
                _buildLineInfo("OS version: ", (Platform.operatingSystemVersion)),
                _buildLineInfo("Platform: ", (Platform.script.toString())),
                _buildLineInfo("Number of processors: ", (Platform.numberOfProcessors.toString())),
                _buildLineInfo("Build: ", (Platform.resolvedExecutable.toString())),
                const Divider(),
                _buildLineInfo("Date: ", DateUtil.getNowDateStr()),
                _buildLineInfo("Connectivity: ", connectResult.toString().split(".").last),
              ],
            ),
          ),
        ),
      ),
      isSmallAlert: false,
      actions: [
        TextButton(
          onPressed: () async {
            Get.back<void>();
          },
          child: Text(S.current.done),
        ),
      ],
    ),
  );
}

Widget _buildLineInfo(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      children: [
        Text(label),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(color: AppColors.green),
          ),
        ),
      ],
    ),
  );
}
