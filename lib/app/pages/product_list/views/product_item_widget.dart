import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:usdol/app/core.dart';

class ProductItemWidget extends StatelessWidget {
  const ProductItemWidget({
    super.key,
    required this.product,
    required this.onRemove,
    required this.onDownloadFile,
  });

  final ProductModel product;
  final void Function(ProductModel) onRemove;
  final void Function(ProductModel) onDownloadFile;

  @override
  Widget build(BuildContext context) {
    DateTime createDate =
        DateUtil.fromSeconds(product.createdAt) ?? DateTime.now();
    String productCode = product.getProductIdDisplay();
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColors.grey100,
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  DateUtil.formatDate(createDate, format: DateFormats.ddMMyyyy),
                  style: const TextStyle(
                    color: AppColors.grey200,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              InkWell(
                onTap: () => onRemove(product),
                child: const Icon(
                  Icons.close,
                  color: AppColors.grey200,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            productCode,
            style: const TextStyle(
              color: AppColors.black,
            ),
          ),
          TextButton.icon(
            onPressed: () => onDownloadFile(product),
            icon: SvgPicture.asset(AssetsConst.download),
            label: Text(S.of(context).download),
            style: TextButton.styleFrom(
              padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
            ),
          ),
        ],
      ),
    );
  }
}
