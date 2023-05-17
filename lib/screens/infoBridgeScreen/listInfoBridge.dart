import 'package:flutter/material.dart';
import 'package:flutter_application_4/screens/infoBridgeScreen/infoBridge.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../services/controllers/bridgeController.dart';
import '../../services/models/bridgeModel.dart';


class listInfoBridge extends StatefulWidget {
  final bridgeController bC = bridgeController();

  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<listInfoBridge> {
  late Future<List<bridgeModel>> _futureBridgeList;

  @override
  void initState() {
    super.initState();
    _futureBridgeList = widget.bC.getApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'QUẢN LÍ THÔNG TIN CẦU',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            // Các widget khác trong body
            //Text("data"),
            // FutureBuilder
            FutureBuilder<List<bridgeModel>>(
              future: _futureBridgeList,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<bridgeModel>? bridgeList = snapshot.data;
                  return Expanded(
                    child: ListView.builder(
                      itemCount: bridgeList!.length,
                      itemBuilder: (context, index) {
                        return Center(
                          child:
                              infoBridge(bridgeModelTemp: bridgeList[index]),
                        );
                      },
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                // Hiển thị tiêu đề khi đang chờ Future hoàn thành
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
