import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:usdol/app/core.dart';

class ProductListView<T extends ProductListController> extends GetView<T> {
  const ProductListView({super.key});

  void _scanQRCodeOnClicked(BuildContext context) async {
    KeyboardUtils.forceHideKeyboard(context);
    final dynamic result = await Get.toNamed<dynamic>(
      Routes.scanner,
      arguments: S.of(context).productId,
    );
    if (result != null && result is String) {
      controller.productIdController.text = result.toString();
      final isAdded = await controller.addProductById(result);
      if (isAdded) {
        controller.productIdController.text = '';
      }
    }
  }

  void _addManuallyOnClicked() async {
    final dynamic result = await Get.toNamed<dynamic>(
      Routes.addProductManually,
    );
    if (result != null && result is ManualAddedProductRequest) {
      controller.addProductManual(result);
    }
  }

  void _doneOnClicked() {
    Get.back<List<ProductModel>>(
      result: List.from(controller.productList),
    );
  }

  void _addProductOnClicked(String id) async {
    final result = await controller.addProductById(id);
    if (result) {
      controller.productIdController.text = '';
    }
  }

  void _removeProductOnClicked(ProductModel product) {
    controller.removeProduct(product.id);
  }

  void _downloadCerOnClicked(ProductModel product) {
    Get.dialog<void>(
      FileListDialog(
        files: product.getCertifications() ?? [],
        onDownloadFile: (path) async {
          return controller.downloadProductCerFile(path);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(
        title: controller.getPageTitle(context),
        hasBackButton: false,
        hasCloseButton: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          _buildAddProductHeader(context),
          _buildAddProductManuallyButton(context),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  controller.inputProductFormDetails(),
                  Obx(() {
                    List<ProductModel> products = controller.productList;
                    return ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: products.length,
                      padding:
                          const EdgeInsets.all(AppProperties.contentMargin),
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 8),
                      itemBuilder: (context, index) {
                        return ProductItemWidget(
                          onDownloadFile: _downloadCerOnClicked,
                          onRemove: _removeProductOnClicked,
                          product: products[index],
                        );
                      },
                    );
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomAction(context),
    );
  }

  Widget _buildAddProductManuallyButton(BuildContext context) {
    if (!controller.isHavePermissionManualAdd()) {
      return const SizedBox.shrink();
    }
    return Padding(
      padding: const EdgeInsets.only(
        left: AppProperties.contentMargin,
        right: AppProperties.contentMargin,
        top: 8,
      ),
      child: InkWell(
        onTap: _addManuallyOnClicked,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: Text(
                S.of(context).addProductsManually,
                style: const TextStyle(
                  color: AppColors.orange700,
                ),
              ),
            ),
            const SizedBox(width: 8),
            const Icon(
              Icons.arrow_forward_ios,
              size: 12,
              color: AppColors.orange700,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomAction(BuildContext context) {
    return BottomAction(
      childContent: Obx(
        () {
          bool enable = controller.enableDoneButton;
          return ElevatedButton(
            key: const ValueKey('done'),
            style: ElevatedBtnStyle.enable(),
            onPressed: enable ? () => _doneOnClicked() : null,
            child: Text(S.of(context).done),
          );
        },
      ),
    );
  }

  Widget _buildAddProductHeader(BuildContext context) {
    bool isHavePermissionScanProduct = controller.isHavePermissionScanProduct();
    bool isHavePermissionInputProduct =
        controller.isHavePermissionInputProduct();
    if (!isHavePermissionInputProduct && !isHavePermissionScanProduct) {
      return const SizedBox.shrink();
    }
    return Padding(
      padding: const EdgeInsets.only(
        top: AppProperties.contentMargin,
        left: AppProperties.contentMargin,
        right: AppProperties.contentMargin,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: TextFieldInput(
              key: const ValueKey('productId'),
              tagId: "productId",
              labelText: S.of(context).productId,
              inputController: controller.productIdController,
              suffixIcon: isHavePermissionScanProduct
                  ? IconButton(
                      onPressed: () => _scanQRCodeOnClicked(context),
                      icon: SvgPicture.asset(
                        AssetsConst.svgQrcode,
                      ),
                    )
                  : null,
            ),
          ),
          const SizedBox(width: 8),
          Obx(
            () {
              bool isEnable = controller.enableAddButton;
              return ElevatedButton(
                key: const ValueKey('addProduct'),
                onPressed: isEnable
                    ? () => _addProductOnClicked(
                          controller.productIdInput,
                        )
                    : null,
                child: Text(S.of(context).add),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(80, 60),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
