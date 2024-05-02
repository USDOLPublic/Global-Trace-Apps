import 'package:flutter/material.dart';
import 'package:usdol/app/core.dart';

class AddProductManuallyView extends GetView<AddProductManuallyController> {
  const AddProductManuallyView({super.key});

  void _saveOnClicked(BuildContext context) async {
    KeyboardUtils.forceHideKeyboard(context);
    var result = controller.getProductAdded();
    Get.back<dynamic>(result: result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(
        title: S.of(context).addProductsManually,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        key: const ValueKey('singleChildScrollView'),
        child: _buildInputForm(context),
      ),
      bottomNavigationBar: _buildBottomAction(context),
    );
  }

  Widget _buildBottomAction(BuildContext context) {
    return BottomAction(
      childContent: Obx(
        () {
          bool enable = controller.enableSaveButton;
          return ElevatedButton(
            key: const ValueKey('add'),
            style: ElevatedBtnStyle.enable(),
            onPressed: enable ? () => _saveOnClicked(context) : null,
            child: Text(S.of(context).add),
          );
        },
      ),
    );
  }

  Widget _buildInputForm(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: AppProperties.contentMargin,
      ),
      child: Obx(
        () => controller.formDefinitionLoaded
            ? Form(
                key: controller.formGlobalKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: controller.buildInputForm(context),
                ),
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}
