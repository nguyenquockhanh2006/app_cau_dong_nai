part of 'bridge_model.dart';
bridge_model _$bridgeModelFromJson(Map<String, dynamic> json) => bridge_model(
      BridgeId: json['BridgeId'] as int?,
      TenCayCau: json['TenCayCau'] as String?,
      
    );

Map<String, dynamic> _$bridgeModelToJson(bridge_model instance) => <String, dynamic>{
      'BridgeId': instance.BridgeId,
      'TenCayCau': instance.TenCayCau,
    };
