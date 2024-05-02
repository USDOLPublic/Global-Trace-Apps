import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:usdol/app/core.dart';

class EditProductProfile extends GetView<EditProfileController> {
  const EditProductProfile({
    super.key,
    required this.onLocationChanged,
  });

  final void Function() onLocationChanged;

  Future<void> _checkOarIdOnClicked(BuildContext context) async {
    KeyboardUtils.forceHideKeyboard(context);
    await controller.checkFacilitiesOarId(
      controller.oarIdController.text.trim(),
    );
  }

  Future<void> _onTapRegisterOarId(BuildContext context) async {
    KeyboardUtils.forceHideKeyboard(context);
    String viewId = const Uuid().v1();
    final dynamic result = await Get.toNamed<dynamic>(
      Routes.registerOarIByTag(viewId),
    );
    if (result != null && result is OarIdResult) {
      if (result.inputNewInfo == true) {
        await Future.delayed(const Duration(milliseconds: 300), (){});
        _onTapRegisterOarId(context);
      } else {
        await controller.updateOarIdValidated(result);
        SnackBars.complete(
          message: S.current.osIdRegistered,
        ).show(duration: 5000);
      }
    }
  }

  void _onChangeDuration(InputItem? duration) {
    if (duration != null) {
      controller.durationSelected = duration;
      controller.checkFormValidation();
    }
  }

  void _onChangeTimeForReconciliation(DateTime? dateTime) {
    if (dateTime != null) {
      controller.reconciliationDateTime = dateTime;
      controller.checkFormValidation();
    }
  }

  void _onChangeCertification(InputItem? certification) {
    if (certification != null) {
      controller.certificationSelected = certification;
      controller.checkFormValidation();
    }
  }

  void _onChangeChain(InputItem? chain) {
    if (chain != null) {
      controller.chainSelected = chain;
      controller.checkChainDetail();
      controller.checkFormValidation();
    }
  }

