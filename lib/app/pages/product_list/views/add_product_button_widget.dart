import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:usdol/app/core.dart';

class AddProductButtonWidget extends StatelessWidget {
  const AddProductButtonWidget({
    super.key,
    required this.products,
    this.addProductOnTap,
    this.buttonTile,
  });

  final void Function()? addProductOnTap;
  final List<ProductModel> products;
  final String? buttonTile;

  double? _getTotalWeight() {
    double totalWeight = 0;
    bool isNotWeightUnit = false;
    for (var product in products) {
      double? weightValue = product.getTotalWeight();
      if (weightValue == null) {
        isNotWeightUnit = true;
      } else {
        totalWeight += weightValue;
      }
    }
    return isNotWeightUnit ? null : totalWeight;
  }

  @override
  Widget build(BuildContext context) {
    return _buildInputProducts(context);
  }

  Widget _buildInputProducts(BuildContext context) {
    return InkWell(
      key: const ValueKey('addProducts'),
      onTap: addProductOnTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppProperties.circleRadius),
          color: AppColors.white,
        ),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        child: products.isEmpty
            ? _buildAddProductButton(context)
            : _buildProductsInfo(
                context,
              ),
      ),
    );
  }

  Widget _buildAddProductButton(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        const Icon(Icons.add, color: AppColors.orange700),
        const SizedBox(width: 8),
        Text(
          buttonTile ?? S.of(context).addProduct,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.orange700,
          ),
        ),
      ],
    );
  }

  Widget _buildProductsInfo(BuildContext context) {
    int numOfProduct = products.length;
    double? totalWeight = _getTotalWeight();
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        SvgPicture.asset(AssetsConst.listAlt),
        const SizedBox(width: 8),
        Expanded(
          child: RichText(
            text: TextSpan(
              text: "$numOfProduct ",
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: AppColors.grey700,
              ),
              children: [
                TextSpan(
                  text: numOfProduct == 1
                      ? S.of(context).product
                      : S.of(context).products,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    color: AppColors.grey700,
                  ),
                ),
              ],
            ),
          ),
        ),
        if (totalWeight != null)
          Expanded(
            child: RichText(
              text: TextSpan(
                text: "${totalWeight.toNumericFormat()} ",
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppColors.grey700,
                ),
                children: [
                  TextSpan(
                    text: defaultWeightUnit.displayLabel,
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      color: AppColors.grey700,
                    ),
                  ),
                ],
              ),
            ),
          ),
        const Icon(
          Icons.edit,
          color: AppColors.orange700,
          size: 20,
        ),
        const SizedBox(width: 8),
        Text(
          S.of(context).edit,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.orange700,
          ),
        ),
      ],
    );
  }
}
