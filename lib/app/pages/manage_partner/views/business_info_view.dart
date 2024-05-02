import 'package:flutter/material.dart';
import 'package:usdol/app/core.dart';

class BusinessInfoView extends StatelessWidget {
  const BusinessInfoView({super.key, required this.facility});

  final FacilityRespModel facility;

  void _closeOnClicked() {
    Get.back<dynamic>();
  }

  @override
  Widget build(BuildContext context) {
    String contactName = '';
    String phone = '';
    String email = '';
    if (facility.users != null && facility.users!.isNotEmpty) {
      FacilityUser contactInfo = facility.users!.first;
      contactName = "${contactInfo.firstName} ${contactInfo.lastName}";
      phone = contactInfo.phoneNumber ?? '';
      email = contactInfo.email ?? '';
    }
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  facility.name ?? '',
                  style: AppTextStyles.title(),
                ),
              ),
              InkWell(
                onTap: _closeOnClicked,
                child: const Icon(
                  Icons.close,
                  color: AppColors.grey300,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          //
          _buildLineInfo(
            context,
            title: S.of(context).type,
            value: facility.type ?? '',
          ),
          _buildLineInfo(
            context,
            title: S.of(context).osId,
            value: facility.oarId ?? '',
          ),
          _buildLineInfo(
            context,
            title: S.of(context).contactName,
            value: contactName,
          ),
          _buildLineInfo(
            context,
            title: S.of(context).phone,
            value: phone,
          ),
          _buildLineInfo(
            context,
            title: S.of(context).email,
            value: email,
          ),
        ],
      ),
    );
  }

  Widget _buildLineInfo(
    BuildContext context, {
    String title = '',
    String value = '',
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(
              title,
              style: const TextStyle(
                color: AppColors.grey300,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: AppColors.grey800,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
