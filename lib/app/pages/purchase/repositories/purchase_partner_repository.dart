import 'package:usdol/app/core.dart';

class PurchasePartnerRepo  extends ActiveRepo<String, PurchasePartner> {
  @override
  String get boxName => ModelTypeDefine.partnerBox;

}