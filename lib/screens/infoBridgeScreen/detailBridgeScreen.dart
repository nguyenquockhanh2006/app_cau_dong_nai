import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../../services/controllers/detailBridgeController.dart';
import '../../services/models/detailBridgeModel.dart';
import 'package:flutter_application_4/screens/homeScreen/menu.dart';

class detailBridgeScreen extends StatefulWidget {
  final Future<detailBridgeModel> dBM;
  const detailBridgeScreen({Key? key, required this.dBM}) : super(key: key);
  @override
  _detailBridgeScreenState createState() => _detailBridgeScreenState();
}

class _detailBridgeScreenState extends State<detailBridgeScreen> {
  late detailBridgeModel _dBM;

  void initState() {
    super.initState();
    fetchDetailBridge();
  }

  // Hàm truyền vào Future để đợi kết quả trả về
  Future<void> fetchDetailBridge() async {
    detailBridgeModel dBM = await widget.dBM;
    setState(() {
      _dBM = dBM;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Hiển thị dữ liệu của dBM khi đã được tải về
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('CẦU ĐỒNG NAI'),
          leading: CircleAvatar(
            backgroundImage: NetworkImage('https://i.imgur.com/vHZ2Ewl.png'),
          ),
        ),
        endDrawer: menu(),
        body: Container(
          child: Text(_dBM.tenCayCau),
        ),
      ),
    );
  }
}

