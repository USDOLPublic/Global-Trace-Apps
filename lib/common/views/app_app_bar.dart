import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:usdol/app/core.dart';

class AppAppBar extends AppBar {
  AppAppBar({
    Key? key,
    required String title,
    Function? onBack,
    Function? onClose,
    Widget? closeWidget,
    Widget? backWidget,
    bool hasBackButton = true,
    bool hasCloseButton = false,
  }) : super(
          key: key,
          backgroundColor: AppColors.white,
          flexibleSpace: Container(
            height: Get.height,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SafeArea(
              child: Row(
                children: [
                  hasBackButton
                      ? InkWell(
                          key: const ValueKey('backButton'),
                          splashColor: Colors.transparent,
                          onTap: () {
                            if (onBack != null) {
                              onBack.call();
                            } else {
                              Get.back<void>();
                            }
                          },
                          child: Container(
                            alignment: Alignment.centerLeft,
                            width: 48,
                            child: backWidget ??
                                SvgPicture.asset(
                                  AssetsConst.backButton,
                                  width: 24,
                                ),
                          ),
                        )
                      : const SizedBox(
                          width: 48,
                        ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        color: AppColors.green800,
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  hasCloseButton
                      ? InkWell(
                          key: const ValueKey('closeButton'),
                          splashColor: Colors.transparent,
                          onTap: () {
                            if (onClose != null) {
                              onClose.call();
                            } else {
                              Get.back<void>();
                            }
                          },
                          child: Container(
                            alignment: Alignment.centerRight,
                            width: 48,
                            child: closeWidget ??
                                SvgPicture.asset(
                                  AssetsConst.closeButton,
                                  width: 24,
                                ),
                          ),
                        )
                      : const SizedBox(width: 48),
                ],
              ),
            ),
          ),
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          elevation: 1.6,
          automaticallyImplyLeading: false,
        );
}
