import 'package:usdol/app/core.dart';

class DropdownInputController extends FormFieldInputController {
  DropdownInputController({
    required super.definitionAttribute,
    required super.onChangedValue,
  });

  final _itemSelected = InputItem.empty().obs;
  InputItem get itemSelected => _itemSelected.value;
  set itemSelected(InputItem value) {
    _itemSelected.value = value;
    onChangedValue?.call();
  }

  List<InputItem> options = <InputItem>[];

  @override
  void onInit() {
    super.onInit();
    List<AttributeOptionModel> attributeOption =
        definitionAttribute.attribute?.options ?? [];
    for (var element in attributeOption) {
      options.add(
        InputItem(
            value: element.value ?? '',
            displayLabel: element.getTranslateValue(language: languageCode)),
      );
    }
  }

  @override
  AttributeRequest getValue() {
    if (itemSelected.isNotEmpty()) {
      return super.getValue()..setValue(value: itemSelected.value);
    } else {
      return super.getValue();
    }
  }

  @override
  bool isValid() {
    return itemSelected.isNotEmpty() || isOptional();
  }

  void onChanged() {
    onChangedValue?.call();
  }

  @override
  void reset() {
    itemSelected = InputItem.empty();
  }
}
