// class bridge_controller {
//   Future<<>> get() async {
//     final response = await http.post(Uri.parse(ConstantUtility.API_URL + '/street/select'), headers: await HelperUtility.getHeader());
//     return ResponseArrayModel<StreetModel>.fromJson(jsonDecode(response.body), StreetModel.fromJson);
//   }
// }
// Map<String, dynamic> userMap = json.decode(jsonString);
// bridgr_model user = bridgr_model.fromJson(userMap);

// class bridge_controller {
//   Future<List<bridge_model>> getAPI() async {
//     final String apiUrl = 'http://171.244.8.103:9003/api/bridge?keyword=&type=';
//     http.Response response = await http.get(Uri.parse(apiUrl));
//     Iterable jsonList = json.decode(response.body);
//     List<bridge_model> bridgeList = List<bridge_model>.from(
//         jsonList.map((model) => bridge_model.fromJson(model)));
//     return bridgeList;
//   }
// }

import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/bridge_model.dart';

class bridge_controller {
  Future<List<bridge_model>> getApi() async {
    final String apiUrl = 'http://171.244.8.103:9003/api/bridge?keyword=&type=';
    http.Response response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      var data = jsonResponse["Data"];
      List<bridge_model> bridgeList = [];
      for (var jsonModel in data) {
        bridgeList.add(bridge_model.fromJson(jsonModel));
      }
      return bridgeList;
    } else {
      throw Exception('Failed to load bridge data from API');
    }
  }
}
