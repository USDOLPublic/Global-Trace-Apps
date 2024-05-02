import 'package:flutter/material.dart';
import 'package:usdol/app/core.dart';

class InputCheckboxItem extends GetView<InputCheckboxController> {
  final String? id;

  @override
  String? get tag => id;

  const InputCheckboxItem({Key? key, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const questionStyle = TextStyle(
      color: AppColors.green800,
      fontSize: 14,
      fontWeight: FontWeight.w400,
    );

    return Column(
      children: [
        const SizedBox(
          height: 24,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              controller.index + '. ',
              style: questionStyle,
            ),
            Expanded(
              child: Text(
                controller.question.title.value,
                style: questionStyle,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.respondOptions?.length ?? 0,
          itemBuilder: (_, index) =>
              _buildCheckboxItem(controller.respondOptions?[index], index),
        )
      ],
    );
  }

  Widget _buildCheckboxItem(SaqQuestionResponse? responseOption, int index) {
    if (responseOption == null) return const SizedBox.shrink();
    TextStyle enableTitleStyle = const TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 14,
      color: AppColors.grey600,
    );
    TextStyle disableTitleStyle =
        enableTitleStyle.apply(color: AppColors.grey300);
    return Obx(() {
      final isSelected = controller.itemSelected
          .where((element) => element.id == responseOption.id)
          .toList()
          .isNotEmpty;
          
      return Column(
        children: [
          InkWell(
            key: ValueKey(controller.question.id + responseOption.id),
            onTap: responseOption.isEnable
                ? () => controller.onChooseItem(responseOption)
                : null,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 18,
                    height: 18,
                    margin: const EdgeInsets.only(right: 9),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: responseOption.isEnable
                              ? AppColors.green700
                              : AppColors.grey300),
                      borderRadius: BorderRadius.circular(3),
                      color: isSelected ? AppColors.green800 : AppColors.white,
                    ),
                    child: isSelected
                        ? const Icon(
                            Icons.check,
                            size: 16,
                            color: AppColors.white,
                          )
                        : const SizedBox(),
                  ),
                  Expanded(
                    child: Text(
                      responseOption.translation?.value ?? '',
                      style: responseOption.isEnable
                          ? enableTitleStyle
                          : disableTitleStyle,
                    ),
                  )
                ],
              ),
            ),
          ),
          if ((responseOption.isOtherResponse()) && isSelected)
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: TextFieldInput(
                enabled: isSelected,
                onChanged: (answer) =>
                    controller.onChooseItem(responseOption, isInput: true),
                inputController: controller.textController,
                hintText: responseOption.option ?? "",
              ),
            ),
        ],
      );
    });
  }
}
