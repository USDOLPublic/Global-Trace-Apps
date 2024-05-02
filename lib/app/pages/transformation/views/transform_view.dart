import 'package:flutter/material.dart';
import 'package:usdol/app/core.dart';

class TransformView extends GetView<TransformController> {
  const TransformView({super.key});

  void _saveOnClicked(BuildContext context) async {
    String result = await controller.saveTransformation();
    if (result.isNotEmpty) {
      Get.back<String>(result: result);
    }
  }

  void _addInputProducts(BuildContext context) async {
    final dynamic result = await Get.toNamed<dynamic>(
      Routes.inputProductList,
      arguments: List<ProductModel>.from(controller.inputProducts),
    );
    if (result != null && result is List<ProductModel>) {
      controller.inputProducts = result;
    }
  }

  void _addOutputProducts(BuildContext context) async {
    final dynamic result = await Get.toNamed<dynamic>(
      Routes.outputProductList,
      arguments: List<ProductModel>.from(controller.outputProducts),
    );
    if (result != null && result is List<ProductModel>) {
      controller.outputProducts = result;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(
        title: S.of(context).transformation,
      ),
      body: _buildBody(context),
      bottomNavigationBar: _buildBottomAction(context),
    );
  }

  Widget _buildBottomAction(BuildContext context) {
    return BottomAction(
      childContent: Obx(
        () {
          bool enable = controller.enableSaveButton;
          return ElevatedButton(
            key: const ValueKey('save'),
            style: ElevatedBtnStyle.enable(),
            onPressed: enable ? () => _saveOnClicked(context) : null,
            child: Text(S.of(context).save),
          );
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Obx(() {
      if (!controller.formDefinitionLoaded) {
        return const SizedBox.shrink();
      }
      return SingleChildScrollView(
        key: const ValueKey('singleChildScrollView'),
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (controller.isHaveInputProduct()) ...[
                Obx(
                  () => AddProductButtonWidget(
                    products: controller.inputProducts,
                    addProductOnTap: () => _addInputProducts(context),
                    buttonTile: S.of(context).addInputProduct,
                  ),
                ),
                const SizedBox(height: 16),
              ],
              Obx(
                () => AddProductButtonWidget(
                  products: controller.outputProducts,
                  addProductOnTap: () => _addOutputProducts(context),
                  buttonTile: S.of(context).addOutputProduct,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
