import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:usdol/app/core.dart';

class ViewProfileView extends GetView<ProfileController> {
  const ViewProfileView({Key? key}) : super(key: key);

  void _onTapEditProfile() {
    controller.onTapEditProfile();
  }

  void _onTapDeleteAccount(BuildContext context) {
    Get.dialog<void>(
      BasePopup(
        title: Text(
          S.of(context).deleteAccountConfirm,
          textAlign: TextAlign.left,
          style: AppTextStyles.title().copyWith(
            color: AppColors.grey700,
          ),
        ),
        body: RichText(
          text: TextSpan(
            text: "${S.of(context).note} ",
            style: AppTextStyles.title().copyWith(
              color: Theme.of(context).primaryColor,
            ),
            children: [
              TextSpan(
                text: S.of(context).deleteAccountWarningDetails,
                style: AppTextStyles.bodyRegular().copyWith(
                  color: AppColors.grey600,
                ),
              ),
            ],
          ),
          textAlign: TextAlign.left,
        ),
        isSmallAlert: true,
        actions: [
          Expanded(
            child: ElevatedButton(
              key: const ValueKey("confirmNotice"),
              onPressed: () async {
                Get.back<void>();
                controller.deleteAccount();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
              child: Text(S.of(context).yesDelete),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: OutlinedButton(
              key: const ValueKey("deniedNotice"),
              onPressed: () async {
                Get.back<void>();
              },
              child: Text(S.of(context).cancel),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _onTapSelfAssessment() async {
    final dynamic result = await Get.toNamed<dynamic>(
      Routes.selfAssessmentQuestion,
    );
    if (result != null && result is SAQResult) {
      if (result.isSuccess) {
        SnackBars.complete(message: result.message).show(duration: 5000);
        controller.fetchProfile();
      } else {
        SnackBars.error(message: result.message).show(duration: 5000);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(
        title: S.of(context).myProfile,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
            child: Obx(
              () {
                final UserModel? profile = controller.profile;
                final FacilityModel? facilityModel = profile?.currentFacility;
                final isProductUser = controller.profile.isProductUser();
                final isLaborUser = controller.profile.isLaborUser();
                final isSupperAdmin = controller.profile.isSupperAdmin();
                final isEnableSAQ = controller.profile.hasPermission(
                  PermissionActionDef.completeOwnSaq,
                );
                final isCompletedSAQ = profile?.answeredSaqAt != null &&
                    profile!.answeredSaqAt! > 0;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (isProductUser && isEnableSAQ)
                      InkWell(
                        onTap: _onTapSelfAssessment,
                        child: Container(
                          alignment: Alignment.center,
                          width: double.infinity,
                          height: 48,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Expanded(child: SizedBox.shrink()),
                              Text(
                                isCompletedSAQ
                                    ? S.of(context).viewSAQ
                                    : S.of(context).continueSAQ,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.green700,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Icon(
                                Icons.arrow_forward_ios,
                                color: AppColors.green700,
                                size: 10,
                              )
                            ],
                          ),
                        ),
                      ),
                    if (isLaborUser)
                      const SizedBox(
                        height: 24,
                      ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          S.of(context).contact,
                          style: AppTextStyles.title(),
                        ),
                        InkWell(
                          key: const ValueKey('editButton'),
                          onTap: _onTapEditProfile,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 5),
                            child: Row(
                              children: [
                                SvgPicture.asset(AssetsConst.iconEdit),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  S.of(context).edit,
                                  style: AppTextStyles.title().copyWith(
                                    color: AppColors.orange700,
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: _buildDisplayData(
                            S.of(context).firstName,
                            profile?.firstName ?? '',
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: _buildDisplayData(
                            S.of(context).lastName,
                            profile?.lastName ?? '',
                          ),
                        ),
                      ],
                    ),
                    _buildDisplayData(
                      S.of(context).showPhone,
                      profile?.phoneNumber ?? '',
                    ),
                    _buildDisplayData(
                      S.of(context).email,
                      profile?.email ?? '',
                    ),
                    _buildDisplayData(
                      S.of(context).password,
                      S.of(context).dot,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      isLaborUser
                          ? S.of(context).organizationDetail
                          : S.of(context).information,
                      style: AppTextStyles.title(),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    if (isProductUser)
                      _buildDisplayData(
                        S.of(context).businessRegisterNumber,
                        (facilityModel?.businessRegisterNumber ?? ''),
                      ),
                    if (isProductUser)
                      _buildDisplayData(
                        S.of(context).osId,
                        facilityModel?.oarId ?? '',
                      ),
                    _buildDisplayData(
                      isProductUser
                          ? S.of(context).businessName
                          : S.of(context).laborName,
                      facilityModel?.name ?? '',
                    ),
                    if (isLaborUser)
                      _buildDisplayData(
                        S.of(context).businessRegisterNumber,
                        (facilityModel?.businessRegisterNumber ?? ''),
                      ),
                    _buildDisplayData(
                      S.of(context).address,
                      controller.address,
                    ),
                    if (isProductUser) ...[
                      _buildDisplayData(
                        S.of(context).goods,
                        (facilityModel?.goods ?? []).join(', '),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        S.of(context).certificationAndCustodyModel,
                        style: AppTextStyles.title(),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      _buildDisplayData(
                        S.of(context).certification,
                        facilityModel?.certification ?? '',
                      ),
                      _buildDisplayData(
                        S.of(context).chainOfCustody,
                        facilityModel?.getChainOfCustodyDisplayValue() ?? '',
                      ),
                      if ((facilityModel?.isMassBalance() ?? false))
                        _buildDisplayData(
                          S.of(context).reconciliationWindowStartDate,
                          controller.startDate,
                        ),
                      if ((facilityModel?.isMassBalance() ?? false))
                        _buildDisplayData(
                          S.of(context).reconciliationWindowDuration,
                          facilityModel?.reconciliationDurationDisplay ?? '',
                        ),
                    ],
                    const SizedBox(height: 8),
                    if (!isSupperAdmin) _buildDangerZone(context),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDisplayData(String title, String data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.grey200,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          data,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.grey700,
          ),
        ),
        const SizedBox(
          height: 12,
        ),
      ],
    );
  }

  Widget _buildDangerZone(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.warning_amber_rounded,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                S.of(context).dangerZone,
                style: AppTextStyles.title().copyWith(
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
            ),
          ],
        ),
        const Divider(
          color: AppColors.grey600,
          height: 32,
        ),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () => _onTapDeleteAccount(context),
            child: Text(S.of(context).deleteAccount),
            style: OutlinedButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.error,
              side: BorderSide(
                color: Theme.of(context).colorScheme.error,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Text(S.of(context).deleteAccountWarning),
        ),
      ],
    );
  }
}
