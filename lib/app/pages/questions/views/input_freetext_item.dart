import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:usdol/app/core.dart';

class InputFreeTextItem extends GetView<InputFreeTextController> {
  final String? id;

  @override
  String? get tag => id;

  const InputFreeTextItem({Key? key, this.id}) : super(key: key);

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
          child: TextFieldInput(
            key: ValueKey(controller.question.id),
            onChanged: (answer) => controller.onChangeAnswer(),
            inputController: controller.textController,
            validator: controller.inputValidation,
            hintText: controller.getHintText(),
            tagId: id,
          ),
        ),
      ],
    );
  }
}
