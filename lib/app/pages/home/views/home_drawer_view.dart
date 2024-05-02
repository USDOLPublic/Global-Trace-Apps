import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:usdol/app/core.dart';

class HomeDrawerView<T extends HomeController> extends GetView<T> {
  const HomeDrawerView({Key? key}) : super(key: key);

  void _onTapProfile() async {
    Get.back<void>();
    await Get.toNamed<void>(Routes.viewProfile);
    controller.checkUpdateUserInfo();
  }

  void _onTapSignOut() {
    Get.back<void>();
    controller.signOut();
  }

  void _onTapManagePartners() {
    Get.back<void>();
    Get.toNamed<void>(Routes.manageBusiness);
  }

  void _onTapOverview() {
    Get.back<void>();
    Get.toNamed<void>(Routes.overview);
  }

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: AppColors.green800,
    );
    return Container(
      width: Get.width * 0.8,
      height: double.infinity,
      color: AppColors.grey100,
      child: SafeArea(
        minimum: const EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 8.0),
              child: IconButton(
                onPressed: () => Get.back<void>(),
                icon: SvgPicture.asset(AssetsConst.closeButton),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: Get.width * .05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (controller.isHavePermissionViewOverview())
                      ListTile(
                        key: const ValueKey('overview'),
                        onTap: _onTapOverview,
                        leading: SvgPicture.asset(AssetsConst.icOverview),
                        title: Text(
                          S.of(context).overview,
                          style: textStyle,
                        ),
                      ),
                    if (controller.isHavePermissionManagePartners())
                      ListTile(
                        key: const ValueKey('managePartners'),
                        onTap: _onTapManagePartners,
                        leading: SvgPicture.asset(AssetsConst.svgManageAccount),
                        title: Text(
                          S.of(context).managePartners,
                          style: textStyle,
                        ),
                      ),
                    ListTile(
                      key: const ValueKey('profileButton'),
                      onTap: _onTapProfile,
                      leading: SvgPicture.asset(AssetsConst.svgPerson),
                      title: Text(
                        S.of(context).myProfile,
                        style: textStyle,
                      ),
                    ),
                    _buildLanguageExpansion(context, textStyle),
                    const Spacer(),
                    ListTile(
                      key: const ValueKey('logoutButton'),
                      onTap: _onTapSignOut,
                      leading: SvgPicture.asset(AssetsConst.svgLogout),
                      title: Text(
                        S.of(context).signOut,
                        style: textStyle,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageExpansion(BuildContext context, TextStyle textStyle) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: Obx(
        () => ExpansionTile(
          key: const ValueKey('language'),
          leading: SvgPicture.asset(AssetsConst.icLanguage),
          title: Text(
            S.of(context).language,
            style: textStyle,
          ),
          children: _buildSelectLanguages(context, controller.langSelected),
          iconColor: Theme.of(context).primaryColor,
        ),
      ),
    );
  }

  List<Widget> _buildSelectLanguages(
      BuildContext context, InputItem selectItem) {
    List<Widget> languageWidgetList = <Widget>[];
    for (var item in controller.languageSupports) {
      bool isSelected = (item.value == selectItem.value);
      TextStyle? textNormalStyle = const TextStyle(
        color: AppColors.grey600,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      );
      TextStyle? textDisable = const TextStyle(
        color: AppColors.grey200,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      );
      TextStyle? textSelectedStyle = textNormalStyle;
      languageWidgetList.add(
        InkWell(
          onTap: () {
            controller.changeLanguage(context, item);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.green600 : Colors.transparent,
            ),
            child: Row(
              children: [
                if (item.icon != null)
                  SvgPicture.asset(
                    item.icon!,
                    height: 24,
                  ),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    item.displayLabel,
                    style: (item.isDisable ?? false)
                        ? textDisable
                        : isSelected
                            ? textSelectedStyle
                            : textNormalStyle,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    return languageWidgetList;
  }
}
