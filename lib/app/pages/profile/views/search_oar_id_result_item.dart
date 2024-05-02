import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:usdol/app/core.dart';

class SearchOarIdResultItem extends StatelessWidget {
  final bool isSelectedItem;
  final OarIdResult oarIDRespModel;
  final Function onTap;
  final bool isEnableSelection;

  const SearchOarIdResultItem({
    required this.oarIDRespModel,
    required this.isSelectedItem,
    required this.onTap,
    this.isEnableSelection = true,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (isEnableSelection) ? () => onTap.call(oarIDRespModel) : null,
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
                if (isEnableSelection)
                  SizedBox(
                    width: 24,
                    height: 24,
                    child: SvgPicture.asset(isSelectedItem ? AssetsConst.radioButtonChecked : AssetsConst.radioButtonUncheck),
                  ),
                if (isEnableSelection)
                  const SizedBox(
                    width: 8,
                  ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLineInfo(
                        context,
                        label: S.of(context).businessNameLower,
                        title: oarIDRespModel.name ?? '',
                      ),
                      const SizedBox(height: 4),
                      _buildLineInfo(
                        context,
                        label: S.of(context).osId,
                        title: oarIDRespModel.oarId ?? '',
                        isHighlight: true,
                      ),
                      const SizedBox(height: 4),
                      _buildLineInfo(
                        context,
                        label: S.of(context).address,
                        title: oarIDRespModel.address ?? '',
                      ),
                      const SizedBox(height: 4),
                      _buildLineInfo(
                        context,
                        label: S.of(context).country,
                        title: oarIDRespModel.countryName ?? '',
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

  Widget _buildLineInfo(
    BuildContext context, {
    String label = "",
    String title = "",
    bool isHighlight = false,
  }) {
    TextStyle labelStyle = const TextStyle(
      color: AppColors.grey300,
      fontWeight: FontWeight.w400,
      fontSize: 14,
    );
    TextStyle titleStyle = TextStyle(
      color: isHighlight ? AppColors.green700 : AppColors.grey600,
      fontWeight: FontWeight.w400,
      fontSize: 14,
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Text(
            label,
            style: labelStyle,
          ),
        ),
        const SizedBox(width: 4),
        Expanded(
          flex: 2,
          child: Text(
            title,
            style: titleStyle,
          ),
        ),
      ],
    );
  }
}
