import 'package:usdol/app/core.dart';

class SellPartnerRepo  extends ActiveRepo<String, SellPartner> {
  @override
  String get boxName => ModelTypeDefine.sellerBox;

}