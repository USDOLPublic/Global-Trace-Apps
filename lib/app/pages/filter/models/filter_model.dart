import 'package:usdol/app/core.dart';

class FilterModel {
  InputItem purchaser;
  InputItem seller;

  FilterModel({
    required this.purchaser,
    required this.seller,
  });

  factory FilterModel.empty() => FilterModel(
        purchaser: InputItem.empty(),
        seller: InputItem.empty(),
      );

  bool isHaveFillter() {
    return purchaser.isNotEmpty() || seller.isNotEmpty();
  }
}
