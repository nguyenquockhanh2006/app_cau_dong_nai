import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_application_4/services/controllers/detailBridgeController.dart';
import 'package:flutter_application_4/services/controllers/imageController.dart';
import 'package:flutter_application_4/services/controllers/repairController.dart';
import 'package:flutter_application_4/services/models/detailBridgeModel.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:image_picker/image_picker.dart';
import '../../services/models/bridgeModel.dart';
import '../../services/controllers/bridgeController.dart';
import '../../services/models/repairModel.dart';
import '../../services/controllers/bridgeController.dart';
import '../homeScreen/menu.dart';

class DetailAndUpdate extends StatefulWidget {
  final detailBridgeController dBC = detailBridgeController();
  final RepairController repairController = RepairController();
  final int idBridge;
  DetailAndUpdate({Key? key, required this.idBridge}) : super(key: key);

  @override
  State<DetailAndUpdate> createState() => _DetailState();
}

class _DetailState extends State<DetailAndUpdate> {
  imageController iC = imageController();
  final MapController mapController = MapController();
  late Future<List<detailBridgeModel>> _futureBridgeList;
  //late Future<List<RepairModel>> _futureRepairList;
//
  String anhCayCau = "";
  String anhMatCat = "";
  String anhBinhDo = "";
  // thông tin chung
  String tenCayCau = "Cau Text";
  final TextEditingController _controllerTenCayCau = TextEditingController();
  String loaiCau = "";
  final TextEditingController _controllerLoaiCau = TextEditingController();
  String cap = "";
  final TextEditingController _controllerCap = TextEditingController();
  String lyTrinh = "";
  final TextEditingController _controllerLyTrinh = TextEditingController();
  String taiTrong = "";
  final TextEditingController _controllerTaiTrong = TextEditingController();
  String chieuDai = "";
  final TextEditingController _controllerChieuDai = TextEditingController();
  String chieuRong = "";
  final TextEditingController _controllerChieuRong = TextEditingController();
  String diaDiem = "";
  final TextEditingController _controllerDiaDiem = TextEditingController();
  double kinhDo = 10.96701421956938;
  final TextEditingController _controllerKinhDo =
      TextEditingController(); // --> controllerlat
  double viDo = 10.96701421956938;
  final TextEditingController _controllerViDo =
      TextEditingController(); //--> controllerlng
  // thông tin thi công
  String ngayKhoiCong = "0001-01-01";
  //final TextEditingController _controllerNgayKhoiCong = TextEditingController(); --> controllerNgayKhoiCong
  String ngayHoanThanh = "0001-01-01";
  //final TextEditingController _controllerNgayHoanThanh = TextEditingController(); --> controllerNgayHoanThanh
  // ignore: avoid_init_to_null
  int? chiPhiXayDung = null;
  final TextEditingController _controllerChiPhiXayDung =
      TextEditingController();
  String chuDauTu = "";
  final TextEditingController _controllerChuDauTu = TextEditingController();
  String donViThietKe = "";
  final TextEditingController _controllerDonViThietKe = TextEditingController();
  String donViThiCong = "";
  final TextEditingController _controllerDonViThiCong = TextEditingController();
  String donViGiamSat = "";
  final TextEditingController _controllerDonViGiamSat = TextEditingController();
  // cấu tạo cầu
  int soNhip = 0;
  final TextEditingController _controllerSoNhip = TextEditingController();
  int soMo = 0;
  final TextEditingController _controllerSoMo = TextEditingController();
  int soTru = 0;
  final TextEditingController _controllerSoTru = TextEditingController();
  int soDamNgang = 0;
  final TextEditingController _controllerSoDamNgang = TextEditingController();
  int soDamChinh = 0;
  final TextEditingController _controllerSoDamChinh = TextEditingController();
  int soLanCan = 0;
  final TextEditingController _controllerSoLanCan = TextEditingController();
  int soDaiPhanCach = 0;
  final TextEditingController _controllerSoDaiPhanCach =
      TextEditingController();
  // vật liệu cầu
  String vlDamChinh = "";
  final TextEditingController _controllerVlDamChinh = TextEditingController();
  String vlDamNgang = "";
  final TextEditingController _controllerVlDamNgang = TextEditingController();
  String vlBanMatCau = "";
  final TextEditingController _controllerVlBanMatCau = TextEditingController();
  String vlLanCan = "";
  final TextEditingController _controllerVlLanCan = TextEditingController();
  String vlMo = "";
  final TextEditingController _controllerVlMo = TextEditingController();
  String vlTru = "";
  final TextEditingController _controllerVlTru = TextEditingController();
  // kích thước cầu
  double chieuDaiNhip = 0.0;
  final TextEditingController _controllerChieuDaiNhip = TextEditingController();
  double beRongXeChay = 0.0;
  final TextEditingController _controllerBeRongXeChay = TextEditingController();
  double khoangCachDamChinh = 0.0;
  final TextEditingController _controllerKhoangCachDamChinh =
      TextEditingController();
  double khoangCachDamNgang = 0.0;
  final TextEditingController _controllerKhoangCachDamNgang =
      TextEditingController();
  double chieuCaoBanMatCau = 0.0;
  final TextEditingController _controllerChieuCaoBanMatCau =
      TextEditingController();
  double beRongLanCan = 0.0;
  final TextEditingController _controllerBeRongLanCan = TextEditingController();
  // ảnh ban đầu của cầu
  String? _hinhAnhCauSrc = 'https://i.imgur.com/bkB4dqc.png';
  String? _hinhAnhMatCatSrc = 'https://i.imgur.com/bkB4dqc.png';
  String? _hinhAnhBinhDoSrc = 'https://i.imgur.com/bkB4dqc.png';
  // - > File
  File? _imageFile;
  File? _imageFileMatCat;
  File? _imageFileBinhDo;
  //

