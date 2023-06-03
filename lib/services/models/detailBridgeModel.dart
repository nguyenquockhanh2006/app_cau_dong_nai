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
      tenCayCau:
          json['TenCayCau'] != null ? json['TenCayCau'].toString() : 'null',
      loaiCau: json['LoaiCau'] != null ? json['LoaiCau'].toString() : 'null',
      cap: json['Cap'] != null ? json['Cap'].toString() : 'null',
      lyTrinh: json['LyTrinh'] != '' ? json['LyTrinh'].toString() : 'null',
      diaDiem: json['DiaDiem'] != '' ? json['DiaDiem'].toString() : 'null',
      taiTrong: json['TaiTrong'] != '' ? json['TaiTrong'].toString() : 'null',
      kinhDo: json['KinhDo'] != null
          ? double.parse(json['KinhDo'].toString())
          : 0.0,
      viDo: json['ViDo'] != null ? double.parse(json['ViDo'].toString()) : 0.0,
      chieuDai: json['ChieuDai'] != null ? json['ChieuDai'].toString() : 'null',
      chieuRong:
          json['ChieuRong'] != null ? json['ChieuRong'].toString() : 'null',
      hinhAnhCau:
          json['HinhAnhCau'] != null ? json['HinhAnhCau'].toString() : 'null',
      hinhAnhBinhDo: json['HinhAnhBinhDo'] != null
          ? json['HinhAnhBinhDo'].toString()
          : 'null',
      hinhAnhMatCat: json['HinhAnhMatCat'] != null
          ? json['HinhAnhMatCat'].toString()
          : 'null',
      soNhip: json['SoNhip'] != null ? int.parse(json['SoNhip'].toString()) : 0,
      soMo: json['SoMo'] != null ? int.parse(json['SoMo'].toString()) : 0,
      soTru: json['SoTru'] != null ? int.parse(json['SoTru'].toString()) : 0,
      soDamChinh: json['SoDamChinh'] != null
          ? int.parse(json['SoDamChinh'].toString())
          : 0,
      soDamNgang: json['SoDamNgang'] != null
          ? int.parse(json['SoDamNgang'].toString())
          : 0,
      soLanCan:
          json['SoLanCan'] != null ? int.parse(json['SoLanCan'].toString()) : 0,
      soDaiPhanCach: json['SoDaiPhanCach'] != null
          ? int.parse(json['SoDaiPhanCach'].toString())
          : 0,
      damChinh: json['DamChinh'] != null ? json['DamChinh'].toString() : 'null',
      damNgang: json['DamNgang'] != null ? json['DamNgang'].toString() : 'null',
      banMatCau:
          json['BanMatCau'] != null ? json['BanMatCau'].toString() : 'null',
      lanCan: json['LanCan'] != null ? json['LanCan'].toString() : 'null',
      mo: json['Mo'] != null ? json['Mo'].toString() : 'null',
      tru: json['Tru'] != null ? json['Tru'].toString() : 'null',

      ngayKhoiCong: json['NgayKhoiCong'] != null
          ? json['NgayKhoiCong'].toString()
          : 'null',
      ngayHoanThanh: json['NgayHoanThanh'] != null
          ? json['NgayHoanThanh'].toString()
          : 'null',
      //
      chuDauTu: json['ChuDauTu'] != null ? json['ChuDauTu'].toString() : 'null',

      donViThietKe: json['DonViThietKe'] != null
          ? json['DonViThietKe'].toString()
          : 'null',

      donViThiCong: json['DonViThiCong'] != null
          ? json['DonViThiCong'].toString()
          : 'null',

      donViGiamSat: json['DonViGiamSat'] != null
          ? json['DonViGiamSat'].toString()
          : 'null',
      //
      chiPhiXayDung: json['ChiPhiXayDung'] != null
          ? int.tryParse(json['ChiPhiXayDung'].toString())
          : 0,
      chieuDaiNhip: json['ChieuDaiNhip'] != null
          ? double.tryParse(json['ChieuDaiNhip'].toString())
          : 0.0,
      beRongXeChay: json['BeRongXeChay'] != null
          ? double.tryParse(json['BeRongXeChay'].toString())
          : 0.0,
      khoangCachDamChinh: json['KhoangCachDamChinh'] != null
          ? double.tryParse(json['KhoangCachDamChinh'].toString())
          : 0.0,
      khoanCachDamNgang: json['KhoanCachDamNgang'] != null
          ? double.tryParse(json['KhoanCachDamNgang'].toString())
          : 0.0,
      chieuCaoBanMatCau: json['ChieuCaoBanMatCau'] != null
          ? double.tryParse(json['ChieuCaoBanMatCau'].toString())
          : 0.0,
      beRongLanCan: json['BeRongLanCan'] != null
          ? double.tryParse(json['BeRongLanCan'].toString())
          : 0.0,
    );
  }

  get vlDamChinh => null;
}
