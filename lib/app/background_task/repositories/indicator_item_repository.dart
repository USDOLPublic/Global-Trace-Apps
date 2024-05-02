import 'package:usdol/app/core.dart';

class IndicatorItemRepository extends ActiveRepo<String, LaborRisksModel> {
  @override
  String get boxName => ModelTypeDefine.indicatorItemBox;

  List<LaborRisksModel> getListValue() {
    Map<String, LaborRisksModel> indicatorsData = getAllValues();
    List<LaborRisksModel> processItems = indicatorsData.values.toList();
    return processItems;
  }
}
