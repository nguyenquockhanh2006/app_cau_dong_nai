// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'res_model_utility.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseExecutedModel _$ResponseExecutedModelFromJson(
        Map<String, dynamic> json) =>
    ResponseExecutedModel(
      isSuccess: json['IsSuccess'] as bool,
      message: json['Message'] as String,
    );

Map<String, dynamic> _$ResponseExecutedModelToJson(
        ResponseExecutedModel instance) =>
    <String, dynamic>{
      'IsSuccess': instance.isSuccess,
      'Message': instance.message,
    };
