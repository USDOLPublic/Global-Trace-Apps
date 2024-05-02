import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:usdol/app/core.dart';

class AddPartnerView extends GetView<AddPartnerController> {
  const AddPartnerView({Key? key}) : super(key: key);

  void _onTapButtonAdd(bool enable, BuildContext context) async {
    if (enable) {
      final FocusScopeNode currentScope = FocusScope.of(context);
      if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
        FocusManager.instance.primaryFocus!.unfocus();
      }
      bool result = await controller.onTapButtonAdd();
      if (result) {
        Get.back<bool>(result: true);
      }
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

  String? _onBusinessNameSubmitted(BuildContext context) {
    if (controller.inviteType == InvitePartnerType.processing &&
        (controller.formKey.currentState?.validate() ?? false)) {
      bool enable = controller.enableNextButton;
      _onTapButtonAdd(enable, context);
    } else {
      controller.addressFocus.requestFocus();
    }
    return null;
  }

  String? _onAddressSubmitted(BuildContext context) {
    if (controller.inviteType == InvitePartnerType.transporter &&
        (controller.formKey.currentState?.validate() ?? false)) {
      bool enable = controller.enableNextButton;
      _onTapButtonAdd(enable, context);
    }
    return null;
  }

  Future<void> _addBusinessPartnerOnClicked(BuildContext context) async {
    //Hide keyboard
    KeyboardUtils.forceHideKeyboard(context);
    final location = controller.locationInputController;
    final dynamic result = await Get.toNamed<dynamic>(
      Routes.addChildPartner,
      arguments: PartnerArgument(
        type: InvitePartnerType.childBroker,
        name: controller.partnerArgument.registerTitle ?? '',
        suggestHint: S.current.partnerHintTest,
        address: controller.addressController.text,
        country: location.countrySelected?.value,
        province: location.provinceSelected?.value,
        district: location.districtSelected?.value,
      ),
    );
    if (result != null && result is String) {
      SnackBars.error(message: result).show();
    }
  }

  void _onTypeChange(InputItem? type) {
    if (type != null && !(type.isDisable ?? false)) {
      controller.typeSelected = type;
      controller.checkFormValidation();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(
        title: controller.partnerArgument.registerTitle ?? '',
        hasBackButton: false,
        hasCloseButton: true,
      ),
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        controller: controller.scrollController,
        physics: const BouncingScrollPhysics(),
        key: const ValueKey("addPartnerScroll"),
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
                  _buildContact(context),
                  _buildInformation(context),
                  if (controller.partnerArgument.hasChildPartner)
                    _buildBusinessPartnerInformation(context),
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
              key: const ValueKey("addPartnerButton"),
              style: btnStyle,
              onPressed: () => _onTapButtonAdd(enable, context),
              child: Text(S.of(context).add),
            );
          },
        ),
      ),
    );
  }

  Widget _buildContact(BuildContext context) {
    String groupTitle = '';
    switch (controller.inviteType) {
      case InvitePartnerType.broker:
        groupTitle = S.of(context).partnerContact(
              S.of(context).broker,
            );
        break;
      case InvitePartnerType.processing:
        groupTitle = S.of(context).partnerContact(
              S.of(context).facility,
            );
        break;
      case InvitePartnerType.transporter:
        groupTitle = S.of(context).partnerContact(
              S.of(context).transporter,
            );
        break;
      case InvitePartnerType.childBroker:
        groupTitle = S.of(context).businessPartnerContact;
        break;
    }
    return Obx(
      () => PartnerContactInputView(
        formId: controller.partnerArgument.name.toLowerCase(),
        partnerTitle: groupTitle,
        firstNameController: controller.firstNameController,
        lastNameController: controller.lastNameController,
        emailController: controller.emailController,
        phoneController: controller.phoneController,
        isEnableEdit: controller.facilitySelected == null,
      ),
    );
  }

  Widget _buildInformation(BuildContext context) {
    String groupTitle = '';
    switch (controller.inviteType) {
      case InvitePartnerType.broker:
        groupTitle = S.of(context).partnerInformation(
              S.of(context).broker,
            );
        break;
      case InvitePartnerType.processing:
        groupTitle = S.of(context).partnerInformation(
              S.of(context).facility,
            );
        break;
      case InvitePartnerType.transporter:
        groupTitle = S.of(context).partnerInformation(
              S.of(context).transporter,
            );
        break;
      case InvitePartnerType.childBroker:
        groupTitle = S.of(context).businessPartnerInformation;
        break;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 24,
        ),
        Text(
          groupTitle,
          style: AppTextStyles.title(),
        ),
        const SizedBox(
          height: 12,
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: TextFieldInput(
            key: const ValueKey('nameInput'),
            labelText: S.of(context).businessName,
            inputController: controller.businessNameController,
            validator: Validator.businessNameValidation,
            textInputAction:
                controller.inviteType == InvitePartnerType.processing
                    ? TextInputAction.done
                    : TextInputAction.next,
            onFieldSubmitted: (_) => _onBusinessNameSubmitted(context),
            tagId: "name",
            enabled: controller.facilitySelected == null,
          ),
        ),
        if (controller.inviteType == InvitePartnerType.processing)
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
        if (controller.inviteType == InvitePartnerType.broker ||
            (controller.inviteType == InvitePartnerType.processing &&
                controller.facilitySelected != null))
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: TextFieldInput(
              key: const ValueKey('businessRegisterInput'),
              labelText: S.of(context).businessRegisterNumberOptional,
              inputController: controller.businessRegisterController,
              tagId: "business",
              enabled: controller.facilitySelected == null,
            ),
          ),
        if (controller.inviteType == InvitePartnerType.processing &&
            controller.facilitySelected != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: TextFieldInput(
              key: const ValueKey('oarIdInput'),
              labelText: S.of(context).osId,
              initialValue: controller.facilitySelected?.oarId ?? '',
              tagId: "oarIdInput",
              enabled: false,
            ),
          ),
        Obx(
          () {
            bool isVisible = controller.facilitySelected != null ||
                controller.inviteType != InvitePartnerType.processing;
            return Visibility(
              visible: isVisible,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: LocationInputView(
                  viewId: 'add-partner-view',
                  locationController: controller.locationInputController,
                  onChanged: () {
                    controller.checkFormValidation();
                  },
                  isDisable: controller.facilitySelected != null,
                ),
              ),
            );
          },
        ),
        Visibility(
          visible: (controller.inviteType != InvitePartnerType.processing ||
              controller.facilitySelected != null),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: TextFieldInput(
              key: const ValueKey("streetAddressInput"),
              labelText: S.of(context).streetAddressOptional,
              inputController: controller.addressController,
              focusNode: controller.addressFocus,
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) => _onAddressSubmitted(context),
              tagId: "streetChild",
              enabled: controller.facilitySelected == null,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBusinessPartnerInformation(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 24,
        ),
        Text(
          S.of(context).addBusinessPartnerInformation,
          style: AppTextStyles.title(),
        ),
        const SizedBox(
          height: 12,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          child: Obx(
            () {
              return Column(
                children: [
                  ListView.builder(
                    itemCount: controller.childPartner.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(0),
                    itemBuilder: (_, index) {
                      InvitePartnerReq? req = controller.childPartner[index];
                      return Container(
                        alignment: Alignment.center,
                        height: 58,
                        decoration: BoxDecoration(
                          color: req.isEnableEdit
                              ? AppColors.white
                              : AppColors.grey100,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.k555555.withOpacity(0.12),
                              spreadRadius: 1,
                              blurRadius: 1,
                              offset: const Offset(
                                  2, 1), // changes position of shadow
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.only(left: 16),
                        margin: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                req.getBusinessName() ?? '',
                                maxLines: 2,
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: AppColors.green800,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            if (req.isEnableEdit)
                              IconButton(
                                onPressed: () => controller.deleteChildPartner(
                                    controller.childPartner[index]),
                                icon: const Icon(
                                  Icons.close,
                                  color: AppColors.grey300,
                                ),
                              ),
                          ],
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 8),
                  InkWell(
                    key: const ValueKey("addChildPartnerButton"),
                    onTap: () => _addBusinessPartnerOnClicked(context),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 8.0),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            AssetsConst.iconAdd,
                            width: 24,
                            height: 24,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            controller.childPartner.isNotEmpty
                                ? S.of(context).addAnother
                                : S.of(context).addBusinessPartner,
                            style: const TextStyle(
                              color: AppColors.orange700,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
