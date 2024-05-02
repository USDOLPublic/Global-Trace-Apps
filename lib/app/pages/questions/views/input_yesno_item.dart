import 'package:flutter/material.dart';
import 'package:usdol/app/core.dart';

class InputYesNoItem extends GetView<InputYesNoController> {
  final String? id;

  @override
  String? get tag => id;

  const InputYesNoItem({Key? key, this.id}) : super(key: key);

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
        Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: Row(
            children: [
              _buildButton(controller.respondOptions?.first),
              const SizedBox(
                width: 8,
              ),
              _buildButton(controller.respondOptions?.last),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildButton(SaqQuestionResponse? item) {
    if (item == null) {
      return const SizedBox.shrink();
    }
    return Obx(
      () {
        final isSelected = controller.selectedTab?.id == item.id;
        return Expanded(
          child: InkWell(
            key: ValueKey(controller.question.id + item.id),
            onTap: () => controller.onChangeTab(item),
            child: Container(
              decoration: BoxDecoration(
                color: isSelected ? AppColors.green600 : AppColors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.green700),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
              child: Text(
                item.translation?.value ?? '',
                style: const TextStyle(
                  color: AppColors.grey600,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
