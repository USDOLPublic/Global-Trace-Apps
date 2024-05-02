import 'package:usdol/app/core.dart';

class IndicatorRepository extends ActiveRepo<String, IndicatorModel> {
  @override
  String get boxName => ModelTypeDefine.indicatorBox;

  List<IndicatorModel> getListValue() {
    Map<String, IndicatorModel> indicatorsData = getAllValues();
    List<IndicatorModel> processItems = indicatorsData.values.toList();
    processItems.sort((a, b) => a.name?.compareTo(b.name ?? "")??0);
    return processItems;
  }
}
