class detailBridgeModel {
   int? bridgeId;
   String? tenCayCau;
   String? loaiCau;
   String? cap;
   String? lyTrinh;
   String? diaDiem;
   String? taiTrong;
   double? kinhDo;
   double? viDo;
   String? chieuDai;
   String? chieuRong;
   String? hinhAnhCau;
   String? hinhAnhBinhDo;
   String? hinhAnhMatCat;
   int? soNhip;
   int? soMo;
   int? soTru;
   int? soDamChinh;
   int? soDamNgang;
   int? soLanCan;
   int? soDaiPhanCach;
   String? damChinh;
   String? damNgang;
   String? banMatCau;
   String? lanCan;
   String? mo;
   String? tru;
   String? ngayKhoiCong;
   String? ngayHoanThanh;
   String? chuDauTu;
   String? donViThietKe;
   String? donViThiCong;
   String? donViGiamSat;
   int? chiPhiXayDung;
   double? chieuDaiNhip;
   double? beRongXeChay;
   double? khoangCachDamChinh;
   double? khoanCachDamNgang;
   double? chieuCaoBanMatCau;
   double? beRongLanCan;
  detailBridgeModel({
    required this.bridgeId,
    required this.tenCayCau,
    required this.loaiCau,
    required this.cap,
    required this.lyTrinh,
    required this.diaDiem,
    required this.taiTrong,
    required this.kinhDo,
    required this.viDo,
    required this.chieuDai,
    required this.chieuRong,
    required this.hinhAnhCau,
    required this.hinhAnhBinhDo,
    required this.hinhAnhMatCat,
    required this.soNhip,
    required this.soMo,
    required this.soTru,
    required this.soDamChinh,
    required this.soDamNgang,
    required this.soLanCan,
    required this.soDaiPhanCach,
    required this.damChinh,
    required this.damNgang,
    required this.banMatCau,
    required this.lanCan,
    required this.mo,
    required this.tru,
    required this.ngayKhoiCong,
    required this.ngayHoanThanh,
    required this.chuDauTu,
    required this.donViThietKe,
    required this.donViThiCong,
    required this.donViGiamSat,
    required this.chiPhiXayDung,
    required this.chieuDaiNhip,
    required this.beRongXeChay,
    required this.khoangCachDamChinh,
    required this.khoanCachDamNgang,
    required this.chieuCaoBanMatCau,
    required this.beRongLanCan,
  });
  factory detailBridgeModel.fromJson(Map<String, dynamic> json) {
    return detailBridgeModel(
      bridgeId: json['BridgeId'],
      tenCayCau: json['TenCayCau'],
      loaiCau: json['LoaiCau'],
      cap: json['Cap'],
      lyTrinh: json['LyTrinh'],
      diaDiem: json['DiaDiem'],
      taiTrong: json['TaiTrong'],
      kinhDo: json['KinhDo'],
      viDo: json['ViDo'],
      chieuDai: json['ChieuDai'],
      chieuRong: json['ChieuRong'],
      hinhAnhCau: json['HinhAnhCau'],
      hinhAnhBinhDo: json['HinhAnhBinhDo'],
      hinhAnhMatCat: json['HinhAnhMatCat'],
      soNhip: json['SoNhip'],
      soMo: json['SoMo'],
      soTru: json['SoTru'],
      soDamChinh: json['SoDamChinh'],
      soDamNgang: json['SoDamNgang'],
      soLanCan: json['SoLanCan'],
      soDaiPhanCach: json['SoDaiPhanCach'],
      damChinh: json['DamChinh'],
      damNgang: json['DamNgang'],
      banMatCau: json['BanMatCau'],
      lanCan: json['LanCan'],
      mo: json['Mo'],
      tru: json['Tru'],
      ngayKhoiCong: json['NgayKhoiCong'],
      ngayHoanThanh: json['NgayHoanThanh'],
      chuDauTu: json['ChuDauTu'],
      donViThietKe: json['DonViThietKe'],
      donViThiCong: json['DonViThiCong'],
      donViGiamSat: json['DonViGiamSat'],
      chiPhiXayDung: json['ChiPhiXayDung'] != null ? int.tryParse(json['ChiPhiXayDung'].toString()) ?? 0 : 0,
      chieuDaiNhip: json['ChieuDaiNhip'] != null ? double.tryParse(json['ChieuDaiNhip'].toString()) ?? 0 : 0,
      beRongXeChay: json['BeRongXeChay'] != null ? double.tryParse(json['BeRongXeChay'].toString()) ?? 0 : 0,
      khoangCachDamChinh: json['KhoangCachDamChinh'] != null ? double.tryParse(json['KhoangCachDamChinh'].toString()) ?? 0 : 0,
      khoanCachDamNgang: json['KhoanCachDamNgang'] != null ? double.tryParse(json['KhoanCachDamNgang'].toString()) ?? 0 : 0,
      chieuCaoBanMatCau: json['ChieuCaoBanMatCau'] != null ? double.tryParse(json['ChieuCaoBanMatCau'].toString()) ?? 0 : 0,
      beRongLanCan: json['BeRongLanCan'] != null ? double.tryParse(json['BeRongLanCan'].toString()) ?? 0 : 0,
    );
  }
}
