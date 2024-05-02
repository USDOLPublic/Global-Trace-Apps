import 'package:flutter/material.dart';
import 'package:usdol/app/core.dart';

class AddChildPartnerView extends GetView<AddChildPartnerController> {
  const AddChildPartnerView({Key? key}) : super(key: key);

  Future<void> _onTapButtonAdd(bool enable, BuildContext context) async {
    final FocusScopeNode currentScope = FocusScope.of(context);
    if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
      FocusManager.instance.primaryFocus!.unfocus();
    }
    if (enable) {
      final result = await controller.onTapButtonAdd();
      Get.back<String>(result: result);
    }
  }

  void _onLocationChange() {
    controller.checkFormValidation();
  }

  void _onTypeChange(InputItem? type) {
    if (type != null && !(type.isDisable ?? false)) {
      controller.typeSelected = type;
      controller.checkFormValidation();
    }
  }

  void _onChooseSuggestFacility(FacilityRespModel facility) {
    controller.chooseFacility(facility);
    controller.checkFormValidation();
  }

  void _onChangeSearch(String text) {
    if (text.isEmpty || text.trim().isEmpty) {
      controller.facilityController.text = '';
      controller.clearFacility();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(
        title: S.of(context).addBusinessPartner,
        hasBackButton: false,
        hasCloseButton: true,
      ),
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        controller: controller.scrollController,
        physics: const BouncingScrollPhysics(),
        key: const ValueKey('addPartnerChildScroll'),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Obx(
            () => Form(
              key: controller.formKey,
              onChanged: () => controller.checkFormValidation(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SearchInput<FacilityRespModel>(
                    searchController: controller.facilityController,
                    searchFocus: controller.facilityNameNode,
                    labelText: controller.partnerArgument.suggestHint ?? "",
                    suggestionsCallback: (pattern) async {
                      return await controller.loadListFacility(pattern);
                    },
                    itemBuilder: (context, facility) {
                      return ListTile(
                        title: FacilityInfoWidget(
                          facility: facility,
                        ),
                      );
                    },
                    onSuggestionSelected: _onChooseSuggestFacility,
                    onChanged: _onChangeSearch,
                  ),
                  const Divider(
                    height: 32,
                    color: AppColors.grey100,
                  ),
                  Obx(
                    () => PartnerContactInputView(
                      formId: 'business-partner',
                      partnerTitle: S.of(context).businessPartnerContact,
                      firstNameController: controller.firstNameController,
                      lastNameController: controller.lastNameController,
                      emailController: controller.emailController,
                      phoneController: controller.phoneController,
                      isEnableEdit: controller.facilitySelected == null,
                    ),
                  ),
                  _buildInformation(context),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAction(
        childContent: Obx(
          () {
            bool enable = controller.enableNextButton;
            ButtonStyle btnStyle = ElevatedBtnStyle.disable();
            if (enable) {
              btnStyle = ElevatedBtnStyle.enable();
            }
            return ElevatedButton(
              key: const ValueKey("addChildPartnerChildButton"),
              style: btnStyle,
              onPressed: () => _onTapButtonAdd(enable, context),
              child: Text(S.of(context).add),
            );
          },
        ),
      ),
    );
  }

  Widget _buildInformation(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 24,
        ),
        Text(
          S.of(context).businessPartnerInformation,
          style: AppTextStyles.title(),
        ),
        const SizedBox(
          height: 12,
        ),
        TextFieldInput(
          key: const ValueKey('nameChildInput'),
          labelText: S.of(context).businessName,
          inputController: controller.businessNameController,
          validator: Validator.businessNameValidation,
          tagId: "nameChild",
          enabled: controller.facilitySelected == null,
          onFieldSubmitted: (_) {
            controller.addressFocus.requestFocus();
            return null;
          },
        ),
        const SizedBox(
          height: 8,
        ),
        Padding(
          key: const ValueKey("partnerTypeDropdown"),
          padding: const EdgeInsets.only(bottom: 8),
          child: Obx(
            () => DropdownInput(
              itemList: controller.typesPartner,
              selected: controller.typeSelected,
              label: S.of(context).type,
              hint: S.of(context).type,
              onChanged: _onTypeChange,
              isDisabled: controller.facilitySelected != null,
            ),
          ),
        ),
        Obx(
          () {
            bool isDisabled = controller.facilitySelected != null;
            bool isNonFarm = controller.facilitySelected?.isNonFarm ?? false;
            return Visibility(
              visible: !isNonFarm || isDisabled,
              child: Padding(
                key: const ValueKey("countryChildDropdown"),
                padding: const EdgeInsets.only(bottom: 8),
                child: LocationInputView(
                  viewId: 'add-child-partner-view',
                  locationController: controller.locationInputController,
                  onChanged: _onLocationChange,
                  isDisable: isDisabled,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