  Future<void> _pickImage(ImageSource source) async {
    // ignore: deprecated_member_use
    final pickedFile = await ImagePicker().getImage(source: source);
    if (pickedFile != null) {
      final srcTemp = await iC.postImage(File(pickedFile.path));
      setState(() {
        _imageFile = File(pickedFile.path);
        _hinhAnhCauSrc = srcTemp;
        print('Hình ảnh cầu SRC: ' + _hinhAnhCauSrc.toString());
        // kiểm tra kết quả trả về
        anhCayCau = _hinhAnhCauSrc.toString();
      });
    }
  }

  //
  Future<void> _pickImageMatCat(ImageSource source) async {
    // ignore: deprecated_member_use
    final pickedFile = await ImagePicker().getImage(source: source);
    if (pickedFile != null) {
      final srcTemp = await iC.postImage(File(pickedFile.path));
      setState(() {
        _imageFileMatCat = File(pickedFile.path);
        _hinhAnhMatCatSrc = srcTemp;
        print('Hình ảnh mặt cắt SRC: ' + _hinhAnhMatCatSrc.toString());
        // kiểm tra kết quả trả về
        anhMatCat = _hinhAnhMatCatSrc.toString();
      });
    }
  }

  //
  Future<void> _pickImageBinhDo(ImageSource source) async {
    // ignore: deprecated_member_use
    final pickedFile = await ImagePicker().getImage(source: source);
    if (pickedFile != null) {
      final srcTemp = await iC.postImage(File(pickedFile.path));
      setState(() {
        _imageFileBinhDo = File(pickedFile.path);
        _hinhAnhBinhDoSrc = srcTemp;
        print('Hình ảnh bình đồ SRC: ' + _hinhAnhBinhDoSrc.toString());
        // kiểm tra kết quả trả về
        anhBinhDo = _hinhAnhBinhDoSrc.toString();
      });
    }
  }

//
  void setDataController(detailBridgeModel detaiTemp) {
    _controllerTenCayCau.text = detaiTemp.tenCayCau as String;
    _controllerLoaiCau.text = detaiTemp.loaiCau as String;
    _controllerCap.text = detaiTemp.cap as String;
    _controllerLyTrinh.text = detaiTemp.lyTrinh as String;
    _controllerChieuDai.text = detaiTemp.chieuDai as String;
    _controllerChieuRong.text = detaiTemp.chieuRong as String;
    _controllerDiaDiem.text = detaiTemp.diaDiem as String;
    double kinhDo = detaiTemp.kinhDo as double;
    double viDo = detaiTemp.viDo as double;
    _controllerKinhDo.text = kinhDo.toString();
    _controllerViDo.text = viDo.toString();
    int chiPhi = detaiTemp.chiPhiXayDung as int;
    _controllerChiPhiXayDung.text = chiPhi.toString();
  }

//
  @override
  void initState() {
    super.initState();
    _futureBridgeList = widget.dBC.getApi() as Future<List<detailBridgeModel>>;
    //_futureRepairList = widget.repairController.getApi();
  }

