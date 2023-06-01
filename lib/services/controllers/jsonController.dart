import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/bridgeModel.dart';

class jsonController {
  
  Future<void> writeFileJson() async {
  const String apiUrl = 'http://171.244.8.103:9003/api/bridge?keyword=&type=';
  http.Response response = await http.get(Uri.parse(apiUrl));
  if (response.statusCode == 200) {
    var jsonResponse = json.decode(response.body);
    var data = jsonResponse["Data"];
    List<bridgeModel> bridgeList = [];
    for (var jsonModel in data) {
      bridgeList.add(bridgeModel.fromJson(jsonModel));
    }
    final List<Map<String, dynamic>> list =
        bridgeList.map((model) => model.toJson()).toList();
    //final file = File('lib/services/models/jsonModel/bridgeModelJsons.json');
    final file = File('..\\assets\\jsonDatas\\bridgeModelJsons.json');
    await file.writeAsString(json.encode(list));
  } else {
    throw Exception('Failed to load bridge data from API');
  }
}


  
  
}
