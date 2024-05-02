import 'package:usdol/app/core.dart';

class TransportPartnerRepo  extends ActiveRepo<String, TransportPartner> {
  @override
  String get boxName => ModelTypeDefine.transportBox;

}