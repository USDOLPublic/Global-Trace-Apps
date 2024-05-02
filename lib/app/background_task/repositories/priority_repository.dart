import 'package:usdol/app/core.dart';

class PriorityRepository extends ActiveRepo<String, PriorityModel> {
  @override
  String get boxName => ModelTypeDefine.priorityBox;

  List<PriorityModel> getListValue() {
    Map<String, PriorityModel> indicatorsData = getAllValues();
    List<PriorityModel> processItems = indicatorsData.values.toList();
    return processItems;
  }
}
