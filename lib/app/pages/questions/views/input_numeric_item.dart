import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:usdol/app/core.dart';

class InputNumericItem extends GetView<InputNumericController> {
  final String? id;

  @override
  String? get tag => id;

  const InputNumericItem({Key? key, this.id}) : super(key: key);

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
          itemCount: controller.respondOptions?.length,
          itemBuilder: (_, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: TextFieldInput(
                    key: ValueKey(controller.question.id + (controller.respondOptions?[index].id ?? "")),
                    labelText: controller.respondOptions?[index].translation?.value,
                    onChanged: (answer) => controller.onChangeAnswer(),
                    keyboardType: TextInputType.number,
                    inputController: controller.textControllers[index],
                    inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                    tagId: (id ?? '') + index.toString(),
                    validator: controller.numericValidation,
                  ),
                ),
              ],
            );
          },
        )
      ],
    );
  }
}
