import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:usdol/app/core.dart';

class RegisterOarIdView extends GetView<RegisterOarIdController> {
  const RegisterOarIdView({Key? key, this.tagId}) : super(key: key);

  final String? tagId;
  @override
  String? get tag => tagId;

  void _onLocationChange() {
    controller.checkFormValidation();
  }

  void _onTapButtonRequestOarId(bool enable) {
    if (enable) {
      controller.searchOarId();
    }
  }

  void _onTapButtonDone() {
    controller.onTapButtonDone();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(
        title: S.of(context).registerOsID,
        hasCloseButton: true,
        hasBackButton: false,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              color: AppColors.white,
              child: Form(
                key: controller.formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onChanged: () => controller.checkFormValidation(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.of(context).businessInformation,
                      style: AppTextStyles.title(),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Obx(
                      () => TextFieldInput(
                        key: const ValueKey('businessInput'),
                        labelText: S.of(context).businessName,
                        inputController: controller.businessController,
                        tagId: "businessNameOar",
                        onFieldSubmitted: (_) {
                          controller.addressNode.requestFocus();
                          return null;
                        },
                        enabled: controller.enableRequestForm,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Obx(
                      () => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: LocationInputView(
                          viewId: 'register-oar-id',
                          locationController:
                              controller.locationInputController,
                          onChanged: _onLocationChange,
                          isDisable: !controller.enableRequestForm,
                        ),
                      ),
                    ),
                    Obx(
                      () => TextFieldInput(
                        key: const ValueKey('addressInput'),
                        labelText: S.of(context).address,
                        inputController: controller.addressController,
                        textInputAction: TextInputAction.done,
                        focusNode: controller.addressNode,
                        onFieldSubmitted: (_) {
                          if (controller.isFormValidate) {
                            _onTapButtonRequestOarId(true);
                          }
                          return null;
                        },
                        tagId: "addressOar",
                        enabled: controller.enableRequestForm,
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Obx(
                        () {
                          bool enable = controller.enableRequestButton &&
                              controller.enableRequestForm;
                          ButtonStyle btnStyle = ElevatedBtnStyle.disable();
                          if (enable) {
                            btnStyle = ElevatedButton.styleFrom(
                              backgroundColor: AppColors.orange700,
                            );
                          }
                          return ElevatedButton(
                            key: const ValueKey("nextButton"),
                            style: btnStyle,
                            onPressed: () => _onTapButtonRequestOarId(enable),
                            child: Text(S.of(context).requestOsID),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Obx(() {
              if (controller.searchOarIdResp == null) {
                return const SizedBox.shrink();
              } else {
                return _buildSearchResult(context, controller.searchOarIdResp!);
              }
            }),
          ],
        ),
      ),
      bottomNavigationBar: Obx(() {
        if (controller.oarIdSelected == null) {
          return const SizedBox.shrink();
        } else {
          return BottomAction(
            childContent: ElevatedButton(
              key: const ValueKey("doneButton"),
              style: ElevatedBtnStyle.enable(),
              onPressed: _onTapButtonDone,
              child: Text(S.of(context).done),
            ),
          );
        }
      }),
    );
  }

  Widget _buildSearchResult(
      BuildContext context, SearchOarIdRespModel oarIdResp) {
    if (oarIdResp.isErrorData) {
      return Padding(
        padding: const EdgeInsets.all(24),
        child: Row(
          children: [
            const Icon(Icons.warning_rounded, color: AppColors.red),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                S.of(context).bussinessInformationInValid,
                style: const TextStyle(color: AppColors.red),
              ),
            ),
          ],
        ),
      );
    }

    List<OarIdResult> oarIds = <OarIdResult>[];
    if (oarIdResp.isMatched) {
      oarIds = oarIdResp.getMatchedOarId();
    } else if (oarIdResp.matches != null && oarIdResp.matches!.isNotEmpty) {
      oarIds = oarIdResp.matches!;
    } else if (oarIdResp.isNewFacility && controller.oarIdReq != null) {
      OarIdResult oarIdRs =
          oarIdResp.getOarIdResultFromRequest(controller.oarIdReq!);
      oarIds.add(oarIdRs);
    }

    List<Widget> oarIdItems = <Widget>[];
    for (OarIdResult oarId in oarIds) {
      oarIdItems.add(
        Obx(
          () => SearchOarIdResultItem(
            key: ValueKey(oarId.oarId ?? ''),
            oarIDRespModel: oarId,
            isSelectedItem: controller.oarIdSelected?.oarId == oarId.oarId,
            onTap: (OarIdResult oarId) {
              controller.oarIdSelected = oarId;
            },
            isEnableSelection: !controller.isConfirmingOarID,
          ),
        ),
      );
    }

    if (!controller.isConfirmingOarID &&
        (oarIdResp.isMatched || oarIdResp.isPotential)) {
      oarIdItems.add(
        _buildNotMeItem(
          context,
          oarIdResp.isMatched
              ? S.of(context).notMePleaseEnterNewOsId
              : S.of(context).notMePleaseRegisterOsIdAbove,
        ),
      );
    }
    //
    TextStyle hintOfStatusStyle = const TextStyle(
      color: AppColors.grey600,
      fontSize: 14,
      fontWeight: FontWeight.w400,
    );

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          (oarIdResp.isNewFacility ||
                  (oarIdResp.isPotential && controller.isConfirmingOarID))
              ? Text(
                  S.of(context).newFacilityHasRegitered,
                  style: hintOfStatusStyle,
                )
              : RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    text: S.of(context).weFoundSimilarResultsToDetails,
                    style: hintOfStatusStyle,
                  ),
                ),
          const SizedBox(
            height: 24,
          ),
          ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: oarIdItems,
          ),
        ],
      ),
    );
  }

  Widget _buildNotMeItem(BuildContext context, String hint) {
    return GestureDetector(
      key: const ValueKey('notMe'),
      onTap: () {
        if (controller.oarIdReq != null) {
          controller.oarIdSelected =
              OarIdResult.fromRequestCreate(controller.oarIdReq!);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 24,
                  height: 24,
                  child: SvgPicture.asset(
                    (controller.oarIdSelected?.isOtherOption() ?? true)
                        ? AssetsConst.radioButtonChecked
                        : AssetsConst.radioButtonUncheck,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: S.of(context).notMe,
                          style: const TextStyle(
                            color: AppColors.grey600,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                          children: [
                            TextSpan(
                              text: hint,
                              style: const TextStyle(
                                color: AppColors.green700,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
