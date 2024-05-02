import 'package:usdol/app/core.dart';

class DateInputController extends FormFieldInputController {
  DateInputController({
    required super.definitionAttribute,
    required super.onChangedValue,
  });

  final Rxn<DateTime> _datetimeSelected = Rxn<DateTime>();
  DateTime? get datetimeSelected => _datetimeSelected.value;
  set datetimeSelected(DateTime? value) {
    _datetimeSelected.value = value;
    onChangedValue?.call();
  }

  @override
  AttributeRequest getValue() {
    double? timeInSec;
    if (datetimeSelected != null) {
      timeInSec = (datetimeSelected!.millisecondsSinceEpoch ~/ 1000) * 1.0;
    }
    return super.getValue()..setValue(value: timeInSec);
  }

  @override
  bool isValid() {
    return datetimeSelected != null || isOptional();
  }

  void onChanged() {
    onChangedValue?.call();
  }

  @override
  void reset() {
    datetimeSelected = null;
  }
}
