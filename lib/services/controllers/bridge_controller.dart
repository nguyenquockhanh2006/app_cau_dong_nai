// class bridge_controller {
//   Future<<>> get() async {
//     final response = await http.post(Uri.parse(ConstantUtility.API_URL + '/street/select'), headers: await HelperUtility.getHeader());
//     return ResponseArrayModel<StreetModel>.fromJson(jsonDecode(response.body), StreetModel.fromJson);
//   }
// }
import 'dart:convert';
import 'package:app_cau_dong_nai/services/models/bridge_model.dart';
import 'package:http/http.dart' as http;
//  import 'package:app_cau_dong_nai/utils/constant_utility.dart';
import 'package:app_cau_dong_nai/utils/res_model_utility.dart';

class bridge_controller {
  Future<ResponseArrayModel<bridge_model>> get_API() async {
    final String apiUrl = 'http://171.244.8.103:9003/api/bridge?keyword=&type=';
    http.Response response = await http.get(Uri.parse(apiUrl));
    //final response =   await http.get(Uri.parse(apiUrl));
    return ResponseArrayModel<bridge_model>.fromJson(
        jsonDecode(response.body), bridge_model.fromJson);
  }
}