  void setDataStart(detailBridgeModel temp) {}
  @override
  Widget build(BuildContext context) {
    final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
    return Scaffold(
        appBar: AppBar(
          title: Text('Chi tiết / cập nhật'),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            navigatorKey.currentState?.push(
              MaterialPageRoute(builder: (context) => MyNewPage()),
            );
          },
          label: Text('Lưu thay đổi'),
          icon: Icon(Icons.save_alt),
          backgroundColor: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        // endDrawer: menu(),
        body: SingleChildScrollView(
          child: FutureBuilder<List<detailBridgeModel>>(
            future: _futureBridgeList,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<detailBridgeModel>? bridgeList = snapshot.data;
                for (int i = 0; i < bridgeList!.length; i++) {
                  if (bridgeList[i].bridgeId == widget.idBridge) {
                    setDataController(bridgeList[i]);
                    return Column(
                      children: [
                        Center(
                          child: Container(
                            child: Center(
                                child: Text(
                              'THÔNG TIN CẦU',
                              style: TextStyle(color: Colors.white),
                            )),
                            margin: EdgeInsets.only(top: 7),
                            width: 180,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(7),
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width - 14,
                          margin: EdgeInsets.only(left: 7, right: 7, bottom: 7),
                          decoration: BoxDecoration(
                            color: Color(0xFFE9ECEF),
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: //tu day
                              Container(
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.only(left: 5),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // noi dung thông tin chung
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 120,
                                          child: Text('Tên cây cầu'),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              180,
                                          margin: EdgeInsets.all(7),
                                          child: TextField(
                                            onChanged: (newValue) {
                                              // setState(() {
                                              //   tenCayCau = newValue;
                                              // });
                                              // print('tên cầu: ' + tenCayCau);
                                            },
                                            controller: _controllerTenCayCau,
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.only(
                                                  top: 0,
                                                  bottom: 0,
                                                  left: 5,
                                                  right: 5),
                                              hintText:
                                                  _controllerTenCayCau.text,
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(7),
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
                                          child: Text('Loại cầu'),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              180,
                                          margin: EdgeInsets.all(7),
                                          child: TextField(
                                            onChanged: (newValue) {
                                              // setState(() {
                                              //   tenCayCau = newValue;
                                              // });
                                              // print('tên cầu: ' + tenCayCau);
                                            },
                                            controller: _controllerLoaiCau,
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.only(
                                                  top: 0,
                                                  bottom: 0,
                                                  left: 5,
                                                  right: 5),
                                              hintText: _controllerLoaiCau
                                                  .text, //'Nhập loại cầu...',
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(7),
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
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              180,
                                          margin: EdgeInsets.all(7),
                                          child: TextField(
                                            controller: _controllerCap,
                                            onChanged: (newValue) {
                                              // setState(() {
                                              //   cap = newValue;
                                              // });
                                              // print('Cấp :' + cap);
                                            },
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.only(
                                                  top: 0,
                                                  bottom: 0,
                                                  left: 5,
                                                  right: 5),
                                              // labelText: 'Tên cầu',
                                              hintText: _controllerCap.text,
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(7),
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
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              180,
                                          margin: EdgeInsets.all(7),
                                          child: TextField(
                                            controller: _controllerLyTrinh,
                                            onChanged: (newValue) {
                                              // setState(() {
                                              //   lyTrinh = newValue;
                                              // });
                                              // print('Lý trình: ' + lyTrinh);
                                            },
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.only(
                                                  top: 0,
                                                  bottom: 0,
                                                  left: 5,
                                                  right: 5),
                                              // labelText: 'Tên cầu',
                                              hintText: _controllerLyTrinh.text,
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(7),
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
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              180,
                                          margin: EdgeInsets.all(7),
                                          child: TextField(
                                            controller: _controllerTaiTrong,
                                            onChanged: (newValue) {
                                              // setState(() {
                                              //   taiTrong = newValue;
                                              // });
                                              // print('Tải trọng: ' + taiTrong);
                                            },
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.only(
                                                  top: 0,
                                                  bottom: 0,
                                                  left: 5,
                                                  right: 5),
                                              // labelText: 'Tên cầu',
                                              hintText:
                                                  _controllerTaiTrong.text,
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(7),
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
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              180,
                                          margin: EdgeInsets.all(7),
                                          child: TextField(
                                            controller: _controllerChieuDai,
                                            onChanged: (newValue) {
                                              // setState(() {
                                              //   chieuDai = newValue;
                                              // });
                                              // print('Chiều dài: ' + chieuDai);
                                            },
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.only(
                                                  top: 0,
                                                  bottom: 0,
                                                  left: 5,
                                                  right: 5),
                                              // labelText: 'Tên cầu',
                                              hintText:
                                                  _controllerChieuDai.text,
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(7),
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
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              180,
                                          margin: EdgeInsets.all(7),
                                          child: TextField(
                                            controller: _controllerChieuRong,
                                            onChanged: (newValue) {
                                              // setState(() {
                                              //   chieuRong = newValue;
                                              // });
                                              // print('Chiều rộng: ' + chieuRong);
                                            },
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.only(
                                                  top: 0,
                                                  bottom: 0,
                                                  left: 5,
                                                  right: 5),
                                              // labelText: 'Tên cầu',
                                              hintText:
                                                  _controllerChieuRong.text,
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(7),
                                                borderSide: BorderSide(),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // hết nội dung thông tin chung
                                ]),
                          ),
                        ),
                        Center(
                          child: Container(
                            child: Center(
                                child: Text(
                              'VỊ TRÍ CẦU',
                              style: TextStyle(color: Colors.white),
                            )),
                            margin: EdgeInsets.only(top: 7),
                            width: 180,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(7),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 7, right: 7, bottom: 7),
                          decoration: BoxDecoration(
                            color: Color(0xFFE9ECEF),
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: Column(children: [
                            Container(
                              child: Row(children: [
                                const SizedBox(
                                  width: 70,
                                  child: Text('Địa điểm'),
                                ),
                                Container(
                                  width: 260,
                                  margin: const EdgeInsets.all(7),
                                  child: TextField(
                                    controller: _controllerDiaDiem,
                                    // onChanged: (newValue) {
                                    //   setState(() {
                                    //     diaDiem = newValue;
                                    //   });
                                    //   print('Địa điểm: $diaDiem');
                                    // },

                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.only(
                                          top: 0, bottom: 0, left: 5, right: 5),
                                      // labelText: 'Tên cầu',
                                      hintText: _controllerDiaDiem.text,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(7),
                                        borderSide: const BorderSide(),
                                      ),
                                    ),
                                  ),
                                ),
                              ]),
                            ),
                            Container(
                              child: Row(children: [
                                const SizedBox(
                                  width: 70,
                                  child: Text('Kinh độ'),
                                ),
                                Container(
                                  width: 260,
                                  margin: const EdgeInsets.all(7),
                                  child: TextField(
                                    enabled: false,
                                    onChanged: (newValue) {
                                      setState(() {
                                        if (newValue.trim() == "") {
                                          kinhDo = 0.00;
                                        } else {
                                          kinhDo = double.parse(newValue);
                                        }
                                      });
                                      // print('Kinh độ: $kinhDo');
                                    },
                                    controller: _controllerKinhDo,
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.only(
                                          top: 0, bottom: 0, left: 5, right: 5),
                                      // labelText: 'Tên cầu',
                                      hintText: _controllerKinhDo.text,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(7),
                                        borderSide: const BorderSide(),
                                      ),
                                    ),
                                  ),
                                ),
                              ]),
                            ),
                            Container(
                              child: Row(children: [
                                const SizedBox(
                                  width: 70,
                                  child: Text('Vĩ độ'),
                                ),
                                Container(
                                  width: 260,
                                  margin: const EdgeInsets.all(7),
                                  child: TextField(
                                    enabled: false,
                                    onChanged: (newValue) {
                                      setState(() {
                                        if (newValue.trim() == "") {
                                          viDo = 0.0;
                                        } else {
                                          viDo = double.parse(newValue);
                                        }
                                      });
                                      // print('Vĩ độ: $viDo');
                                    },
                                    controller: _controllerViDo,
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.only(
                                          top: 0, bottom: 0, left: 5, right: 5),
                                      hintText: _controllerViDo.text,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(7),
                                        borderSide: const BorderSide(),
                                      ),
                                    ),
                                  ),
                                ),
                              ]),
                            ),
                            Container(
                              height: 200,
                              margin: const EdgeInsets.all(5),
                              child: FlutterMap(
                                mapController: mapController,
                                options: MapOptions(
                                    onTap: (LatLng? tapPosition) {
                                      if (tapPosition != null) {
                                        final lat = tapPosition.latitude;
                                        final lng = tapPosition.latitude;
                                        // set kinh độ
                                        _controllerKinhDo.text = lat.toString();
                                        // -> kinhDo
                                        kinhDo = double.parse(
                                            _controllerKinhDo.text);
                                        print('Kinh độ: $kinhDo');
                                        // set vĩ độ
                                        _controllerViDo.text = lng.toString();
                                        // -> viDo
                                        viDo =
                                            double.parse(_controllerViDo.text);
                                        print('Vĩ độ: $viDo');
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
                                  MarkerLayerOptions(markers: [
                                    Marker(
                                      width: 80.0,
                                      height: 80.0,
                                      point: LatLng(
                                          double.parse(_controllerKinhDo.text),
                                          double.parse(_controllerViDo.text)),
                                      builder: (ctx) => Container(
                                        child: IconButton(
                                            icon: Image.network(
                                              'https://i.imgur.com/x94d3tp.png',
                                              width: 50,
                                              height: 50,
                                            ),
                                            color: Colors.red,
                                            iconSize: 30.0,
                                            onPressed: () {}),
                                      ),
                                    ),
                                  ])
                                ],
                              ),
                            )
                          ]),
                        ),
                        Center(
                          child: Container(
                            child: Center(
                                child: Text(
                              'THI CÔNG CẦU',
                              style: TextStyle(color: Colors.white),
                            )),
                            margin: EdgeInsets.only(top: 7),
                            width: 180,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(7),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 7, right: 7, bottom: 7),
                          decoration: BoxDecoration(
                            color: Color(0xFFE9ECEF),
                            borderRadius: BorderRadius.circular(7),
                          ),
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
                                    // Text(bridgeList[i].ngayKhoiCong),
                                    // SizedBox(height: 8),
                                    // Text(bridgeList[i].ngayHoanThanh),
                                    // SizedBox(height: 8),
                                    // Text(bridgeList[i].cap),
                                    // SizedBox(height: 8),
                                    // Text(bridgeList[i].lyTrinh),
                                    // SizedBox(height: 8),
                                    // Text(bridgeList[i].taiTrong),
                                    // SizedBox(height: 8),
                                    // Text(bridgeList[i].chieuDai),
                                    // SizedBox(height: 8),
                                    // Text(bridgeList[i].chieuRong),
                                  ]),
                            ),
                          ]),
                        ),
                        Center(
                          child: Container(
                            child: Center(
                                child: Text(
                              'CẤU TẠO CẦU',
                              style: TextStyle(color: Colors.white),
                            )),
                            margin: EdgeInsets.only(top: 7),
                            width: 180,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(7),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 7, right: 7, bottom: 7),
                          decoration: BoxDecoration(
                            color: Color(0xFFE9ECEF),
                            borderRadius: BorderRadius.circular(7),
                          ),
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
                                    Text(
                                        bridgeList[i].chiPhiXayDung.toString()),
                                    // SizedBox(height: 8),
                                    // Text(bridgeList[i].loaiCau),
                                    // SizedBox(height: 8),
                                    // Text(bridgeList[i].cap),
                                    // SizedBox(height: 8),
                                    // Text(bridgeList[i].lyTrinh),
                                    // SizedBox(height: 8),
                                    // Text(bridgeList[i].taiTrong),
                                    // SizedBox(height: 8),
                                    // Text(bridgeList[i].chieuDai),
                                    // SizedBox(height: 8),
                                    // Text(bridgeList[i].chieuRong),
                                  ]),
                            ),
                          ]),
                        ),
                        Center(
                          child: Container(
                            child: Center(
                                child: Text(
                              'VẬT LIỆU CẦU',
                              style: TextStyle(color: Colors.white),
                            )),
                            margin: EdgeInsets.only(top: 7),
                            width: 180,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(7),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 7, right: 7, bottom: 7),
                          decoration: BoxDecoration(
                            color: Color(0xFFE9ECEF),
                            borderRadius: BorderRadius.circular(7),
                          ),
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
                                    // Text(bridgeList[i].tenCayCau),
                                    // SizedBox(height: 8),
                                    // Text(bridgeList[i].loaiCau),
                                    // SizedBox(height: 8),
                                    // Text(bridgeList[i].cap),
                                    // SizedBox(height: 8),
                                    // Text(bridgeList[i].lyTrinh),
                                    // SizedBox(height: 8),
                                    // Text(bridgeList[i].taiTrong),
                                    // SizedBox(height: 8),
                                    // Text(bridgeList[i].chieuRong),
                                  ]),
                            ),
                          ]),
                        ),
                        Center(
                          child: Container(
                            child: Center(
                                child: Text(
                              'KÍCH THƯỚC CẦU',
                              style: TextStyle(color: Colors.white),
                            )),
                            margin: EdgeInsets.only(top: 7),
                            width: 180,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(7),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 7, right: 7, bottom: 7),
                          decoration: BoxDecoration(
                            color: Color(0xFFE9ECEF),
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: Row(children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.only(left: 5),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Text('Chiều dài nhịp'),
                                    // SizedBox(height: 8),
                                    // Text('Bề rộng xe chạy (m)'),
                                    // SizedBox(height: 8),
                                    // Text('Khoảng cách dầm chính (m)'),
                                    // SizedBox(height: 8),
                                    // Text('Khoảng cách dầm ngang (m)'),
                                    // SizedBox(height: 8),
                                    // Text('Bề rộng lề bộ hành (m)'),
                                    // SizedBox(height: 8),
                                    // Text('Bề rộng lan can (m)'),
                                  ]),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Text(bridgeList[i].tenCayCau),
                                    // SizedBox(height: 8),
                                    // Text(bridgeList[i].loaiCau),
                                    // SizedBox(height: 8),
                                    // Text(bridgeList[i].cap),
                                    // SizedBox(height: 8),
                                    // Text(bridgeList[i].lyTrinh),
                                    // SizedBox(height: 8),
                                    // Text(bridgeList[i].taiTrong),
                                    // SizedBox(height: 8),
                                    // Text(bridgeList[i].chieuDai),
                                  ]),
                            ),
                          ]),
                        ),
                        Center(
                          child: Container(
                            child: Center(
                                child: Text(
                              'SỬA CHỮA/ KIỂM TRA',
                              style: TextStyle(color: Colors.white),
                            )),
                            margin: EdgeInsets.only(top: 7),
                            width: 180,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Color(0xFFfb8500),
                              borderRadius: BorderRadius.circular(7),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 7, right: 7, bottom: 7),
                          decoration: BoxDecoration(
                            color: Color(0xFFE9ECEF),
                            borderRadius: BorderRadius.circular(7),
                          ),
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

class MyNewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My New Page')),
      body: Center(
        child: Text('This is my new page'),
      ),
    );
  }
}
