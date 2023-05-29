import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_application_4/services/controllers/repairController.dart';
import '../../services/models/bridgeModel.dart';
import '../../services/controllers/bridgeController.dart';
import '../../services/models/repairModel.dart';
import '../../services/controllers/bridgeController.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class Detail extends StatefulWidget {
  final MapController mapController = MapController();
  final bridgeController bC = bridgeController();
  final RepairController repairController = RepairController();
  final String text;
  Detail({Key? key, required this.text}) : super(key: key);

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  late Future<List<bridgeModel>> _futureBridgeList;
  late Future<List<RepairModel>> _futureRepairList;
  @override
  void initState() {
    super.initState();
    _futureBridgeList = widget.bC.getApi();
    _futureRepairList = widget.repairController.getApi();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.text.toUpperCase(),
          ),
        ),
        body: SingleChildScrollView(
          child: FutureBuilder<List<bridgeModel>>(
            future: _futureBridgeList,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<bridgeModel>? bridgeList = snapshot.data;
                for (int i = 0; i < bridgeList!.length; i++) {
                  if (bridgeList[i].TenCayCau.toString() ==
                      widget.text.toString()) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 200,
                          width: MediaQuery.of(context).size.width,
                          child: Center(
                            child: Image.network(
                              bridgeList[i].HinhAnhCau != ""
                                  ? 'http://171.244.8.103:9003/' +
                                      bridgeList[i].HinhAnhCau
                                  : 'http://171.244.8.103:9003//placeholder.jpg',
                              height: 180,
                              width:
                                  MediaQuery.of(context).size.width * 3.8 / 4,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          child: Center(
                              child: ListTile(
                            leading: Icon(
                              Icons.info,
                              color: Colors.white,
                            ),
                            title: Text(
                              'THÔNG TIN CẦU',
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                          margin: EdgeInsets.only(top: 7, left: 7, right: 7),
                          width: 210,
                          height: 45,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            // borderRadius: BorderRadius.circular(7),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 7, right: 7, bottom: 7),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(7),
                                bottomLeft: Radius.circular(7),
                                bottomRight: Radius.circular(7),
                              ),
                              border: Border.all(color: Color(0xFFadb5bd))),
                          child: Row(children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.only(left: 5),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Tên cây cầu'),
                                    SizedBox(height: 8),
                                    Text('Loại cầu'),
                                    SizedBox(height: 8),
                                    Text('Cấp'),
                                    SizedBox(height: 8),
                                    Text('Lý trình'),
                                    SizedBox(height: 8),
                                    Text('Tải trọng'),
                                    SizedBox(height: 8),
                                    Text('Chiều dài cầu (m)'),
                                    SizedBox(height: 8),
                                    Text('Chiều rộng cầu (m)'),
                                  ]),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(bridgeList[i].TenCayCau),
                                    SizedBox(height: 8),
                                    Text(bridgeList[i].LoaiCau),
                                    SizedBox(height: 8),
                                    Text(bridgeList[i].Cap),
                                    SizedBox(height: 8),
                                    Text(bridgeList[i].LyTrinh),
                                    SizedBox(height: 8),
                                    Text(bridgeList[i].TaiTrong),
                                    SizedBox(height: 8),
                                    Text(bridgeList[i].ChieuDai),
                                    SizedBox(height: 8),
                                    Text(bridgeList[i].ChieuRong),
                                  ]),
                            ),
                          ]),
                        ),
                        Container(
                          child: Center(
                              child: ListTile(
                            leading: Icon(
                              Icons.location_on,
                              color: Colors.white,
                            ),
                            title: Text(
                              'VỊ TRÍ CẦU',
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                          margin: EdgeInsets.only(top: 7, left: 7, right: 7),
                          width: 210,
                          height: 45,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            // borderRadius: BorderRadius.circular(7),
                          ),
                        ),
                        Container(
                            margin:
                                EdgeInsets.only(left: 7, right: 7, bottom: 7),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(7),
                                  bottomLeft: Radius.circular(7),
                                  bottomRight: Radius.circular(7),
                                ),
                                border: Border.all(color: Color(0xFFadb5bd))),
                            child: Column(
                              children: [
                                Row(children: [
                                  Container(
                                    width: 80,
                                    padding: EdgeInsets.all(10),
                                    margin: EdgeInsets.only(left: 5),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Địa điểm'),
                                          SizedBox(height: 8),
                                          Text('Kinh độ'),
                                          SizedBox(height: 8),
                                          Text('Vĩ độ'),
                                        ]),
                                  ),
                                  Container(
                                    width: 270,
                                    padding: EdgeInsets.all(10),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(bridgeList[i].DiaDiem,
                                              softWrap: true),
                                          SizedBox(height: 8),
                                          Text(bridgeList[i].KinhDo.toString()),
                                          SizedBox(height: 8),
                                          Text(bridgeList[i].ViDo.toString()),
                                        ]),
                                  ),
                                ]),
                                Container(
                                  height: 200,
                                  margin: EdgeInsets.all(5),
                                  child: FlutterMap(
                                    options: MapOptions(
                                        center: LatLng(bridgeList[i].KinhDo,
                                            bridgeList[i].ViDo),
                                        zoom: 14),
                                    layers: [
                                      TileLayerOptions(
                                        urlTemplate:
                                            'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                                        subdomains: ['a', 'b', 'c'],
                                      ),
                                      MarkerLayerOptions(markers: [
                                        Marker(
                                          point: LatLng(bridgeList[i].KinhDo,
                                              bridgeList[i].ViDo),
                                          builder: (ctx) => Icon(
                                            Icons.location_on,
                                            color: Colors.blue,
                                            size: 50.0,
                                          ),
                                        )
                                      ])
                                    ],
                                  ),
                                )
                              ],
                            )),
                        Container(
                          child: Center(
                              child: ListTile(
                            leading: Icon(
                              Icons.construction,
                              color: Colors.white,
                            ),
                            title: Text(
                              'THI CÔNG CẦU',
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                          margin: EdgeInsets.only(top: 7, left: 7, right: 7),
                          width: 210,
                          height: 45,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            // borderRadius: BorderRadius.circular(7),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 7, right: 7, bottom: 7),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(7),
                                bottomLeft: Radius.circular(7),
                                bottomRight: Radius.circular(7),
                              ),
                              border: Border.all(color: Color(0xFFadb5bd))),
                          child: Row(children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.only(left: 5),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Ngày khởi công'),
                                    SizedBox(height: 8),
                                    Text('Ngày hoàn thành'),
                                    SizedBox(height: 8),
                                    Text('Chi phí xây dựng'),
                                    SizedBox(height: 8),
                                    Text('Chủ đầu tư'),
                                    SizedBox(height: 8),
                                    Text('Đơn vị thiết kế'),
                                    SizedBox(height: 8),
                                    Text('Đơn vị thi công'),
                                    SizedBox(height: 8),
                                    Text('Đơn vị đánh giá'),
                                  ]),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(bridgeList[i].NgayKhoiCong),
                                    SizedBox(height: 8),
                                    Text(bridgeList[i].NgayHoanThanh),
                                    SizedBox(height: 8),
                                    Text(bridgeList[i].Cap),
                                    SizedBox(height: 8),
                                    Text(bridgeList[i].LyTrinh),
                                    SizedBox(height: 8),
                                    Text(bridgeList[i].TaiTrong),
                                    SizedBox(height: 8),
                                    Text(bridgeList[i].ChieuDai),
                                    SizedBox(height: 8),
                                    Text(bridgeList[i].ChieuRong),
                                  ]),
                            ),
                          ]),
                        ),
                        Container(
                          child: Center(
                              child: ListTile(
                            leading: Icon(
                              Icons.build,
                              color: Colors.white,
                            ),
                            title: Text(
                              'CẤU TẠO CẦU',
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                          margin: EdgeInsets.only(top: 7, left: 7, right: 7),
                          width: 210,
                          height: 45,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            // borderRadius: BorderRadius.circular(7),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 7, right: 7, bottom: 7),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(7),
                                bottomLeft: Radius.circular(7),
                                bottomRight: Radius.circular(7),
                              ),
                              border: Border.all(color: Color(0xFFadb5bd))),
                          child: Row(children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.only(left: 5),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Số nhịp'),
                                    SizedBox(height: 8),
                                    Text('Số mố'),
                                    SizedBox(height: 8),
                                    Text('Số trụ'),
                                    SizedBox(height: 8),
                                    Text('Số dầm ngang'),
                                    SizedBox(height: 8),
                                    Text('Số dầm chính'),
                                    SizedBox(height: 8),
                                    Text('Số lan can'),
                                    SizedBox(height: 8),
                                    Text('Số dải phân cách'),
                                  ]),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(bridgeList[i].TenCayCau),
                                    SizedBox(height: 8),
                                    Text(bridgeList[i].LoaiCau),
                                    SizedBox(height: 8),
                                    Text(bridgeList[i].Cap),
                                    SizedBox(height: 8),
                                    Text(bridgeList[i].LyTrinh),
                                    SizedBox(height: 8),
                                    Text(bridgeList[i].TaiTrong),
                                    SizedBox(height: 8),
                                    Text(bridgeList[i].ChieuDai),
                                    SizedBox(height: 8),
                                    Text(bridgeList[i].ChieuRong),
                                  ]),
                            ),
                          ]),
                        ),
                        Container(
                          child: Center(
                              child: ListTile(
                            leading: Icon(
                              Icons.store,
                              color: Colors.white,
                            ),
                            title: Text(
                              'VẬT LIỆU CẦU',
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                          margin: EdgeInsets.only(top: 7, left: 7, right: 7),
                          width: 210,
                          height: 45,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            // borderRadius: BorderRadius.circular(7),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 7, right: 7, bottom: 7),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(7),
                                bottomLeft: Radius.circular(7),
                                bottomRight: Radius.circular(7),
                              ),
                              border: Border.all(color: Color(0xFFadb5bd))),
                          child: Row(children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.only(left: 5),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Dầm chính'),
                                    SizedBox(height: 8),
                                    Text('Dầm ngang'),
                                    SizedBox(height: 8),
                                    Text('Bán mặt cầu'),
                                    SizedBox(height: 8),
                                    Text('Lan can'),
                                    SizedBox(height: 8),
                                    Text('Mố '),
                                    SizedBox(height: 8),
                                    Text('Trụ'),
                                  ]),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(bridgeList[i].TenCayCau),
                                    SizedBox(height: 8),
                                    Text(bridgeList[i].LoaiCau),
                                    SizedBox(height: 8),
                                    Text(bridgeList[i].Cap),
                                    SizedBox(height: 8),
                                    Text(bridgeList[i].LyTrinh),
                                    SizedBox(height: 8),
                                    Text(bridgeList[i].TaiTrong),
                                    SizedBox(height: 8),
                                    Text(bridgeList[i].ChieuDai),
                                  ]),
                            ),
                          ]),
                        ),
                        Container(
                          child: Center(
                              child: ListTile(
                            leading: Icon(
                              Icons.rule,
                              color: Colors.white,
                            ),
                            title: Text(
                              'KÍCH THƯỚC CẦU',
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                          margin: EdgeInsets.only(top: 7, left: 7, right: 7),
                          width: 215,
                          height: 45,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            // borderRadius: BorderRadius.circular(7),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 7, right: 7, bottom: 7),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(7),
                                bottomLeft: Radius.circular(7),
                                bottomRight: Radius.circular(7),
                              ),
                              border: Border.all(color: Color(0xFFadb5bd))),
                          child: Row(children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.only(left: 5),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Chiều dài nhịp'),
                                    SizedBox(height: 8),
                                    Text('Bề rộng xe chạy (m)'),
                                    SizedBox(height: 8),
                                    Text('Khoảng cách dầm chính (m)'),
                                    SizedBox(height: 8),
                                    Text('Khoảng cách dầm ngang (m)'),
                                    SizedBox(height: 8),
                                    Text('Bề rộng lề bộ hành (m)'),
                                    SizedBox(height: 8),
                                    Text('Bề rộng lan can (m)'),
                                  ]),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(bridgeList[i].TenCayCau),
                                    SizedBox(height: 8),
                                    Text(bridgeList[i].LoaiCau),
                                    SizedBox(height: 8),
                                    Text(bridgeList[i].Cap),
                                    SizedBox(height: 8),
                                    Text(bridgeList[i].LyTrinh),
                                    SizedBox(height: 8),
                                    Text(bridgeList[i].TaiTrong),
                                    SizedBox(height: 8),
                                    Text(bridgeList[i].ChieuDai),
                                  ]),
                            ),
                          ]),
                        ),
                        Container(
                          child: Center(
                              child: ListTile(
                            leading: Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                            title: Text(
                              'SỬA CHỮA/ KIỂM TRA',
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                          margin: EdgeInsets.only(top: 7, left: 7, right: 7),
                          width: 245,
                          height: 45,
                          decoration: BoxDecoration(
                            color: Color(0Xfffb8500),
                            // borderRadius: BorderRadius.circular(7),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 7, right: 7, bottom: 7),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(7),
                                bottomLeft: Radius.circular(7),
                                bottomRight: Radius.circular(7),
                              ),
                              border: Border.all(color: Color(0xFFadb5bd))),
                          child: Row(children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.only(left: 5),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Ngày kiểm tra'),
                                    SizedBox(height: 8),
                                    Text('Loại hư hỏng'),
                                    SizedBox(height: 8),
                                    Text('Ngày sửa chữa'),
                                    SizedBox(height: 8),
                                    Text('Chi phí sửa chữa'),
                                  ]),
                            ),
                          ]),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: Center(
                              child: Container(
                                  width: 300,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Color(0xff38b000), width: 1.5),
                                      borderRadius: BorderRadius.circular(8)),
                                  child: ListTile(
                                    leading: Icon(
                                      Icons.add,
                                      color: Color(0xff38b000),
                                    ),
                                    title: Text(
                                      'THÊM KIỂM TRA/ SỬA CHỮA',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Color(0xff38b000)),
                                    ),
                                  ))),
                        )
                      ],
                    );
                  }
                }
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return CircularProgressIndicator();
            },
          ),
        ));
  }
}
