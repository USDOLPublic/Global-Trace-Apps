import 'package:flutter/material.dart';
import 'package:usdol/app/core.dart';

class AddOutPutProductView extends GetView<OutputProductListController> {
  const AddOutPutProductView({super.key});

  void _addOutputProductOnClicked(BuildContext context) async {
    KeyboardUtils.forceHideKeyboard(context);
    controller.addOutputProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (!controller.formDefinitionLoaded) {
        return const SizedBox.shrink();
      }
      return _buildOutputForm(context);
    });
  }

  Widget _buildOutputForm(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.k4B4B45.withOpacity(0.06),
            spreadRadius: 20,
            blurRadius: 7,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(AppProperties.contentMargin),
      child: Column(
        children: [
          Form(
            key: controller.formGlobalKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: controller.buildInputForm(),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Obx(
              () => ElevatedButton(
                key: const ValueKey('addOutputProduct'),
                style: ElevatedBtnStyle.enable(),
                onPressed: controller.enableAddOutputButton
                    ? () => _addOutputProductOnClicked(context)
                    : null,
                child: Text(S.of(context).addOutputProduct),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
