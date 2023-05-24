import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter/material.dart';

class addBridgeScreen extends StatefulWidget {
  const addBridgeScreen({super.key});

  @override
  State<addBridgeScreen> createState() => _addBridgeState();
}

class _addBridgeState extends State<addBridgeScreen> {
  final MapController mapController = MapController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thêm cầu mới'),
      ),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(7),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  TextButton.icon(
                    label: Text('Thêm'),
                    icon: Icon(Icons.add),
                    onPressed: () {},
                    style: TextButton.styleFrom(
                        backgroundColor: Color(0xff7cb518),
                        foregroundColor: Colors.white,
                        elevation: 2,
                        padding: EdgeInsets.all(5)),
                  ),
                  SizedBox(
                    width: 7,
                  ),
                  TextButton.icon(
                    onPressed: () {},
                    label: Text('Làm mới'),
                    icon: Icon(Icons.restart_alt),
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        elevation: 2,
                        padding: EdgeInsets.all(5)),
                  ),
                ]),
          ),
          // Container(child: Text('h'),)
          Container(
            padding: EdgeInsets.all(7),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: ListTile(
                    leading: Icon(
                      Icons.image,
                      color: Colors.white,
                    ),
                    title: Text(
                      'HÌNH ẢNH/ BÌNH ĐỒ/ MẶT CẮT',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),

                  // margin: EdgeInsets.only(top: 7, left: 7,right: 7),
                  width: 320,
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    // borderRadius: BorderRadius.circular(7),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(7),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(7),
                        bottomLeft: Radius.circular(7),
                        bottomRight: Radius.circular(7),
                      ),
                      border: Border.all(color: Color(0xFFadb5bd))),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: Column(children: [
                            Text('Hình ảnh cầu'),
                            Image(
                                image: NetworkImage(
                                    'https://i.imgur.com/bkB4dqc.png')),
                            TextButton(
                                onPressed: () {}, child: Text('Chọn hình')),
                          ]),
                        ),
                        Container(
                          child: Column(children: [
                            Text('Ảnh bình đồ'),
                            Image(
                                image: NetworkImage(
                                    'https://i.imgur.com/bkB4dqc.png')),
                            TextButton(
                                onPressed: () {}, child: Text('Chọn hình')),
                          ]),
                        ),
                        Container(
                          child: Column(children: [
                            Text('Ảnh mặt cắt'),
                            Image(
                                image: NetworkImage(
                                    'https://i.imgur.com/bkB4dqc.png')),
                            TextButton(
                                onPressed: () {}, child: Text('Chọn hình')),
                          ]),
                        )
                      ]),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(7),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: ListTile(
                    leading: Icon(
                      Icons.image,
                      color: Colors.white,
                    ),
                    title: Text(
                      'THÔNG TIN CHUNG',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  width: 320,
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    // borderRadius: BorderRadius.circular(7),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(7),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(7),
                        bottomLeft: Radius.circular(7),
                        bottomRight: Radius.circular(7),
                      ),
                      border: Border.all(color: Color(0xFFadb5bd))),
                  child: Column(children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          Container(
                            width: 120,
                            child: Text('Tên cây cầu'),
                          ),
                          Container(
                            width: 210,
                            margin: EdgeInsets.all(7),
                            child: TextField(
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    top: 0, bottom: 0, left: 5, right: 5),
                                hintText: 'Nhập tên cầu...',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7),
                                  borderSide: BorderSide(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: 120,
                            child: Text('Loại cầu'),
                          ),
                          Container(
                            width: 210,
                            margin: EdgeInsets.all(7),
                            child: TextField(
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    top: 0, bottom: 0, left: 5, right: 5),
                                // labelText: 'Tên cầu',
                                hintText: 'Nhập loại cầu...',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7),
                                  borderSide: BorderSide(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          Container(
                            width: 120,
                            child: Text('Cấp'),
                          ),
                          Container(
                            width: 210,
                            margin: EdgeInsets.all(7),
                            child: TextField(
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    top: 0, bottom: 0, left: 5, right: 5),
                                // labelText: 'Tên cầu',
                                hintText: 'Nhập cấp...',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7),
                                  borderSide: BorderSide(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          Container(
                            width: 120,
                            child: Text('Lý trình'),
                          ),
                          Container(
                            width: 210,
                            margin: EdgeInsets.all(7),
                            child: TextField(
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    top: 0, bottom: 0, left: 5, right: 5),
                                // labelText: 'Tên cầu',
                                hintText: 'Nhập lý trình...',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7),
                                  borderSide: BorderSide(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          Container(
                            width: 120,
                            child: Text('Tải trọng'),
                          ),
                          Container(
                            width: 210,
                            margin: EdgeInsets.all(7),
                            child: TextField(
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    top: 0, bottom: 0, left: 5, right: 5),
                                // labelText: 'Tên cầu',
                                hintText: 'Nhập tải trọng...',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7),
                                  borderSide: BorderSide(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          Container(
                            width: 120,
                            child: Text('Chiều dài cầu (m)'),
                          ),
                          Container(
                            width: 210,
                            margin: EdgeInsets.all(7),
                            child: TextField(
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    top: 0, bottom: 0, left: 5, right: 5),
                                // labelText: 'Tên cầu',
                                hintText: 'Nhập chiều dài',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7),
                                  borderSide: BorderSide(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          Container(
                            width: 120,
                            child: Text('Chiều rộng cầu (m)'),
                          ),
                          Container(
                            width: 210,
                            margin: EdgeInsets.all(7),
                            child: TextField(
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    top: 0, bottom: 0, left: 5, right: 5),
                                // labelText: 'Tên cầu',
                                hintText: 'Nhập chiều rộng...',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7),
                                  borderSide: BorderSide(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),

                  // ]),
                ),
                Container(
                  margin: EdgeInsets.only(top: 7),
                  child: ListTile(
                    leading: Icon(
                      Icons.image,
                      color: Colors.white,
                    ),
                    title: Text(
                      'THÔNG TIN VỊ TRÍ',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  width: 320,
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    // borderRadius: BorderRadius.circular(7),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(7),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(7),
                        bottomLeft: Radius.circular(7),
                        bottomRight: Radius.circular(7),
                      ),
                      border: Border.all(color: Color(0xFFadb5bd))),
                  child: Column(children: [
                    Container(
                      child: Row(children: [
                        Container(
                          width: 70,
                          child: Text('Địa điểm'),
                        ),
                        Container(
                          width: 260,
                          margin: EdgeInsets.all(7),
                          child: TextField(
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(
                                  top: 0, bottom: 0, left: 5, right: 5),
                              // labelText: 'Tên cầu',
                              hintText: 'Nhập địa điểm...',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(7),
                                borderSide: BorderSide(),
                              ),
                            ),
                          ),
                        ),
                      ]),
                    ),
                    Container(
                      child: Row(children: [
                        Container(
                          width: 70,
                          child: Text('Kinh độ'),
                        ),
                        Container(
                          width: 260,
                          margin: EdgeInsets.all(7),
                          child: TextField(
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(
                                  top: 0, bottom: 0, left: 5, right: 5),
                              // labelText: 'Tên cầu',
                              hintText: 'Nhập ...',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(7),
                                borderSide: BorderSide(),
                              ),
                            ),
                          ),
                        ),
                      ]),
                    ),
                    Container(
                      child: Row(children: [
                        Container(
                          width: 70,
                          child: Text('Vĩ độ'),
                        ),
                        Container(
                          width: 260,
                          margin: EdgeInsets.all(7),
                          child: TextField(
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(
                                  top: 0, bottom: 0, left: 5, right: 5),
                              // labelText: 'Tên cầu',
                              hintText: 'Nhập ...',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(7),
                                borderSide: BorderSide(),
                              ),
                            ),
                          ),
                        ),
                      ]),
                    ),
                    Container(
                      height: 200,
                      margin: EdgeInsets.all(5),
                      child: FlutterMap(
                        mapController: mapController,
                        options: MapOptions(
                            center: LatLng(10.952772, 106.807671), zoom: 7),
                        layers: [
                          TileLayerOptions(
                            urlTemplate:
                                'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                            subdomains: ['a', 'b', 'c'],
                          ),
                          // MarkerLayerOptions(
                          //   markers: [
                          //     Marker(
                          //       point: LatLng(bridgeList[i].KinhDo,bridgeList[i].ViDo),
                          //       builder: (ctx) => Icon(
                          //       Icons.location_on,
                          //       color: Colors.blue,
                          //       size: 50.0,
                          //     ),)
                          //   ]
                          // )
                        ],
                      ),
                    )
                  ]),
                ),
                Container(
                  margin: EdgeInsets.only(top: 7),
                  child: ListTile(
                    leading: Icon(
                      Icons.image,
                      color: Colors.white,
                    ),
                    title: Text(
                      'THÔNG TIN THI CÔNG',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  width: 320,
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    // borderRadius: BorderRadius.circular(7),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(7),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(7),
                        bottomLeft: Radius.circular(7),
                        bottomRight: Radius.circular(7),
                      ),
                      border: Border.all(color: Color(0xFFadb5bd))),
                  child: Column(children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          Container(
                            width: 120,
                            child: Text('Ngày khởi công'),
                          ),
                          Container(
                            width: 210,
                            margin: EdgeInsets.all(7),
                            child: TextField(
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    top: 0, bottom: 0, left: 5, right: 5),
                                // labelText: 'Tên cầu',
                                hintText: 'Nhập ...',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7),
                                  borderSide: BorderSide(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          Container(
                            width: 120,
                            child: Text('Ngày hoàn thành'),
                          ),
                          Container(
                            width: 210,
                            margin: EdgeInsets.all(7),
                            child: TextField(
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    top: 0, bottom: 0, left: 5, right: 5),
                                // labelText: 'Tên cầu',
                                hintText: 'Nhập...',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7),
                                  borderSide: BorderSide(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          Container(
                            width: 120,
                            child: Text('Chi phí xây dựng'),
                          ),
                          Container(
                            width: 210,
                            margin: EdgeInsets.all(7),
                            child: TextField(
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    top: 0, bottom: 0, left: 5, right: 5),
                                // labelText: 'Tên cầu',
                                hintText: 'Nhập...',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7),
                                  borderSide: BorderSide(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          Container(
                            width: 120,
                            child: Text('Chủ đầu tư'),
                          ),
                          Container(
                            width: 210,
                            margin: EdgeInsets.all(7),
                            child: TextField(
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    top: 0, bottom: 0, left: 5, right: 5),
                                // labelText: 'Tên cầu',
                                hintText: 'Nhập...',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7),
                                  borderSide: BorderSide(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          Container(
                            width: 120,
                            child: Text('Đơn vị thiết kế'),
                          ),
                          Container(
                            width: 210,
                            margin: EdgeInsets.all(7),
                            child: TextField(
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    top: 0, bottom: 0, left: 5, right: 5),
                                // labelText: 'Tên cầu',
                                hintText: 'Nhập...',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7),
                                  borderSide: BorderSide(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          Container(
                            width: 120,
                            child: Text('Đơn vị thi công'),
                          ),
                          Container(
                            width: 210,
                            margin: EdgeInsets.all(7),
                            child: TextField(
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    top: 0, bottom: 0, left: 5, right: 5),
                                // labelText: 'Tên cầu',
                                hintText: 'Nhập...',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7),
                                  borderSide: BorderSide(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          Container(
                            width: 120,
                            child: Text('Đơn vị giám sát'),
                          ),
                          Container(
                            width: 210,
                            margin: EdgeInsets.all(7),
                            child: TextField(
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    top: 0, bottom: 0, left: 5, right: 5),
                                // labelText: 'Tên cầu',
                                hintText: 'Nhập...',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7),
                                  borderSide: BorderSide(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
                ),
                Container(
                  margin: EdgeInsets.only(top: 7),
                  child: ListTile(
                    leading: Icon(
                      Icons.image,
                      color: Colors.white,
                    ),
                    title: Text(
                      'CẤU TẠO CẦU',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  width: 320,
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    // borderRadius: BorderRadius.circular(7),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(7),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(7),
                        bottomLeft: Radius.circular(7),
                        bottomRight: Radius.circular(7),
                      ),
                      border: Border.all(color: Color(0xFFadb5bd))),
                  child: Column(children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          Container(
                            width: 110,
                            child: Text('Số nhịp'),
                          ),
                          Container(
                            width: 220,
                            margin: EdgeInsets.all(7),
                            child: TextField(
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    top: 0, bottom: 0, left: 5, right: 5),
                                // labelText: 'Tên cầu',
                                hintText: 'Nhập...',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7),
                                  borderSide: BorderSide(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          Container(
                            width: 110,
                            child: Text('Số mố'),
                          ),
                          Container(
                            width: 220,
                            margin: EdgeInsets.all(7),
                            child: TextField(
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    top: 0, bottom: 0, left: 5, right: 5),
                                // labelText: 'Tên cầu',
                                hintText: 'Nhập...',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7),
                                  borderSide: BorderSide(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          Container(
                            width: 110,
                            child: Text('Số trụ'),
                          ),
                          Container(
                            width: 220,
                            margin: EdgeInsets.all(7),
                            child: TextField(
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    top: 0, bottom: 0, left: 5, right: 5),
                                // labelText: 'Tên cầu',
                                hintText: 'Nhập...',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7),
                                  borderSide: BorderSide(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          Container(
                            width: 110,
                            child: Text('Số dầm ngang'),
                          ),
                          Container(
                            width: 220,
                            margin: EdgeInsets.all(7),
                            child: TextField(
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    top: 0, bottom: 0, left: 5, right: 5),
                                // labelText: 'Tên cầu',
                                hintText: 'Nhập...',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7),
                                  borderSide: BorderSide(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          Container(
                            width: 110,
                            child: Text('Số dầm chính'),
                          ),
                          Container(
                            width: 220,
                            margin: EdgeInsets.all(7),
                            child: TextField(
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    top: 0, bottom: 0, left: 5, right: 5),
                                // labelText: 'Tên cầu',
                                hintText: 'Nhập...',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7),
                                  borderSide: BorderSide(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          Container(
                            width: 110,
                            child: Text('Số lan can'),
                          ),
                          Container(
                            width: 220,
                            margin: EdgeInsets.all(7),
                            child: TextField(
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    top: 0, bottom: 0, left: 5, right: 5),
                                // labelText: 'Tên cầu',
                                hintText: 'Nhập...',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7),
                                  borderSide: BorderSide(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          Container(
                            width: 110,
                            child: Text('Số dải phân cách'),
                          ),
                          Container(
                            width: 220,
                            margin: EdgeInsets.all(7),
                            child: TextField(
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    top: 0, bottom: 0, left: 5, right: 5),
                                // labelText: 'Tên cầu',
                                hintText: 'Nhập...',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7),
                                  borderSide: BorderSide(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
                ),
                Container(
                  margin: EdgeInsets.only(top: 7),
                  child: ListTile(
                    leading: Icon(
                      Icons.image,
                      color: Colors.white,
                    ),
                    title: Text(
                      'VẬT LIỆU CẦU',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  width: 320,
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    // borderRadius: BorderRadius.circular(7),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(7),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(7),
                        bottomLeft: Radius.circular(7),
                        bottomRight: Radius.circular(7),
                      ),
                      border: Border.all(color: Color(0xFFadb5bd))),
                  child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            children: [
                              Container(
                                width: 100,
                                child: Text('Dầm chính'),
                              ),
                              Container(
                                width: 220,
                                margin: EdgeInsets.all(7),
                                child: TextField(
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(
                                        top: 0, bottom: 0, left: 5, right: 5),
                                    // labelText: 'Tên cầu',
                                    hintText: 'Nhập...',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(7),
                                      borderSide: BorderSide(),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            children: [
                              Container(
                                width: 100,
                                child: Text('Dầm ngang'),
                              ),
                              Container(
                                width: 220,
                                margin: EdgeInsets.all(7),
                                child: TextField(
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(
                                        top: 0, bottom: 0, left: 5, right: 5),
                                    // labelText: 'Tên cầu',
                                    hintText: 'Nhập...',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(7),
                                      borderSide: BorderSide(),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            children: [
                              Container(
                                width: 100,
                                child: Text('Bán mặt cầu'),
                              ),
                              Container(
                                width: 220,
                                margin: EdgeInsets.all(7),
                                child: TextField(
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(
                                        top: 0, bottom: 0, left: 5, right: 5),
                                    // labelText: 'Tên cầu',
                                    hintText: 'Nhập...',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(7),
                                      borderSide: BorderSide(),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            children: [
                              Container(
                                width: 100,
                                child: Text('Lan can'),
                              ),
                              Container(
                                width: 220,
                                margin: EdgeInsets.all(7),
                                child: TextField(
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(
                                        top: 0, bottom: 0, left: 5, right: 5),
                                    // labelText: 'Tên cầu',
                                    hintText: 'Nhập...',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(7),
                                      borderSide: BorderSide(),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            children: [
                              Container(
                                width: 100,
                                child: Text('Mố'),
                              ),
                              Container(
                                width: 220,
                                margin: EdgeInsets.all(7),
                                child: TextField(
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(
                                        top: 0, bottom: 0, left: 5, right: 5),
                                    // labelText: 'Tên cầu',
                                    hintText: 'Nhập...',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(7),
                                      borderSide: BorderSide(),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            children: [
                              Container(
                                width: 100,
                                child: Text('Trụ'),
                              ),
                              Container(
                                width: 220,
                                margin: EdgeInsets.all(7),
                                child: TextField(
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(
                                        top: 0, bottom: 0, left: 5, right: 5),
                                    // labelText: 'Tên cầu',
                                    hintText: 'Nhập...',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(7),
                                      borderSide: BorderSide(),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]),
                ),
                Container(
                  margin: EdgeInsets.only(top: 7),
                  child: ListTile(
                    leading: Icon(
                      Icons.image,
                      color: Colors.white,
                    ),
                    title: Text(
                      'KÍCH THƯỚC CẦU',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  width: 320,
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    // borderRadius: BorderRadius.circular(7),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(7),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(7),
                        bottomLeft: Radius.circular(7),
                        bottomRight: Radius.circular(7),
                      ),
                      border: Border.all(color: Color(0xFFadb5bd))),
                  child: Column(children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          Container(
                            width: 120,
                            child: Text('Chiều dài nhịp'),
                          ),
                          Container(
                            width: 210,
                            margin: EdgeInsets.all(7),
                            child: TextField(
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    top: 0, bottom: 0, left: 5, right: 5),
                                // labelText: 'Tên cầu',
                                hintText: 'Nhập...',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7),
                                  borderSide: BorderSide(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          Container(
                            width: 120,
                            child: Text('Bề rộng xe chạy (m)'),
                          ),
                          Container(
                            width: 210,
                            margin: EdgeInsets.all(7),
                            child: TextField(
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    top: 0, bottom: 0, left: 5, right: 5),
                                // labelText: 'Tên cầu',
                                hintText: 'Nhập...',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7),
                                  borderSide: BorderSide(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          Container(
                            width: 120,
                            child: Text('Khoảng cách dầm chính'),
                          ),
                          Container(
                            width: 210,
                            margin: EdgeInsets.all(7),
                            child: TextField(
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    top: 0, bottom: 0, left: 5, right: 5),
                                // labelText: 'Tên cầu',
                                hintText: 'Nhập...',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7),
                                  borderSide: BorderSide(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          Container(
                            width: 120,
                            child: Text('Khoảng cách dầm ngang'),
                          ),
                          Container(
                            width: 210,
                            margin: EdgeInsets.all(7),
                            child: TextField(
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    top: 0, bottom: 0, left: 5, right: 5),
                                // labelText: 'Tên cầu',
                                hintText: 'Nhập...',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7),
                                  borderSide: BorderSide(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          Container(
                            width: 120,
                            child: Text('Chiều cao bản mặt cầu (m)'),
                          ),
                          Container(
                            width: 210,
                            margin: EdgeInsets.all(7),
                            child: TextField(
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    top: 0, bottom: 0, left: 5, right: 5),
                                // labelText: 'Tên cầu',
                                hintText: 'Nhập...',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7),
                                  borderSide: BorderSide(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          Container(
                            width: 120,
                            child: Text('Bề rộng lan can (m)'),
                          ),
                          Container(
                            width: 210,
                            margin: EdgeInsets.all(7),
                            child: TextField(
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    top: 0, bottom: 0, left: 5, right: 5),
                                // labelText: 'Tên cầu',
                                hintText: 'Nhập...',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7),
                                  borderSide: BorderSide(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
