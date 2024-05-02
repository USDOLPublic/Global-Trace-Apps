import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:usdol/app/core.dart';
import 'package:usdol/app/pages/manage_partner/views/business_info_view.dart';

class ManageBusinessItem extends StatelessWidget {
  final ManagePartnerModel partners;
  final Function onTap;
  final Function onDeleteFacility;

  const ManageBusinessItem({
    Key? key,
    required this.partners,
    required this.onTap,
    required this.onDeleteFacility,
  }) : super(key: key);

  void _itemOnClicked(BuildContext context, FacilityRespModel? facility) {
    if (facility == null) return;
    Get.dialog<dynamic>(
      BasePopup(
        body: BusinessInfoView(facility: facility),
        isSmallAlert: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final listPartnerLength = partners.businessPartners?.length ?? 0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          partners.argument?.name ?? '',
          style: AppTextStyles.title(),
        ),
        SizedBox(
          height: listPartnerLength > 0 ? 8 : 0,
        ),
        ListView.builder(
          itemCount: listPartnerLength,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (_, index) {
            FacilityRespModel? partner = partners.businessPartners?[index];
            return InkWell(
              onTap: () => _itemOnClicked(context, partner),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.k555555.withOpacity(0.06),
                      spreadRadius: 0.6,
                      blurRadius: 0.5,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                padding: const EdgeInsets.only(left: 16, top: 4, bottom: 4),
                margin: const EdgeInsets.only(bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        partner?.name ?? '',
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        style: const TextStyle(
                          color: AppColors.green800,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Center(
                      child: IconButton(
                        onPressed: () => onDeleteFacility.call(partner),
                        icon: const Icon(
                          Icons.close,
                          color: AppColors.grey300,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        const SizedBox(
          height: 9,
        ),
        InkWell(
          key: ValueKey((partners.argument?.name ?? '') + "Button"),
          onTap: () => onTap.call(partners.argument),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
                Expanded(
                  child: Text(
                    S.of(context).add + " " + (partners.argument?.name ?? ''),
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: AppColors.orange700,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 25,
        ),
      ],
    );
  }
}
