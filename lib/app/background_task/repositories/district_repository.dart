import 'package:usdol/app/core.dart';

class DistrictRepository extends ActiveRepo<String, DistrictModel> {
  @override
  String get boxName => ModelTypeDefine.districtBox;
}
