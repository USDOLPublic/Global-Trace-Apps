import 'package:usdol/app/core.dart';

class CountryRepository extends ActiveRepo<String, CountryModel> {
  @override
  String get boxName => ModelTypeDefine.countryBox;
}
