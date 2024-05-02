import 'package:flutter/material.dart';
import 'package:usdol/app/core.dart';

class ManageBusinessView extends GetView<ManageBusinessController> {
  const ManageBusinessView({Key? key}) : super(key: key);

  Future<void> _onAddPartner(PartnerArgument? argument) async {
    final dynamic result =
        await Get.toNamed<dynamic>(Routes.addPartner, arguments: argument);
    if (result != null && result is bool && result) {
      var process = ProcessingDialog.show();
      await controller.fetchBusinessPartner();
      process.hide();
      SnackBars.complete(message: S.current.addSuccess(argument?.name ?? ''))
          .show(duration: 5000);
      controller.updateCacheData();
    }
  }

  Future<void> _onDeletePartner(FacilityRespModel? partner) async {
    if (partner != null) {
      await controller.deletePartner(partner);
      controller.updateCacheData();
    }
  }

  void _onTapButtonNext() {
    if (controller.enableNextButton) {
      Get.back<bool>(result: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(
        title: S.of(context).manageBusinessPartners,
        onBack: () => Get.back<bool>(result: true),
      ),
      body: SingleChildScrollView(
        key: const ValueKey('manageBusinessScroll'),
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 24,
          ),
          child: Obx(
            () => ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: controller.partners.length,
              itemBuilder: (_, index) => ManageBusinessItem(
                key: ValueKey('managePartner' + index.toString()),
                partners: controller.partners[index],
                onTap: _onAddPartner,
                onDeleteFacility: _onDeletePartner,
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar:
          controller.isFromOnboardScreen ? _buildBottomAction(context) : null,
    );
  }

  Widget _buildBottomAction(BuildContext context) {
    return BottomAction(
      childContent: Obx(
        () {
          bool enable = controller.enableNextButton;
          ButtonStyle btnStyle = ElevatedBtnStyle.disable();
          if (enable) {
            btnStyle = ElevatedBtnStyle.enable();
          }
          return ElevatedButton(
            style: btnStyle,
            onPressed: _onTapButtonNext,
            child: Text(S.of(context).next),
          );
        },
      ),
    );
  }
}
