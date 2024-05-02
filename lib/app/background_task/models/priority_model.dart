import 'package:usdol/app/core.dart';
part 'priority_model.g.dart';

@HiveType(typeId: ModelTypeDefine.priority)
class PriorityModel {
  @HiveField(0)
  String id;
  @HiveField(1)
  String? displayName;
  @HiveField(2)
  int? value;

  PriorityModel({
    required this.id,
    this.displayName,
    this.value,
  });
}
