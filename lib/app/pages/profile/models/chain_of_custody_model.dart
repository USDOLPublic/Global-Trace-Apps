import 'package:json_annotation/json_annotation.dart';
part 'chain_of_custody_model.g.dart';

@JsonSerializable()
class ChainOfCustodyModel {
  String id;
  String name;

  ChainOfCustodyModel({required this.id, required this.name});

  factory ChainOfCustodyModel.fromJson(Map<String, dynamic> json) =>
      _$ChainOfCustodyModelFromJson(json);
  Map<String, dynamic> toJson() => _$ChainOfCustodyModelToJson(this);
}
