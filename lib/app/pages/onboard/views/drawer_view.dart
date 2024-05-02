import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:usdol/app/core.dart';

class DrawerView extends GetView<OnboardController> {
  final UserModel userInfo;
  final Function? onTapProfile;
  final Function? onTapSignOut;

  const DrawerView(
      {Key? key, required this.userInfo, this.onTapSignOut, this.onTapProfile})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: AppColors.green800,
    );
    return Container(
      width: Get.width * 0.8,
      color: AppColors.grey100,
      child: SafeArea(
        minimum: const EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => Get.back<void>(),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                child: SvgPicture.asset(AssetsConst.closeButton),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24),
              child: _buildLanguageExpansion(context, textStyle),
            ),
            const Spacer(),
            InkWell(
              key: const ValueKey('logoutButton'),
              onTap: () => onTapSignOut?.call(),
              child: Container(
                width: double.infinity,
                height: 64,
                padding: const EdgeInsets.only(left: 40),
                child: Row(
                  children: [
                    SvgPicture.asset(AssetsConst.svgLogout),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      S.of(context).signOut,
                      style: textStyle,
                    )
                  ],
                ),
              ),
            )
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
