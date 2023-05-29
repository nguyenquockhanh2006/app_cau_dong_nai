import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/bridgeModel.dart';

class imageController {
  Future<String> _getImageFromApi() async {
    final response = await http.get(Uri.parse('http://171.244.8.103:9003/Images/XÓM MAI_638192579627878126.jpg'));
    if (response.statusCode == 200) {
            return 'data:image/png;base64,${base64Encode(response.bodyBytes)}';
    } else {
        // Nếu response status không phải là 200 OK, log lỗi
        return "http://171.244.8.103:9003//placeholder.jpg";
    }
  }

  Future<int> postMyAPI(
    
  ) async {
    const url = 'http://171.244.8.103:9003/api/bridge';

    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(<String, dynamic>{
        
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
}
