import 'package:flutter/material.dart';
import 'package:usdol/app/core.dart';

class HomeView<T extends HomeController> extends GetView<T> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.initTutorial(context);
    return Scaffold(
      appBar: AppBar(
        title: InkWell(
          onLongPress: BuildConfig().isDebug ? showAppVersion : null,
          child: Text(
            S.of(context).home,
            style: const TextStyle(color: AppColors.grey600),
          ),
        ),
        elevation: 0,
        actions: [
          MenuEndDrawerIcon(
            key: controller.tutorialController?.getKeyOfStepByKey(
              TutorialStep.drawer,
            ),
            scaffoldKey: controller.scaffoldKey,
          )
        ],
      ),
      key: controller.scaffoldKey,
      endDrawerEnableOpenDragGesture: true,
      endDrawer: HomeDrawerView<T>(),
      body: _buildHomePage(context),
    );
  }

  Widget _buildHomePage(BuildContext context) {
    if (controller.userInfo.isMobileSupported()) {
      if (controller.userInfo.isProductUser()) {
        return const HomeProductView();
      } else {
        return const HomeLaborView();
      }
    } else {
      return EmptyPage(
        text: S.of(context).notSupportBusiness,
      );
    }
  }
}
