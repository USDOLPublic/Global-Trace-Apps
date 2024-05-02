import 'package:flutter/material.dart';
import 'package:usdol/app/core.dart';

class InputRadioItem extends GetView<InputRadioController> {
  final String? id;

  @override
  String? get tag => id;

  const InputRadioItem({Key? key, this.id}) : super(key: key);

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

  Widget _buildCheckboxItem(SaqQuestionResponse? item, int index) {
    if (item == null) {
      return const SizedBox.shrink();
    }
    return Obx(() {
      final isSelected = controller.itemSelected
          .where((element) => element.id == item.id)
          .toList()
          .isNotEmpty;
      return InkWell(
        key: ValueKey(controller.question.id + item.id),
        onTap: () => controller.onChooseItem(item),
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
                  border: Border.all(color: AppColors.green700),
                  borderRadius: BorderRadius.circular(100),
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
                  item.translation?.value ?? '',
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: AppColors.grey600,
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
