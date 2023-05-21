class bridgeModel {
  final int BridgeId;
  final String TenCayCau;
  final String LoaiCau;
  final String Cap;
  final String LyTrinh;
  final String DiaDiem;
  final String TaiTrong;
  final double KinhDo;
  final double ViDo;
  final String ChieuDai;
  final String ChieuRong;
  final String NgayKhoiCong;
  final String NgayHoanThanh;
  final String HinhAnhCau;
  final String HinhAnhBinhDo;
  final String HinhAnhMatCat;
  bridgeModel(
      {required this.BridgeId,
      required this.TenCayCau,
      required this.LoaiCau,
      required this.Cap,
      required this.LyTrinh,
      required this.DiaDiem,
      required this.TaiTrong,
      required this.KinhDo,
      required this.ViDo,
      required this.ChieuDai,
      required this.ChieuRong,
      required this.NgayKhoiCong,
      required this.NgayHoanThanh,
      required this.HinhAnhCau,
      required this.HinhAnhBinhDo,
      required this.HinhAnhMatCat});
  factory bridgeModel.fromJson(Map<String, dynamic> json) {
    return bridgeModel(
      BridgeId: json['BridgeId'],
      TenCayCau: json['TenCayCau'],
      LoaiCau: json['LoaiCau'],
      Cap: json['Cap'],
      LyTrinh: json['LyTrinh'],
      DiaDiem: json['DiaDiem'],
      TaiTrong: json['TaiTrong'],
      KinhDo: json['KinhDo'],
      ViDo: json['ViDo'],
      ChieuDai: json['ChieuDai'],
      ChieuRong: json['ChieuRong'],
      NgayKhoiCong: json['NgayKhoiCong'],
      NgayHoanThanh: json['NgayHoanThanh'],
      HinhAnhCau: json['HinhAnhCau'],
      HinhAnhBinhDo: json['HinhAnhBinhDo'],
      HinhAnhMatCat: json['HinhAnhMatCat'],
    );
  }
  Map<String, dynamic> toJson() => {
        'BridgeId': BridgeId,
        'TenCayCau': TenCayCau,
        'LoaiCau': LoaiCau,
        'Cap': Cap,
        'LyTrinh': LyTrinh,
        'DiaDiem': DiaDiem,
        'TaiTrong': TaiTrong,
        'KinhDo': KinhDo,
        'ViDo': ViDo,
        'ChieuDai': ChieuDai,
        'ChieuRong': ChieuRong,
        'NgayKhoiCong': NgayKhoiCong,
        'NgayHoanThanh': NgayHoanThanh,
        'HinhAnhCau': HinhAnhCau,
        'HinhAnhBinhDo': HinhAnhBinhDo,
        'HinhAnhMatCat': HinhAnhMatCat
      };
}
