import 'package:usdol/app/core.dart';

class SeverityRepository extends ActiveRepo<String, SeverityModel> {
  @override
  String get boxName => ModelTypeDefine.severityBox;

  List<SeverityModel> getListValue() {
    Map<String, SeverityModel> severitiesData = getAllValues();
    List<SeverityModel> processItems = severitiesData.values.toList();
    processItems.sort((a, b) => a.index.compareTo(b.index));
    return processItems;
  }
}
