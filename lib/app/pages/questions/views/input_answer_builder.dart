import 'package:flutter/material.dart';
import 'package:usdol/app/core.dart';

class InputAnswerBuilder extends StatelessWidget {
  final SAQQuestion question;
  final SaqAnswerItem? answerItem;
  final String index;
  final Function(SaqAnswerItem?) onChangeAnswer;

  const InputAnswerBuilder({
    Key? key,
    required this.question,
    required this.answerItem,
    this.index = '0',
    required this.onChangeAnswer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  _buildInputView(context);
  }

  Widget _buildInputView(BuildContext context) {
    switch (question.type) {
      case QuestionType.checkbox:
        Get.put(
          InputCheckboxController(
            question: question,
            answerData: answerItem,
            index: index,
            onChangeResponse: (result) {
              onChangeAnswer.call(result);
            },
          ),
          tag: question.id,
        );
        return InputCheckboxItem(
          id: question.id,
        );
      case QuestionType.radio:
        Get.put(
          InputRadioController(
            question: question,
            respondOptions: question.questionResponses,
            answerData: answerItem,
            index: index,
            onChangeResponse: (result) {
              onChangeAnswer.call(result);
            },
          ),
          tag: question.id,
        );
        return InputRadioItem(
          id: question.id,
        );
      case QuestionType.numeric:
        Get.put(
          InputNumericController(
            question: question,
            respondOptions: question.questionResponses,
            answerData: answerItem,
            index: index,
            onChangeResponse: (result) {
              onChangeAnswer.call(result);
            },
          ),
          tag: question.id,
        );
        return InputNumericItem(
          id: question.id,
        );
      case QuestionType.yesNo:
        Get.put(
          InputYesNoController(
            question: question,
            respondOptions: question.questionResponses,
            answerData: answerItem,
            index: index,
            onChangeResponse: (result) {
              onChangeAnswer.call(result);
            },
          ),
          tag: question.id,
        );
        return InputYesNoItem(
          id: question.id,
        );
      case QuestionType.freeText:
        Get.put(
          InputFreeTextController(
            question: question,
            respondOptions: question.questionResponses,
            answerData: answerItem,
            index: index,
            onChangeResponse: (result) {
              onChangeAnswer.call(result);
            },
          ),
          tag: question.id,
        );
        return InputFreeTextItem(
          id: question.id,
        );
      default:
        return const SizedBox();
    }
  }
}
