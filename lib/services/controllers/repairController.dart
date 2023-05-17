import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/repairModel.dart';

class RepairController {
  Future<List<RepairModel>> getApi() async {
    final String apiUrl = 'http://171.244.8.103:9003/api/bridgeRepair?keyword=&status=0&startSuaChua=&endSuaChua=&bridgeId=0';
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
  Future<List<RepairModel>> getApiWithId(int id) async {
    final String apiUrl = 'http://171.244.8.103:9003/api/bridgeRepair?keyword=&status=0&startSuaChua=&endSuaChua=&bridgeId='+id.toString();
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
}