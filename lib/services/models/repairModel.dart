class RepairModel {
  final int    BridgeId;
  final int    RepairHistoryId;
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
  RepairModel(
      {
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
      BridgeId: json['BridgeId'],
      RepairHistoryId: json['RepairHistoryId'],
      TrangThai: json['TrangThai'],
      TenCayCau: json['TenCayCau'],
      HinhAnhCau: json['HinhAnhCau'],
      NgayKiemTra: json['NgayKiemTra'],
      DonViKiemTra: json['DonViKiemTra'],
      LoaiHuHong: json['LoaiHuHong'],
      NgaySuaChua: json['NgaySuaChua'],
      DonViSuaChua: json['DonViSuaChua'],
      ChiPhiSuaChua: json['ChiPhiSuaChua'],
      TotalProcessTime: json['TotalProcessTime'],
    );
  }
}
