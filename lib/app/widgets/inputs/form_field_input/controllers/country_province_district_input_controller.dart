import 'package:usdol/app/core.dart';

class CountryProvinceDistrictInputController extends FormFieldInputController {
  CountryProvinceDistrictInputController({
    required super.definitionAttribute,
    required super.onChangedValue,
  });

  final LocationInputController locationController = LocationInputController();
  @override
  AttributeRequest getValue() {
    if (locationController.countrySelected != null) {
      return super.getValue()
        ..setValue(
          value: {
            "countryId": locationController.countrySelected?.value,
            "provinceId": locationController.provinceSelected?.value,
            "districtId": locationController.districtSelected?.value,
          },
        );
    } else {
      return super.getValue();
    }
  }

  @override
  bool isValid() {
    return locationController.isValid() || isOptional();
  }

  void onChanged() {
    onChangedValue?.call();
  }

  @override
  void reset() {
    locationController.reset();
  }
}
