import 'package:flutter/widgets.dart';

class detailRepairModel {
  final int? repairDetailId;
  final int? repairHistoryId;
  final String? noiDung;
  final String? hinhAnh;
  final String? ghiChu;
  final String? thoiGian;
  detailRepairModel({
    required this.repairDetailId,
    required this.repairHistoryId,
    required this.noiDung,
    required this.hinhAnh,
    required this.ghiChu,
    required this.thoiGian,
  });
  factory detailRepairModel.fromJson(Map<String, dynamic> json) {
    return detailRepairModel(
      repairDetailId: json['RepairDetailId'] != null
          ? int.tryParse(json['RepairDetailId'].toString()) ?? 0
          : 0,
      repairHistoryId: json['RepairHistoryId'] != null
          ? int.tryParse(json['RepairHistoryId'].toString()) ?? 0
          : 0,
      noiDung: json['NoiDung'] != null ? json['NoiDung'].toString() : "",
      hinhAnh:
          json['ImageString'] != null ? json['ImageString'].toString() : "",
      ghiChu: json['GhiChu'] != null ? json['GhiChu'].toString() : "",
      thoiGian: json['ThoiGian'] != null ? json['ThoiGian'].toString() : "",
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'NoiDung': noiDung,
      'ImageString': hinhAnh,
      'GhiChu': ghiChu,
      'ThoiGian': thoiGian,
    };
  }
}
