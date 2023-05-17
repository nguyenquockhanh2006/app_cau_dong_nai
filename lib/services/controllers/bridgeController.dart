import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/bridgeModel.dart';

class bridgeController {
  Future<List<bridgeModel>> getApi() async {
    final String apiUrl = 'http://171.244.8.103:9003/api/bridge?keyword=&type=';
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
  
}