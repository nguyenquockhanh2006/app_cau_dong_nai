import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
part 'res_model_utility.g.dart';

class ResponseArrayModel<T> {

  late bool isSuccess;
  late List<T> results;
  late String message;

  ResponseArrayModel({required this.isSuccess, required this.results, required this.message});

  factory ResponseArrayModel.fromJson(Map<String, dynamic> json, Function fromJson) {
    return ResponseArrayModel<T>(
      isSuccess: json['IsSuccess'],
      results: json['Data'].toString() != 'null' ? List<T>.from(json['Data'].cast<Map<String, dynamic>>().map((itemsJson) => fromJson(itemsJson))) : [],
      message: json['Message'],
    );
  }
}

class ResponseObjectModel<T> {
  late bool isSuccess;
  late T results;
  late String message;

  ResponseObjectModel({required this.isSuccess, required this.results, required this.message});

  factory ResponseObjectModel.fromJson(Map<String, dynamic> json, Function fromJson) {
    return ResponseObjectModel<T>(
      isSuccess: json['IsSuccess'],
      results: fromJson(Map<String, dynamic>.from(json['Data'])),
      message: json['Message'],
    );
  }
}

@JsonSerializable(explicitToJson: true)
class ResponseExecutedModel with ChangeNotifier {
  @JsonKey(name: 'IsSuccess')
  late bool isSuccess;

  @JsonKey(name: 'Message')
  late String message;

  ResponseExecutedModel({required this.isSuccess, required this.message});

  factory ResponseExecutedModel.fromJson(Map<String, dynamic> data) {return _$ResponseExecutedModelFromJson(data); }

  Map<String, dynamic> toJson() => _$ResponseExecutedModelToJson(this);
}
