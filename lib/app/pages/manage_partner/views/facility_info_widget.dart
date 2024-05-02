import 'package:flutter/material.dart';
import 'package:usdol/app/core.dart';

class FacilityInfoWidget extends StatelessWidget {
  final FacilityRespModel facility;

  const FacilityInfoWidget({required this.facility, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String oarId = "";
    String regNo = "";
    if (facility.oarId != null && (facility.oarId?.isNotEmpty ?? false)) {
      oarId = facility.oarId!;
    }
    if (facility.businessRegisterNumber != null && (facility.businessRegisterNumber?.isNotEmpty ?? false)) {
      regNo = facility.businessRegisterNumber!;
    }

    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.grey300),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 12,
          ),
          Text(
            facility.name ?? '',
            style: const TextStyle(
              color: AppColors.green800,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(
            height: oarId.isEmpty ? 0 : 8,
          ),
          if (oarId.isNotEmpty)
            Text(
              S.of(context).osIdPrefix + oarId,
              style: const TextStyle(
                color: AppColors.grey200,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          SizedBox(
            height: regNo.isNotEmpty ? 8 : 0,
          ),
          if (regNo.isNotEmpty)
            Text(
              S.of(context).businessRegisterPrefix + regNo,
              style: const TextStyle(
                color: AppColors.grey200,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          const SizedBox(
            height: 12,
          ),
        ],
      ),
    );
  }
}
