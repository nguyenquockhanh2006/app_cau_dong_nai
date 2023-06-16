import 'package:flutter/material.dart';
import 'package:flutter_application_4/services/controllers/detailBridgeController.dart';
import 'package:flutter_application_4/services/models/detailBridgeModel.dart';
import '../../services/controllers/bridgeController.dart';
import '../../services/models/repairModel.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class Detail extends StatefulWidget {
  final MapController mapController = MapController();
  final bridgeController bC = bridgeController();
  final detailBridgeController dBC = detailBridgeController();
  final String text;
  final int idBridge;
  Detail({Key? key, required this.text, required this.idBridge})
      : super(key: key);
  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  late Future<List<RepairModel>> _futureRepairList;
  late Future<detailBridgeModel> _futureDetailBridge;
  @override
  void initState() {
    super.initState();
    //_futureBridgeList = widget.bC.getApi();
    _futureRepairList = widget.bC.getApiById(widget.idBridge);
    _futureDetailBridge = widget.dBC.getApiById(widget.idBridge);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.text.toUpperCase(),
          ),
        ),
        body: SingleChildScrollView(
          child: FutureBuilder<detailBridgeModel>(
            future: _futureDetailBridge,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                detailBridgeModel? _futureDetailBridge = snapshot.data;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: Image.network(
                          _futureDetailBridge?.hinhAnhCau as String != ""
                              ? 'http://171.244.8.103:9003/${_futureDetailBridge?.hinhAnhCau as String}'
                              : 'http://171.244.8.103:9003//placeholder.jpg',
                          height: 180,
                          width: MediaQuery.of(context).size.width * 3.8 / 4,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 7, left: 7, right: 7),
                      width: 210,
                      height: 45,
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                        // borderRadius: BorderRadius.circular(7),
                      ),
                      child: const Center(
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
                    ),
                    Container(
                      margin:
                          const EdgeInsets.only(left: 7, right: 7, bottom: 7),
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(7),
                            bottomLeft: Radius.circular(7),
                            bottomRight: Radius.circular(7),
                          ),
                          border: Border.all(color: const Color(0xFFadb5bd))),
                      child: Row(children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.only(left: 5),
                          child: const Column(
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
                          padding: const EdgeInsets.all(10),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(_futureDetailBridge?.tenCayCau as String),
                                const SizedBox(height: 8),
                                Text(_futureDetailBridge?.loaiCau as String),
                                const SizedBox(height: 8),
                                Text(_futureDetailBridge?.cap as String),
                                const SizedBox(height: 8),
                                Text(_futureDetailBridge?.lyTrinh as String),
                                const SizedBox(height: 8),
                                Text(_futureDetailBridge?.taiTrong as String),
                                const SizedBox(height: 8),
                                Text(_futureDetailBridge?.chieuDai as String),
                                const SizedBox(height: 8),
                                Text(_futureDetailBridge?.chieuRong as String),
                              ]),
                        ),
                      ]),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 7, left: 7, right: 7),
                      width: 210,
                      height: 45,
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                        // borderRadius: BorderRadius.circular(7),
                      ),
                      child: const Center(
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
                    ),
                    Container(
                        margin:
                            const EdgeInsets.only(left: 7, right: 7, bottom: 7),
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(7),
                              bottomLeft: Radius.circular(7),
                              bottomRight: Radius.circular(7),
                            ),
                            border: Border.all(color: const Color(0xFFadb5bd))),
                        child: Column(
                          children: [
                            Row(children: [
                              Container(
                                width: 80,
                                padding: const EdgeInsets.all(10),
                                margin: const EdgeInsets.only(left: 5),
                                child: const Column(
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
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          _futureDetailBridge?.diaDiem
                                              as String,
                                          softWrap: true),
                                      const SizedBox(height: 8),
                                      Text((_futureDetailBridge?.kinhDo
                                              as double)
                                          .toString()),
                                      const SizedBox(height: 8),
                                      Text((_futureDetailBridge?.viDo as double)
                                          .toString()),
                                    ]),
                              ),
                            ]),
                            Container(
                              height: 200,
                              margin: const EdgeInsets.all(5),
                              child: FlutterMap(
                                options: MapOptions(
                                    center: LatLng(
                                        _futureDetailBridge?.kinhDo as double,
                                        _futureDetailBridge?.viDo as double),
                                    zoom: 14),
                                layers: [
                                  TileLayerOptions(
                                    urlTemplate:
                                        'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                                    subdomains: ['a', 'b', 'c'],
                                  ),
                                  MarkerLayerOptions(markers: [
                                    Marker(
                                      point: LatLng(
                                          _futureDetailBridge?.kinhDo as double,
                                          _futureDetailBridge?.viDo as double),
                                      builder: (ctx) => const Icon(
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
                      margin: const EdgeInsets.only(top: 7, left: 7, right: 7),
                      width: 210,
                      height: 45,
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                        // borderRadius: BorderRadius.circular(7),
                      ),
                      child: const Center(
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
                    ),
                    Container(
                      margin:
                          const EdgeInsets.only(left: 7, right: 7, bottom: 7),
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(7),
                            bottomLeft: Radius.circular(7),
                            bottomRight: Radius.circular(7),
                          ),
                          border: Border.all(color: const Color(0xFFadb5bd))),
                      child: Row(children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.only(left: 5),
                          child: const Column(
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
                          padding: const EdgeInsets.all(10),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(_futureDetailBridge?.ngayKhoiCong
                                    as String),
                                const SizedBox(height: 8),
                                Text(_futureDetailBridge?.ngayHoanThanh
                                    as String),
                                const SizedBox(height: 8),
                                Text((_futureDetailBridge?.chiPhiXayDung as int)
                                    .toString()),
                                const SizedBox(height: 8),
                                Text(_futureDetailBridge?.chuDauTu as String),
                                const SizedBox(height: 8),
                                Text(_futureDetailBridge?.donViThietKe
                                    as String),
                                const SizedBox(height: 8),
                                Text(_futureDetailBridge?.donViThiCong
                                    as String),
                                const SizedBox(height: 8),
                                Text(_futureDetailBridge?.donViGiamSat
                                    as String),
                              ]),
                        ),
                      ]),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 7, left: 7, right: 7),
                      width: 210,
                      height: 45,
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                        // borderRadius: BorderRadius.circular(7),
                      ),
                      child: const Center(
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
                    ),
                    Container(
                      margin:
                          const EdgeInsets.only(left: 7, right: 7, bottom: 7),
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(7),
                            bottomLeft: Radius.circular(7),
                            bottomRight: Radius.circular(7),
                          ),
                          border: Border.all(color: const Color(0xFFadb5bd))),
                      child: Row(children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.only(left: 5),
                          child: const Column(
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
                          padding: const EdgeInsets.all(10),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text((_futureDetailBridge?.soNhip as int)
                                    .toString()),
                                const SizedBox(height: 8),
                                Text((_futureDetailBridge?.soMo as int)
                                    .toString()),
                                const SizedBox(height: 8),
                                Text((_futureDetailBridge?.soTru as int)
                                    .toString()),
                                const SizedBox(height: 8),
                                Text((_futureDetailBridge?.soDamNgang as int)
                                    .toString()),
                                const SizedBox(height: 8),
                                Text((_futureDetailBridge?.soDamChinh as int)
                                    .toString()),
                                const SizedBox(height: 8),
                                Text((_futureDetailBridge?.soLanCan as int)
                                    .toString()),
                                const SizedBox(height: 8),
                                Text((_futureDetailBridge?.soDaiPhanCach as int)
                                    .toString()),
                              ]),
                        ),
                      ]),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 7, left: 7, right: 7),
                      width: 210,
                      height: 45,
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                        // borderRadius: BorderRadius.circular(7),
                      ),
                      child: const Center(
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
                    ),
                    Container(
                      margin:
                          const EdgeInsets.only(left: 7, right: 7, bottom: 7),
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(7),
                            bottomLeft: Radius.circular(7),
                            bottomRight: Radius.circular(7),
                          ),
                          border: Border.all(color: const Color(0xFFadb5bd))),
                      child: Row(children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.only(left: 5),
                          child: const Column(
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
                          padding: const EdgeInsets.all(10),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(_futureDetailBridge?.damChinh as String),
                                const SizedBox(height: 8),
                                Text(_futureDetailBridge?.damNgang as String),
                                const SizedBox(height: 8),
                                Text(_futureDetailBridge?.banMatCau as String),
                                const SizedBox(height: 8),
                                Text(_futureDetailBridge?.lanCan as String),
                                const SizedBox(height: 8),
                                Text(_futureDetailBridge?.mo as String),
                                const SizedBox(height: 8),
                                Text(_futureDetailBridge?.tru as String),
                              ]),
                        ),
                      ]),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 7, left: 7, right: 7),
                      width: 215,
                      height: 45,
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                        // borderRadius: BorderRadius.circular(7),
                      ),
                      child: const Center(
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
                    ),
                    Container(
                      margin:
                          const EdgeInsets.only(left: 7, right: 7, bottom: 7),
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(7),
                            bottomLeft: Radius.circular(7),
                            bottomRight: Radius.circular(7),
                          ),
                          border: Border.all(color: const Color(0xFFadb5bd))),
                      child: Row(children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.only(left: 5),
                          child: const Column(
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
                                Text('Chiều cao bán mặt cầu (m)'),
                                SizedBox(height: 8),
                                Text('Bề rộng lan can (m)'),
                              ]),
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text((_futureDetailBridge?.chieuDaiNhip
                                        as double)
                                    .toString()),
                                const SizedBox(height: 8),
                                Text((_futureDetailBridge?.beRongXeChay
                                        as double)
                                    .toString()),
                                const SizedBox(height: 8),
                                Text((_futureDetailBridge?.khoangCachDamChinh
                                        as double)
                                    .toString()),
                                const SizedBox(height: 8),
                                Text((_futureDetailBridge?.khoanCachDamNgang
                                        as double)
                                    .toString()),
                                const SizedBox(height: 8),
                                Text((_futureDetailBridge?.chieuCaoBanMatCau
                                        as double)
                                    .toString()),
                                const SizedBox(height: 8),
                                Text((_futureDetailBridge?.beRongLanCan
                                        as double)
                                    .toString()),
                              ]),
                        ),
                      ]),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 7, left: 7, right: 7),
                      width: 245,
                      height: 45,
                      decoration: const BoxDecoration(
                        color: Color(0Xfffb8500),
                        // borderRadius: BorderRadius.circular(7),
                      ),
                      child: const Center(
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
                    ),
                    Container(
                      margin:
                          const EdgeInsets.only(left: 7, right: 7, bottom: 7),
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(7),
                            bottomLeft: Radius.circular(7),
                            bottomRight: Radius.circular(7),
                          ),
                          border: Border.all(color: const Color(0xFFadb5bd))),
                      child: FutureBuilder<List<RepairModel>>(
                        future: _futureRepairList,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List<RepairModel>? bridgeList = snapshot.data;
                            return Container(
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: bridgeList!.length,
                                itemBuilder: (context, index) {
                                  //
                                  return Container(
                                    margin: const EdgeInsets.only(
                                        left: 7, right: 7, bottom: 7),
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.only(
                                          topRight: Radius.circular(7),
                                          bottomLeft: Radius.circular(7),
                                          bottomRight: Radius.circular(7),
                                        ),
                                        border: Border.all(
                                            color: const Color(0xFFadb5bd))),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            const SizedBox(
                                              width: 120,
                                              child: Text(
                                                'Ngày kiểm tra: ',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                bridgeList[index].NgayKiemTra
                                                    as String,
                                                style: TextStyle(fontSize: 18),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          children: [
                                            const SizedBox(
                                              width: 120,
                                              child: Text(
                                                'Loại hư hỏng: ',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                bridgeList[index].LoaiHuHong
                                                    as String,
                                                style: TextStyle(fontSize: 18),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          children: [
                                            const SizedBox(
                                              width: 120,
                                              child: Text(
                                                'Ngày sửa chửa: ',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                bridgeList[index].NgaySuaChua
                                                    as String,
                                                style: TextStyle(fontSize: 18),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          children: [
                                            const SizedBox(
                                              width: 120,
                                              child: Text(
                                                'Chi phí: ',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                (bridgeList[index].ChiPhiSuaChua
                                                        as int)
                                                    .toString(),
                                                style: TextStyle(fontSize: 18),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            );
                          } else if (snapshot.hasError) {
                            return Text("${snapshot.error}");
                          }
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      ),
                    ),
                    // Container(
                    //   margin: const EdgeInsets.only(bottom: 10),
                    //   child: Center(
                    //     child: InkWell(
                    //       onTap: () {
                    //       },
                    //       child: Container(
                    //           width: 300,
                    //           decoration: BoxDecoration(
                    //               border: Border.all(
                    //                   color: const Color(0xff38b000),
                    //                   width: 1.5),
                    //               borderRadius: BorderRadius.circular(8)),
                    //           child: const ListTile(
                    //             leading: Icon(
                    //               Icons.add,
                    //               color: Color(0xff38b000),
                    //             ),
                    //             title: Text(
                    //               'THÊM KIỂM TRA/ SỬA CHỮA',
                    //               style: TextStyle(
                    //                   fontSize: 16,
                    //                   color: Color(0xff38b000)),
                    //             ),
                    //           )),
                    //     ),
                    //   ),
                    // )
                  ],
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return const CircularProgressIndicator();
            },
          ),
        ));
  }
}
