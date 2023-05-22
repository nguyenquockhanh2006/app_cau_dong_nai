// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_application_4/screens/homeScreen/mapScreen.dart';
// import 'package:flutter_application_4/screens/homeScreen/listScreen.dart';
// import 'package:flutter_application_4/screens/homeScreen/menu.dart';
// import 'package:flutter_application_4/services/controllers/bridgeController.dart';
// import 'package:flutter_application_4/services/controllers/repairController.dart';
// import 'package:flutter_application_4/services/models/bridgeModel.dart';
// import 'package:flutter_application_4/services/models/repairModel.dart';
// class dropdownButtonListBridge extends StatefulWidget {
//   @override
//   final bridgeController bC = bridgeController();
//   _DropdownExampleState createState() => _DropdownExampleState();
// }

// class _DropdownExampleState extends State<dropdownButtonListBridge> {
//   late Future<List<bridgeModel>> _futureBridgeList;
//   String selectedFlower = 'Rose';
//   List<String> items = [];
//   void initState() {
//     super.initState();
//     _futureBridgeList = widget.bC.getApi();
//   }
//   @override
//   Widget build(BuildContext context) {
    
//     return DropdownButton<String>(
//       value: selectedFlower,
//       onChanged: (String? newValue) {
//         setState(() {
//           selectedFlower = newValue!;
//         });
//       },
//       items: .map<DropdownMenuItem<String>>((String value) {
//         return DropdownMenuItem<String>(
//           value: value,
//           child: Text(value),
//         );
//       }).toList(),
//     );
//   }
// }
