class RepairModel {
  final int BridgeId;
  final int RepairHistoryId;
  final String TrangThai;
  final String TenCayCau;
  final String HinhAnhCau;
  final String NgayKiemTra;
  final String DonViKiemTra;
  final String LoaiHuHong;
  final String NgaySuaChua;
  final String DonViSuaChua;
  final double ChiPhiSuaChua;
  final String TotalProcessTime;
  RepairModel({
    required this.BridgeId,
    required this.RepairHistoryId,
    required this.TrangThai,
    required this.TenCayCau,
    required this.HinhAnhCau,
    required this.NgayKiemTra,
    required this.DonViKiemTra,
    required this.LoaiHuHong,
    required this.NgaySuaChua,
    required this.DonViSuaChua,
    required this.ChiPhiSuaChua,
    required this.TotalProcessTime,
  });
  factory RepairModel.fromJson(Map<String, dynamic> json) {
    return RepairModel(
      BridgeId: json['BridgeId'] != null
          ? int.tryParse(json['BridgeId'].toString()) ?? 0
          : 0,
      RepairHistoryId: json['RepairHistoryId'] != null
          ? int.tryParse(json['RepairHistoryId'].toString()) ?? 0
          : 0,
      TrangThai: json['TrangThai'] != null ? json['TrangThai'].toString() : "",
      TenCayCau: json['TenCayCau'] != null ? json['TenCayCau'].toString() : "",
      HinhAnhCau:
          json['HinhAnhCau'] != null ? json['HinhAnhCau'].toString() : "",
      NgayKiemTra:
          json['NgayKiemTra'] != null ? json['NgayKiemTra'].toString() : "",
      DonViKiemTra:
          json['DonViKiemTra'] != null ? json['DonViKiemTra'].toString() : "",
      LoaiHuHong:
          json['LoaiHuHong'] != null ? json['LoaiHuHong'].toString() : "",
      NgaySuaChua:
          json['NgaySuaChua'] != null ? json['NgaySuaChua'].toString() : "",
      DonViSuaChua:
          json['DonViSuaChua'] != null ? json['DonViSuaChua'].toString() : "",
      ChiPhiSuaChua: json['ChiPhiSuaChua'] != null
          ? double.tryParse(json['KhoangCachDamChinh'].toString()) ?? 0
          : 0,
      TotalProcessTime: json['TotalProcessTime'] != null
          ? json['KhoangCachDamChinh'].toString()
          : "",
    );
  }
}
