import 'package:flutter_application_4/services/models/repairModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/bridgeModel.dart';

class bridgeController {
  Future<List<bridgeModel>> getApi() async {
    const String apiUrl = 'http://171.244.8.103:9003/api/bridge?keyword=&type=';
    http.Response response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      var data = jsonResponse["Data"];
      List<bridgeModel> bridgeList = [];
      for (var jsonModel in data) {
        bridgeList.add(bridgeModel.fromJson(jsonModel));
      }
      return bridgeList;
    } else {
      throw Exception('Failed to load bridge data from API');
    }
  }
  Future<List<RepairModel>> getApiById(int id) async {
    String apiUrl = 'http://171.244.8.103:9003/api/bridge/$id';
    http.Response response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      var data = jsonResponse["Data"]["BridgeRepairs"];
      List<RepairModel> bridgeList = [];
      for (var jsonModel in data) {
        bridgeList.add(RepairModel.fromJson(jsonModel));
      }
      //print(bridgeList.first.NgayKiemTra);
      return bridgeList;
    } else {
      throw Exception('Failed to load bridge data from API');
    }
  }

  Future<int> postMyAPI(
    String anhCayCau,
    String anhMatCat,
    String anhBinhDo,
    String tenCayCau,
    String loaiCau,
    String cap,
    String lyTrinh,
    String taiTrong,
    String chieuDai,
    String chieuRong,
    String diaDiem,
    double kinhDo,
    double viDo,
    String ngayKhoiCong,
    String ngayHoanThanh,
    int? chiPhiXayDung,
    String chuDauTu,
    String donViThietKe,
    String donViThiCong,
    String donViGiamSat,
    int soNhip,
    int soMo,
    int soTru,
    int soDamNgang,
    int soDamChinh,
    int soLanCan,
    int soDaiPhanCach,
    String vlDamChinh,
    String vlDamNgang,
    String vlBanMatCau,
    String vlLanCan,
    String vlMo,
    String vlTru,
    double chieuDaiNhip,
    double beRongXeChay,
    double khoangCachDamChinh,
    double khoangCachDamNgang,
    double chieuCaoBanMatCau,
    double beRongLanCan,
  ) async {
    const url = 'http://171.244.8.103:9003/api/bridge';

    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode(<String, dynamic>{
        'TenCayCau': tenCayCau,
        'LoaiCau': loaiCau,
        'Cap': cap,
        'LyTrinh': lyTrinh,
        'DiaDiem': diaDiem,
        'TaiTrong': taiTrong,
        'KinhDo': kinhDo,
        'ViDo': viDo,
        'ChieuDai': chieuDai,
        'ChieuRong': chieuRong,
        'HinhAnhCau': anhCayCau,
        'HinhAnhBinhDo': anhBinhDo,
        'HinhAnhMatCat': anhMatCat,
        'SoNhip': soNhip,
        'SoMo': soMo,
        'SoTru': soTru,
        'SoDamChinh': soDamChinh,
        'SoDamNgang': soDamNgang,
        'SoLanCan': soLanCan,
        'SoDaiPhanCach': soDaiPhanCach,
        'DamChinh': vlDamChinh,
        'DamNgang': vlDamNgang,
        'BanMatCau': vlBanMatCau,
        'LanCan': vlLanCan,
        'Mo': vlMo,
        'Tru': vlTru,
        'NgayKhoiCong': ngayKhoiCong,
        'NgayHoanThanh': ngayHoanThanh,
        'ChuDauTu': chuDauTu,
        'DonViThietKe': donViThietKe,
        'DonViThiCong': donViThiCong,
        'DonViGiamSat': donViGiamSat,
        'ChiPhiXayDung': null, //chiPhiXayDung, //!=null?12:null,
        'ChieuDaiNhip': chieuDaiNhip,
        'BeRongXeChay': beRongXeChay,
        'KhoangCachDamChinh': khoangCachDamChinh,
        'KhoanCachDamNgang': khoangCachDamNgang,
        'ChieuCaoBanMatCau': chieuCaoBanMatCau,
        'BeRongLanCan': beRongLanCan,
      }),
    );

    if (response.statusCode == 200) {
      print('Request Successful Response code: ${response.statusCode}');
      print('Response Body: ${response.body}');
      return 200;
    } else {
      print('Request Failed Response code: ${response.statusCode}');
      print('Response Body: ${response.body}');
      return -1;
    }
  }

  Future<void> deleteRecord(int id) async {
    final String apiUrl = 'http://171.244.8.103:9003/api/bridge/$id';
    http.Response response = await http.delete(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      // Xóa bản ghi thành công
      print('Record deleted successfully');
    } else {
      // Lỗi xóa bản ghi
      print('Failed to delete record: ${response.reasonPhrase}');
    }
  }

  Future<List<String>> getBridgeNameApi() async {
    const String apiUrl = 'http://171.244.8.103:9003/api/bridge';
    http.Response response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      var data = jsonResponse["Data"];
      List<String> repairList = [];
      for (var jsonModel in data) {
        repairList.add(bridgeModel.fromJson(jsonModel).TenCayCau);
      }
      return repairList;
    } else {
      throw Exception('Failed to load bridge data from API');
    }
  }
  
  Future<List<String>> getTypeNameApi() async {
    const String apiUrl = 'http://171.244.8.103:9003/api/bridge';
    http.Response response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      var data = jsonResponse["Data"];
      List<String> repairList = [];
      repairList.add('Chưa xác định');
      for (var jsonModel in data) {
        if (bridgeModel.fromJson(jsonModel).LoaiCau.toString() != '' && repairList.contains(bridgeModel.fromJson(jsonModel).LoaiCau.toString()) == false ) {
          repairList.add(bridgeModel.fromJson(jsonModel).LoaiCau);
        }
      }
      return repairList ;
    } else {
      throw Exception('Failed to load bridge data from API');
    }
  }

  Future<int> getLength() async {
    const String apiUrl = 'http://171.244.8.103:9003/api/bridge';
    http.Response response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      var data = jsonResponse["Data"];
      List<String> repairList = [];
      for (var jsonModel in data) {
        repairList.add(bridgeModel.fromJson(jsonModel).TenCayCau);
      }
      return repairList.length;
    } else {
      return 0;
    }
  }
}
