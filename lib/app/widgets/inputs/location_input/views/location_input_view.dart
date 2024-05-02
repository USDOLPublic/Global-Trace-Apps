import 'package:flutter/material.dart';
import 'package:usdol/app/core.dart';

class LocationInputView extends GetView<LocationInputController> {
  LocationInputView({
    super.key,
    required this.viewId,
    this.isDisable = false,
    this.locationController,
    this.onChanged,
  }) {
    if (!Get.isRegistered<LocationInputController>(tag: viewId)) {
      Get.put(LocationInputController(), tag: viewId);
    }
    controller.onInit();
  }

  final String viewId;
  final bool isDisable;
  final LocationInputController? locationController;
  final void Function()? onChanged;

  @override
  String? get tag => (viewId);

  @override
  LocationInputController get controller {
    if (locationController == null) {
      return Get.find<LocationInputController>(tag: tag);
    } else {
      return locationController!;
    }
  }

  void _onCountryChange(InputItem? country) {
    controller.countrySelected = country;
    onChanged?.call();
  }

  void _onProviderStateChange(InputItem? province) {
    controller.provinceSelected = province;
    onChanged?.call();
  }

  void _onDistrictChange(InputItem? district) {
    controller.districtSelected = district;
    onChanged?.call();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(
          () => DropdownInput(
            key: const ValueKey('countryDropdown'),
            itemList: controller.countries,
            selected: controller.countrySelected,
            label: S.of(context).country,
            hint: S.of(context).country,
            onChanged: _onCountryChange,
            isDisabled: isDisable,
            verticalMargin: 0,
          ),
        ),
        Obx(() {
          bool isVisible = controller.countrySelected != null;
          return Visibility(
            visible: (isVisible || isDisable) &&
                controller.countrySelected?.value != otherCountry.id,
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: DropdownInput(
                key: const ValueKey('provideDropdown'),
                itemList: controller.providerState,
                selected: controller.provinceSelected,
                label: S.of(context).provinceState,
                hint: S.of(context).provinceState,
                onChanged: _onProviderStateChange,
                isDisabled: isDisable,
              ),
            ),
          );
        }),
        Obx(() {
          bool isVisible = controller.provinceSelected != null &&
              controller.countrySelected != null;
          return Visibility(
            visible: (isVisible || isDisable) &&
                controller.countrySelected?.value != otherCountry.id,
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: DropdownInput(
                key: const ValueKey('districtDropdown'),
                itemList: controller.districts,
                selected: controller.districtSelected,
                label: S.of(context).district,
                hint: S.of(context).district,
                onChanged: _onDistrictChange,
                isDisabled: isDisable,
                verticalMargin: 0,
              ),
            ),
          );
        }),
      ],
    );
  }
}