  void _onGoodsChanged(List<InputItem>? selected) {
    if (selected != null) {
      controller.goodsSelected = selected;
    } else {
      controller.goodsSelected = [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).information,
          style: AppTextStyles.title(),
        ),
        const SizedBox(
          height: 12,
        ),
        TextFieldInput(
          key: const ValueKey('businessRegisterNumber'),
          labelText: S.of(context).businessRegisterNumber,
          inputController: controller.registerNumberController,
          validator: Validator.businessValidation,
          tagId: "business",
        ),
        const SizedBox(
          height: 8,
        ),
        _buildOarIdInput(context),
        Obx(
          () => Visibility(
            visible: controller.type == EditProfileType.fromOnboard,
            child: Padding(
              padding: EdgeInsets.only(
                  bottom:
                      controller.type == EditProfileType.fromOnboard ? 12 : 8),
              child: GestureDetector(
                onTap: () => _onTapRegisterOarId(context),
                child: RichText(
                  text: TextSpan(
                    text: controller.checkOarIdType == CheckOarIdType.fail
                        ? S.of(context).osIdDoesNotExist
                        : S.of(context).haventOsId,
                    style: TextStyle(
                      color: controller.checkOarIdType == CheckOarIdType.fail
                          ? AppColors.red
                          : AppColors.grey300,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                    children: [
                      TextSpan(
                        text: S.of(context).clickHere,
                        style: const TextStyle(
                          color: AppColors.green700,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          decoration: TextDecoration.underline,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Obx(
          () => Visibility(
            visible: controller.checkOarIdType == CheckOarIdType.skip ||
                controller.checkOarIdType == CheckOarIdType.success,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: TextFieldInput(
                key: const ValueKey('businessName'),
                enabled: false,
                labelText: S.of(context).businessName,
                focusNode: controller.nameNode,
                inputController: controller.nameController,
                validator: Validator.businessNameValidation,
                tagId: "name",
              ),
            ),
          ),
        ),
        Obx(
          () {
            bool isVisible = controller.checkOarIdType == CheckOarIdType.skip ||
                controller.checkOarIdType == CheckOarIdType.success;
            bool isDisableEdit = controller.locationInputController.isValid();
            return Visibility(
              visible: isVisible,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: LocationInputView(
                  viewId: 'edit-product-profile',
                  locationController: controller.locationInputController,
                  onChanged: onLocationChanged,
                  isDisable: isDisableEdit,
                ),
              ),
            );
          },
        ),
        Obx(
          () => Visibility(
            visible: controller.checkOarIdType == CheckOarIdType.skip ||
                controller.checkOarIdType == CheckOarIdType.success,
            child: TextFieldInput(
              key: const ValueKey("streetAddressInput"),
              labelText: S.of(context).streetAddress,
              inputController: controller.addressController,
              focusNode: controller.addressNode,
              textInputAction: TextInputAction.done,
              tagId: "street",
              enabled: false,
            ),
          ),
        ),
        Padding(
          key: const ValueKey("goodsDropdown"),
          padding: const EdgeInsets.only(top: 8),
          child: Obx(
            () => MultiDropdownInput(
              itemList: controller.commodities,
              selected: controller.goodsSelected,
              label: S.of(context).goods,
              hint: S.of(context).goods,
              onChanged: _onGoodsChanged,
              isDisabled: controller.type == EditProfileType.fromProfile,
            ),
          ),
        ),
        //
        _buildCertificationWidget(context),
        _buildChainOfCustody(context),
      ],
    );
  }

  Widget _buildOarIdInput(BuildContext context) {
    return Obx(
      () {
        return Padding(
          padding: EdgeInsets.only(
              bottom: controller.type == EditProfileType.fromOnboard ? 4 : 8),
          child: TextFieldInput(
            key: const ValueKey('oarID'),
            labelText: S.of(context).osId,
            inputController: controller.oarIdController,
            focusNode: controller.oarIdNode,
            tagId: "oarId",
            enabled: controller.type == EditProfileType.fromOnboard,
            inputBorderColor: controller.checkOarIdType == CheckOarIdType.fail
                ? AppColors.red
                : controller.checkOarIdType == CheckOarIdType.success
                    ? AppColors.green
                    : null,
            onChanged: (text) {
              if (controller.checkOarIdType == CheckOarIdType.success ||
                  controller.checkOarIdType == CheckOarIdType.fail) {
                controller.checkOarIdType = CheckOarIdType.none;
                controller.resetOarId();
              }
            },
            suffixIcon: _buildOarIdSuffixIcon(context),
            onFieldSubmitted: (_) {
              controller.addressNode.requestFocus();
              return null;
            },
          ),
        );
      },
    );
  }

  Widget? _buildOarIdSuffixIcon(BuildContext context) {
    if (controller.checkOarIdType == CheckOarIdType.none) {
      return IconButton(
          onPressed: () => _checkOarIdOnClicked(context),
          icon: const Icon(Icons.search));
    }
    if (controller.checkOarIdType == CheckOarIdType.skip) {
      return null;
    }
    if (controller.checkOarIdType == CheckOarIdType.checking) {
      return const SizedBox(
        width: 24,
        height: 24,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return SizedBox(
      width: 24,
      height: 24,
      child: Center(
        child: SvgPicture.asset(
          controller.checkOarIdType == CheckOarIdType.fail
              ? AssetsConst.icError
              : AssetsConst.icCheckCircle,
          colorFilter: ColorFilter.mode(
            controller.checkOarIdType == CheckOarIdType.fail
                ? AppColors.red
                : AppColors.green,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }

  Widget _buildCertificationWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (controller.type != EditProfileType.fromOnboard)
          Padding(
            padding: const EdgeInsets.only(top: 24.0),
            child: Text(
              S.of(context).certificationAndCustodyModel,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: AppColors.green800,
              ),
            ),
          ),
        const SizedBox(
          height: 12,
        ),
        Obx(
          () => DropdownInput(
            key: const ValueKey("certificationDropdown"),
            itemList: profileCertificationsDef,
            selected: controller.certificationSelected,
            label: S.of(context).certification,
            hint: S.of(context).certification,
            onChanged: _onChangeCertification,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
      ],
    );
  }

  Widget _buildChainOfCustody(BuildContext context) {
    return Column(
      children: [
        controller.type == EditProfileType.fromOnboard
            ? Obx(() => (controller.isMassBalanceProfile)
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Text(
                        controller.chainSelected?.displayLabel ?? '',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppColors.green800,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                : const SizedBox.shrink())
            : Obx(
                () => DropdownInput(
                  key: const ValueKey("chainDropdown"),
                  itemList: chainOfCustodyDef,
                  selected: controller.chainSelected,
                  label: S.of(context).chainOfCustody,
                  hint: S.of(context).chainOfCustody,
                  onChanged: _onChangeChain,
                  isDisabled: true,
                ),
              ),
        Obx(() {
          if (controller.isMassBalanceProfile) {
            return Column(
              children: [
                const SizedBox(
                  height: 8,
                ),
                Obx(
                  () => DateTimeInput(
                    key: const ValueKey("startDateTimePicker"),
                    label: S.of(context).reconciliationWindowStartDate,
                    hint: S.of(context).reconciliationWindowStartDate,
                    selected: controller.reconciliationDateTime,
                    isAllowingGreaterThanToday: false,
                    isOnlyDate: true,
                    formatDateTime: AppProperties.dateFormatDefault,
                    onChanged: _onChangeTimeForReconciliation,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Obx(
                  () => DropdownInput(
                    key: const ValueKey("durationDropdown"),
                    itemList: reconciliationDurationsDef,
                    selected: controller.durationSelected,
                    label: S.of(context).reconciliationWindowDuration,
                    hint: S.of(context).reconciliationWindowDuration,
                    onChanged: _onChangeDuration,
                  ),
                )
              ],
            );
          }
          return const SizedBox.shrink();
        }),
      ],
    );
  }
}
