import 'package:json_annotation/json_annotation.dart';
part 'bridge_model.g.dart';
@JsonSerializable()
class bridge_model {
  @JsonKey(name: 'BridgeId')
  late int? BridgeId = 0;

  @JsonKey(name: 'TenCayCau')
  late String? TenCayCau = "";
  bridge_model({this.BridgeId, this.TenCayCau});

  factory bridge_model.fromJson(Map<String, dynamic> data) => _$bridgeModelFromJson(data);

  Map<String, dynamic> toJson() => _$bridgeModelToJson(this);
}
