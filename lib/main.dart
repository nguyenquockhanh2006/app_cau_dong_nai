// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// Future<String> getUsers() async {
//   final String apiUrl = 'http://171.244.8.103:9003/api/bridge?keyword=&type=';
//   http.Response response = await http.get(Uri.parse(apiUrl));
//   if (response.statusCode == 200) {
   
//     return "thanh cong";
//   } else {
//     throw Exception('Lỗi khi lấy dữ liệu từ API');
//   }
// }
// void main() async {
//   try {
//     String users = await getUsers();
//     print(users);
//   } catch (e) {
//     print('Lỗi khi lấy dữ liệu: $e');
//   }
// }

import 'package:flutter/material.dart';
import 'package:app_cau_dong_nai/views/home_views/home.dart';
void main(){
  runApp(home());
}
