// class bridge_controller {
//   Future<<>> get() async {
//     final response = await http.post(Uri.parse(ConstantUtility.API_URL + '/street/select'), headers: await HelperUtility.getHeader());
//     return ResponseArrayModel<StreetModel>.fromJson(jsonDecode(response.body), StreetModel.fromJson);
//   }
// }