import 'package:flutter/material.dart';
import 'package:usdol/app/core.dart';

class AuthLayout extends StatelessWidget {
  final Widget child;
  final String title;
  final Widget? icon;
  final String subtitle;
  final AuthController authController;
  const AuthLayout({
    Key? key,
    required this.child,
    this.title = "",
    this.subtitle = "",
    this.icon,
    required this.authController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 24),
                  child: InkWell(
                    onLongPress: BuildConfig().isEnableSwitchEnv
                        ? changeEnvironment
                        : null,
                    child: Image.asset(
                      AssetsConst.icLaunch,
                      height: 32,
                    ),
                  ),
                ),
              ),
              _buildSelectLanguages(context),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: Get.height * 0.1),
                  if (icon != null)
                    Center(
                      child: SizedBox(
                        width: 66,
                        height: 66,
                        child: icon,
                      ),
                    ),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.lead(),
                  ),
                  const SizedBox(height: 4),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppProperties.contentMargin),
                    child: Text(
                      subtitle,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(AppProperties.contentMargin),
                    child: child,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectLanguages(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        height: 40,
        margin: const EdgeInsets.only(
          top: 8,
          right: AppProperties.contentMargin,
        ),
        child: Obx(
          () => LanguageSelector(
            itemList: authController.languageSupports,
            seleted: authController.langSelected,
            onChanged: (language) async {
              await authController.changeLanguage(context, language);
            },
          ),
        ),
      ),
    );
  }
}
