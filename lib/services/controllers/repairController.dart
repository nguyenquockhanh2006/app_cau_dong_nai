import 'package:flutter_application_4/services/models/detailRepairModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/repairModel.dart';

class repairController {
  Future<List<RepairModel>> getApi() async {
    const String apiUrl =
        'http://171.244.8.103:9003/api/bridgeRepair?keyword=&status=0&startSuaChua=&endSuaChua=&bridgeId=0';
    http.Response response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      var data = jsonResponse["Data"];
      List<RepairModel> repairList = [];
      for (var jsonModel in data) {
        repairList.add(RepairModel.fromJson(jsonModel));
      }
      return repairList;
    } else {
      throw Exception('Failed to load bridge data from API');
    }
  }

  Future<List<String>> getBridgeNameApi() async {
    const String apiUrl =
        'http://171.244.8.103:9003/api/bridgeRepair?keyword=&status=0&startSuaChua=&endSuaChua=&bridgeId=0';
    http.Response response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      var data = jsonResponse["Data"];
      List<String> repairList = [];
      for (var jsonModel in data) {
        repairList.add(RepairModel.fromJson(jsonModel).TenCayCau as String);
      }
      return repairList;
    } else {
      throw Exception('Failed to load bridge data from API');
    }
  }

  Future<int> postAPI(
    //String? TrangThai,
    //int RepairHistoryId,
    int? BridgeId,
    String? TenCayCau,
    //String? HinhAnhCau,
    String? NgayKiemTra,
    String? DonViKiemTra,
    String? LoaiHuHong,
    String? NgaySuaChua,
    String? DonViSuaChua,
    int? ChiPhiSuaChua,
    //String? TotalProcessTime,
  ) async {
    final String url = 'http://171.244.8.103:9003/api/bridgeRepair';
    final Map<String, dynamic> data = {
      "TrangThai": "Chưa sửa",
      //"RepairHistoryId": 11,
      "BridgeId": BridgeId,
      "TenCayCau": TenCayCau,
      "HinhAnhCau": null,
      "NgayKiemTra": NgayKiemTra,
      "DonViKiemTra": DonViKiemTra,
      "LoaiHuHong": LoaiHuHong,
      "NgaySuaChua": NgaySuaChua,
      "DonViSuaChua": DonViSuaChua,
      "ChiPhiSuaChua": ChiPhiSuaChua,
      "TotalProcessTime": null,
    };

    final response = await http.post(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json; charset=UTF-8",
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      print(response.body);
      return 200;
    } else {
      print(response.statusCode);
      print(response.body);
      return 0;
      // xử lý kết quả lỗi
    }
  }

  Future<int> deleteItem(String id) async {
    final url = Uri.parse('http://171.244.8.103:9003/api/bridgeRepair/$id');
    final response = await http.delete(url);

    if (response.statusCode == 200) {
      return 200;
    } else {
      return 0;
      // Xử lý khi xóa thất bại.
    }
  }

  Future<RepairModel> getApiById(int id) async {
    final String apiUrl = 'http://171.244.8.103:9003/api/bridgeRepair/$id';
    http.Response response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      var data = jsonResponse["Data"];
      return RepairModel.fromJson(data);
    } else {
      throw Exception('Failed to load bridge data from API');
    }
  }

  Future<List<detailRepairModel>> getDetailById(int id) async {
    final String apiUrl = 'http://171.244.8.103:9003/api/bridgeRepair/$id';
    http.Response response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      var data = jsonResponse["Data"]["Details"];
      List<detailRepairModel> repairList = [];
      for (var jsonModel in data) {
        repairList.add(detailRepairModel.fromJson(jsonModel));
      }
      print(response.body);
      return repairList;
      //return RepairModel.fromJson(data);
    } else {
      throw Exception('Failed to load bridge data from API');
    }
  }

  Future<int> putRepair(
    int id,
    int bridgeId,
    String ngayKiemTra,
    String donviKiemTra,
    String noiDungHuHong,
    String ngaySuaChua,
    String donViSuaChua,
    int? chiPhiSuaChua,
    //List<detailRepairModel> detailList
  ) async {
    //var detailsJson = detailList.map((detail) => detail.toJson()).toList();
    final data = {
      "RepairHistoryId": id,
      "BridgeId": bridgeId,
      'NgayKiemTra': ngayKiemTra,
      'DonViKiemTra': donviKiemTra,
      'LoaiHuHong': noiDungHuHong,
      'NgaySuaChua': ngaySuaChua,
      'TotalProcessTime': null,
      'DonViSuaChua': donViSuaChua,
      'ChiPhiSuaChua': chiPhiSuaChua,
      //'Details': detailsJson,
    };

    // chuyển đổi đối tượng sang chuỗi JSON
    final jsonString = jsonEncode(data);

    // gửi yêu cầu PUT
    final response = await http.put(
      Uri.parse('http://171.244.8.103:9003/api/bridgeRepair/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonString,
    );
    // kiểm tra mã trạng thái của response
    if (response.statusCode == 200) {
      // xử lý response khi PUT API thành công
      print('PUT API thành công. Response: ${response.body}');
      return 200;
    } else {
      // xử lý response khi PUT API thất bại
      print('PUT API thất bại. StatusCode: ${response.statusCode}');
      return 0;
    }
  }
}
