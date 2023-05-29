//addBridgeScreen
// import 'dart:html';
import 'package:flutter_application_4/services/controllers/bridgeController.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
class addBridgeScreen extends StatefulWidget {
  const addBridgeScreen({super.key});
  @override
  State<addBridgeScreen> createState() => _addBridgeState();
}
class _addBridgeState extends State<addBridgeScreen> {
  final bridgeController bC = bridgeController();
  final MapController mapController = MapController();
  final TextEditingController _controllerlat = TextEditingController();
  final TextEditingController _controllerlng = TextEditingController();
  final TextEditingController _ngaykhoicong = TextEditingController();
  final TextEditingController _ngayhoanthanh = TextEditingController();
  DateTime NKhoiCong = DateTime.now();
  DateTime NHoanThanh = DateTime.now();
  // biến kết quả thêm trả về của hàm postApi
  int result = 0;
  // hình ảnh
  String anhCayCau = "";
  String anhMatCat = "";
  String anhBinhDo = "";
  // thông tin chung
  String tenCayCau = "Cau Text";
  String loaiCau = "";
  String cap = "";
  String lyTrinh = "";
  String taiTrong = "";
  String chieuDai = "";
  String chieuRong = "";
  String diaDiem = "";
  double kinhDo = 10.96701421956938;
  double viDo = 10.96701421956938;
  // thông tin thi công
  String ngayKhoiCong = "0001-01-01";
  String ngayHoanThanh = "0001-01-01";
  // ignore: avoid_init_to_null
  int? chiPhiXayDung = null;
  String chuDauTu = "";
  String donViThietKe = "";
  String donViThiCong = "";
  String donViGiamSat = "";
  // cấu tạo cầu
  int soNhip = 0;
  int soMo = 0;
  int soTru = 0;
  int soDamNgang = 0;
  int soDamChinh = 0;
  int soLanCan = 0;
  int soDaiPhanCach = 0;
  // vật liệu cầu
  String vlDamChinh = "";
  String vlDamNgang = "";
  String vlBanMatCau = "";
  String vlLanCan = "";
  String vlMo = "";
  String vlTru = "";
  // kích thước cầu
  double chieuDaiNhip = 0.0;
  double beRongXeChay = 0.0;
  double khoangCachDamChinh = 0.0;
  double khoangCachDamNgang = 0.0;
  double chieuCaoBanMatCau = 0.0;
  double beRongLanCan = 0.0;

  // File? _image;
  // final picker = ImagePicker();
  // // Future<void> _getImage() async {
  // //   final pickedFile = await picker.pickImage(source: ImageSource.gallery);
  // //   if (pickedFile != null) {
  // //     setState(() {
  // //       _image = File(pickedFile.path);
  // //     });
  // //   }
  // // }
  @override
  void initState() {
    super.initState();
    _controllerlat.text = '';
    _controllerlng.text = '';
  }

  // hàm thêm

  void addBridge() async {
    result = await bC.postMyAPI(
        anhCayCau,
        anhMatCat,
        anhBinhDo,
        tenCayCau,
        loaiCau,
        cap,
        lyTrinh,
        taiTrong,
        chieuDai,
        chieuRong,
        diaDiem,
        kinhDo,
        viDo,
        ngayKhoiCong,
        ngayHoanThanh,
        chiPhiXayDung,
        chuDauTu,
        donViThietKe,
        donViThiCong,
        donViGiamSat,
        soNhip,
        soMo,
        soTru,
        soDamNgang,
        soDamChinh,
        soLanCan,
        soDaiPhanCach,
        vlDamChinh,
        vlDamNgang,
        vlBanMatCau,
        vlLanCan,
        vlMo,
        vlTru,
        chieuDaiNhip,
        beRongXeChay,
        khoangCachDamChinh,
        khoangCachDamNgang,
        chieuCaoBanMatCau,
        beRongLanCan);

    if (result == 200) {
      print('thành công');
    } else {
      print('thất bại');
    }
  }

  //
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
                    onPressed: () => {
                      addBridge(),
                    },
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
                  width: 320,
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.blue,
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
                            controller: _controllerlat,
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
                            controller: _controllerlng,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(
                                  top: 0, bottom: 0, left: 5, right: 5),
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
                            onTap: (LatLng? tapPosition) {
                              if (tapPosition != null) {
                                final lat = tapPosition.latitude;
                                final lng = tapPosition.latitude;
                                _controllerlat.text = lat.toString();
                                _controllerlng.text = lat.toString();
                              }
                            },
                            center: LatLng(10.952772, 106.807671),
                            zoom: 7),
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
                            width: 145,
                            margin: EdgeInsets.all(7),
                            child: TextField(
                              controller: _ngaykhoicong,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    top: 0, bottom: 0, left: 5, right: 5),
                                hintText: 'Nhập ...',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7),
                                  borderSide: BorderSide(),
                                ),
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              // Future<void> _selectDate(BuildContext context) async {
                              final DateTime? picked = await showDatePicker(
                                context: context,
                                initialDate: NKhoiCong,
                                firstDate: DateTime(1900),
                                lastDate: DateTime(2101),
                              );
                              if (picked != null && picked != NKhoiCong) {
                                setState(() {
                                  NKhoiCong = DateTime(
                                      picked.year, picked.month, picked.day);
                                  _ngaykhoicong.text =
                                      ('${NKhoiCong.day.toString()}/${NKhoiCong.month.toString()}/${NKhoiCong.year.toString()}');
                                });
                              }
                              // }
                            },
                            child:
                                Icon(Icons.calendar_today, color: Colors.black),
                            style: ElevatedButton.styleFrom(
                              // độ lớn của nút
                              primary: Colors.white, // màu nền của nút
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
                            width: 145,
                            margin: EdgeInsets.all(7),
                            child: TextField(
                              controller: _ngayhoanthanh,
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
                          ElevatedButton(
                            onPressed: () async {
                              // Future<void> _selectDate(BuildContext context) async {
                              final DateTime? picked = await showDatePicker(
                                context: context,
                                initialDate: NHoanThanh,
                                firstDate: DateTime(1900),
                                lastDate: DateTime(2101),
                              );
                              if (picked != null && picked != NKhoiCong) {
                                setState(() {
                                  NHoanThanh = DateTime(
                                      picked.year, picked.month, picked.day);
                                  _ngayhoanthanh.text =
                                      ('${NHoanThanh.day.toString()}/${NHoanThanh.month.toString()}/${NHoanThanh.year.toString()}');
                                });
                              }
                              // }
                            },
                            child:
                                Icon(Icons.calendar_today, color: Colors.black),
                            style: ElevatedButton.styleFrom(
                              // độ lớn của nút
                              primary: Colors.white, // màu nền của nút
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
