import 'package:usdol/app/core.dart';

class CertificationRepository extends ActiveRepo<String, CertificationModel> {
  @override
  String get boxName => ModelTypeDefine.certificationBox;
}