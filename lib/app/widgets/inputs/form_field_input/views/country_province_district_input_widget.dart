import 'package:flutter/material.dart';
import 'package:usdol/app/core.dart';

class CountryProvinceDistrictInputWidget
    extends GetView<CountryProvinceDistrictInputController> {
  const CountryProvinceDistrictInputWidget({Key? key, this.id})
      : super(key: key);
  final String? id;
  @override
  String? get tag => id;

  @override
  Widget build(BuildContext context) {
    return LocationInputView(
      viewId: 'country-province-district-$id',
      locationController: controller.locationController,
      onChanged: controller.onChanged,
    );
  }
}
