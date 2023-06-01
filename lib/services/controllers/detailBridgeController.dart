import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/detailBridgeModel.dart';

class detailBridgeController {
  Future<detailBridgeModel> getApiById(int id) async {
    final String apiUrl = 'http://171.244.8.103:9003/api/bridge/$id';
    http.Response response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      var data = jsonResponse["Data"];
      return detailBridgeModel.fromJson(data);
    } else {
      throw Exception('Failed to load bridge data from API');
    }
  }

  Future<List<detailBridgeModel>> getApi() async {
    const String apiUrl = 'http://171.244.8.103:9003/api/bridge/';
    http.Response response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      var data = jsonResponse["Data"];
      List<detailBridgeModel> detailBridgeList = [];
      for (var jsonModel in data) {
        detailBridgeList.add(detailBridgeModel.fromJson(jsonModel));
      }
      return detailBridgeList;
    } else {
      throw Exception('Failed to load bridge data from API');
    }
  }
}
