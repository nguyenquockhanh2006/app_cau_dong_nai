import 'dart:io';
import 'package:flutter_application_4/services/controllers/bridgeController.dart';
import 'package:flutter_application_4/services/controllers/imageController.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:core';
import 'package:flutter/services.dart';

import 'package:flutter_application_4/screens/infoBridgeScreen/infoBridgeScreen.dart';

class addBridgeScreen extends StatefulWidget {
  const addBridgeScreen({super.key});
  @override
  State<addBridgeScreen> createState() => _addBridgeState();
}

class _addBridgeState extends State<addBridgeScreen> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final bridgeController bC = bridgeController();
  final imageController iC = imageController();
  final MapController mapController = MapController();
  final TextEditingController _controllerlat = TextEditingController();
  final TextEditingController _controllerlng = TextEditingController();
  final TextEditingController _ngaykhoicong = TextEditingController();
  final TextEditingController _ngayhoanthanh = TextEditingController();
  DateTime NKhoiCong = DateTime.now();
  DateTime NHoanThanh = DateTime.now();
  // biến kết quả thêm trả về của hàm postApi
  int result = 0;
  // controller và biến data cầu -->
  // hình ảnh
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
  //final TextEditingController _controllerKinhDo = TextEditingController(); --> controllerlat
  double viDo = 10.96701421956938;
  //final TextEditingController _controllerViDo = TextEditingController(); --> controllerlng
  // thông tin thi công
  String ngayKhoiCong = "0001-01-01";
  //final TextEditingController _controllerNgayKhoiCong = TextEditingController(); --> controllerNgayKhoiCong
  String ngayHoanThanh = "0001-01-01";
  //final TextEditingController _controllerNgayHoanThanh = TextEditingController(); --> controllerNgayHoanThanh
  // ignore: avoid_init_to_null
  int? chiPhiXayDung;
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
        print('Hình ảnh cầu SRC: $_hinhAnhCauSrc');
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
        print('Hình ảnh mặt cắt SRC: $_hinhAnhMatCatSrc');
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
        print('Hình ảnh bình đồ SRC: $_hinhAnhBinhDoSrc');
        // kiểm tra kết quả trả về
        anhBinhDo = _hinhAnhBinhDoSrc.toString();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _controllerlat.text = '';
    _controllerlng.text = '';
  }

  // hàm thêm

  void addBridge() async {
    int? chiPhiTemp;
    if (_controllerChiPhiXayDung.text.toString() == '') {
      chiPhiTemp = null;
    } else {
      chiPhiTemp = int.parse(_controllerChiPhiXayDung.text.toString());
    }
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
        chiPhiTemp,
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
      print('thành công $chiPhiTemp');
      setState(() {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => infoBridgeScreen()),
        );
      });
    } else {
      print('thất bại');
    }
  }

  //
  @override
  Widget build(BuildContext context) {
    navigatorKey;
    return Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Thông báo'),
                      content: Text('Xác nhận thêm cầu ${tenCayCau}'),
                      actions: [
                        TextButton(
                          child: const Text('Huỷ bỏ'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: const Text('Thêm'),
                          onPressed: () {
                            // Xử lý khi người dùng chọn xác nhận
                            addBridge();
                            if (result == 200) {
                              print('thành công!');

                              Navigator.of(context).pop();
                            } else {
                              print('thất bại!');
                              Navigator.of(context).pop();
                            }
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              style: TextButton.styleFrom(
                backgroundColor: const Color(0xff7cb518),
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Thêm',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextButton(
              onPressed: () {
                //
                _controllerTenCayCau.text = "";
                _controllerLoaiCau.text = "";
                _controllerCap.text = "";
                _controllerLyTrinh.text = "";
                _controllerTaiTrong.text = "";
                _controllerChieuDai.text = "";
                _controllerChieuRong.text = "";
                _controllerDiaDiem.text = "";
                _controllerChiPhiXayDung.text = "";
                _controllerChuDauTu.text = "";
                _controllerDonViThietKe.text = "";
                _controllerDonViThiCong.text = "";
                _controllerDonViGiamSat.text = "";
                _controllerSoNhip.text = "";
                _controllerSoMo.text = "";
                _controllerSoTru.text = "";
                _controllerSoDamNgang.text = "";
                _controllerSoDamChinh.text = "";
                _controllerSoLanCan.text = "";
                _controllerSoDaiPhanCach.text = "";
                _controllerVlDamChinh.text = "";
                _controllerVlDamNgang.text = "";
                _controllerVlBanMatCau.text = "";
                _controllerVlLanCan.text = "";
                _controllerVlMo.text = "";
                _controllerVlTru.text = "";
                _controllerChieuDaiNhip.text = "";
                _controllerBeRongXeChay.text = "";
                _controllerKhoangCachDamChinh.text = "";
                _controllerKhoangCachDamNgang.text = "";
                _controllerChieuCaoBanMatCau.text = "";
                _controllerBeRongLanCan.text = "";
                //
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.blue,
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.restart_alt,
                    color: Colors.white,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Làm mới',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      appBar: AppBar(
        title: const Text('Thêm cầu mới'),
      ),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(7),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 320,
                  height: 45,
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: const ListTile(
                    leading: Icon(
                      Icons.image,
                      color: Colors.white,
                    ),
                    title: Text(
                      'HÌNH ẢNH/ BÌNH ĐỒ/ MẶT CẮT',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(7),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(7),
                        bottomLeft: Radius.circular(7),
                        bottomRight: Radius.circular(7),
                      ),
                      border: Border.all(color: const Color(0xFFadb5bd))),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Column(children: [
                            const Text('Hình ảnh cầu'),
                            Image(
                                height: 150,
                                width: 320,
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  _imageFile == null
                                      ? 'https://i.imgur.com/bkB4dqc.png'
                                      : 'http://171.244.8.103:9003/$_hinhAnhCauSrc',
                                )),
                            TextButton(
                                onPressed: () => {
                                      _pickImage(ImageSource.gallery),
                                    },
                                child: const Text('Chọn hình')),
                          ]),
                        ),
                        Container(
                          child: Column(children: [
                            const Text('Ảnh bình đồ'),
                            Image(
                                height: 150,
                                width: 320,
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  _imageFileBinhDo == null
                                      ? 'https://i.imgur.com/bkB4dqc.png'
                                      : 'http://171.244.8.103:9003/$_hinhAnhBinhDoSrc',
                                )),
                            TextButton(
                                onPressed: () => {
                                      _pickImageBinhDo(ImageSource.gallery),
                                    },
                                child: const Text('Chọn hình')),
                          ]),
                        ),
                        Container(
                          child: Column(children: [
                            const Text('Ảnh mặt cắt'),
                            Image(
                                height: 150,
                                width: 320,
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  _imageFileMatCat == null
                                      ? 'https://i.imgur.com/bkB4dqc.png'
                                      : 'http://171.244.8.103:9003/$_hinhAnhMatCatSrc',
                                )),
                            TextButton(
                                onPressed: () => {
                                      _pickImageMatCat(ImageSource.gallery),
                                    },
                                child: const Text('Chọn hình')),
                          ]),
                        )
                      ]),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(7),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 320,
                  height: 45,
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    // borderRadius: BorderRadius.circular(7),
                  ),
                  child: const ListTile(
                    leading: Icon(
                      Icons.image,
                      color: Colors.white,
                    ),
                    title: Text(
                      'THÔNG TIN CHUNG',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(7),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(7),
                        bottomLeft: Radius.circular(7),
                        bottomRight: Radius.circular(7),
                      ),
                      border: Border.all(color: const Color(0xFFadb5bd))),
                  child: Column(children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 120,
                            child: Text('Tên cây cầu'),
                          ),
                          Container(
                            width: 210,
                            margin: const EdgeInsets.all(7),
                            child: TextField(
                              onChanged: (newValue) {
                                setState(() {
                                  tenCayCau = newValue;
                                });
                                print('tên cầu: $tenCayCau');
                              },
                              controller: _controllerTenCayCau,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.only(
                                    top: 0, bottom: 0, left: 5, right: 5),
                                hintText: 'Nhập tên cầu...',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7),
                                  borderSide: const BorderSide(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const SizedBox(
                            width: 120,
                            child: Text('Loại cầu'),
                          ),
                          Container(
                            width: 210,
                            margin: const EdgeInsets.all(7),
                            child: TextField(
                              controller: _controllerLoaiCau,
                              onChanged: (newValue) {
                                setState(() {
                                  loaiCau = newValue;
                                });
                                print('Loại cầu : $loaiCau');
                              },
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.only(
                                    top: 0, bottom: 0, left: 5, right: 5),
                                // labelText: 'Tên cầu',
                                hintText: 'Nhập loại cầu...',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7),
                                  borderSide: const BorderSide(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 120,
                            child: Text('Cấp'),
                          ),
                          Container(
                            width: 210,
                            margin: const EdgeInsets.all(7),
                            child: TextField(
                              controller: _controllerCap,
                              onChanged: (newValue) {
                                setState(() {
                                  cap = newValue;
                                });
                                print('Cấp :$cap');
                              },
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.only(
                                    top: 0, bottom: 0, left: 5, right: 5),
                                // labelText: 'Tên cầu',
                                hintText: 'Nhập cấp...',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7),
                                  borderSide: const BorderSide(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 120,
                            child: Text('Lý trình'),
                          ),
                          Container(
                            width: 210,
                            margin: const EdgeInsets.all(7),
                            child: TextField(
                              controller: _controllerLyTrinh,
                              onChanged: (newValue) {
                                setState(() {
                                  lyTrinh = newValue;
                                });
                                print('Lý trình: $lyTrinh');
                              },
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.only(
                                    top: 0, bottom: 0, left: 5, right: 5),
                                // labelText: 'Tên cầu',
                                hintText: 'Nhập lý trình...',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7),
                                  borderSide: const BorderSide(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 120,
                            child: Text('Tải trọng'),
                          ),
                          Container(
                            width: 210,
                            margin: const EdgeInsets.all(7),
                            child: TextField(
                              controller: _controllerTaiTrong,
                              onChanged: (newValue) {
                                setState(() {
                                  taiTrong = newValue;
                                });
                                print('Tải trọng: $taiTrong');
                              },
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.only(
                                    top: 0, bottom: 0, left: 5, right: 5),
                                // labelText: 'Tên cầu',
                                hintText: 'Nhập tải trọng...',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7),
                                  borderSide: const BorderSide(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 120,
                            child: Text('Chiều dài cầu (m)'),
                          ),
                          Container(
                            width: 210,
                            margin: const EdgeInsets.all(7),
                            child: TextField(
                              controller: _controllerChieuDai,
                              onChanged: (newValue) {
                                setState(() {
                                  chieuDai = newValue;
                                });
                                print('Chiều dài: $chieuDai');
                              },
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.only(
                                    top: 0, bottom: 0, left: 5, right: 5),
                                // labelText: 'Tên cầu',
                                hintText: 'Nhập chiều dài',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7),
                                  borderSide: const BorderSide(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 120,
                            child: Text('Chiều rộng cầu (m)'),
                          ),
                          Container(
                            width: 210,
                            margin: const EdgeInsets.all(7),
                            child: TextField(
                              controller: _controllerChieuRong,
                              onChanged: (newValue) {
                                setState(() {
                                  chieuRong = newValue;
                                });
                                print('Chiều rộng: $chieuRong');
                              },
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.only(
                                    top: 0, bottom: 0, left: 5, right: 5),
                                // labelText: 'Tên cầu',
                                hintText: 'Nhập chiều rộng...',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7),
                                  borderSide: const BorderSide(),
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
                  margin: const EdgeInsets.only(top: 7),
                  width: 320,
                  height: 45,
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    // borderRadius: BorderRadius.circular(7),
                  ),
                  child: const ListTile(
                    leading: Icon(
                      Icons.image,
                      color: Colors.white,
                    ),
                    title: Text(
                      'THÔNG TIN VỊ TRÍ',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(7),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(7),
                        bottomLeft: Radius.circular(7),
                        bottomRight: Radius.circular(7),
                      ),
                      border: Border.all(color: const Color(0xFFadb5bd))),
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
                            onChanged: (newValue) {
                              setState(() {
                                diaDiem = newValue;
                              });
                              print('Địa điểm: $diaDiem');
                            },
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(
                                  top: 0, bottom: 0, left: 5, right: 5),
                              // labelText: 'Tên cầu',
                              hintText: 'Nhập địa điểm...',
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
                              print('Kinh độ: $kinhDo');
                            },
                            controller: _controllerlat,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(
                                  top: 0, bottom: 0, left: 5, right: 5),
                              // labelText: 'Tên cầu',
                              hintText: 'Nhập ...',
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
                              print('Vĩ độ: $viDo');
                            },
                            controller: _controllerlng,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(
                                  top: 0, bottom: 0, left: 5, right: 5),
                              hintText: 'Nhập ...',
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
                                _controllerlat.text = lat.toString();
                                // -> kinhDo
                                kinhDo = double.parse(_controllerlat.text);
                                print('Kinh độ: $kinhDo');
                                // set vĩ độ
                                _controllerlng.text = lng.toString();
                                // -> viDo
                                viDo = double.parse(_controllerlng.text);
                                print('Vĩ độ: $viDo');
                              }
                            },
                            center: LatLng(10.952772, 106.807671),
                            zoom: 14),
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
                  margin: const EdgeInsets.only(top: 7),
                  width: 320,
                  height: 45,
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    // borderRadius: BorderRadius.circular(7),
                  ),
                  child: const ListTile(
                    leading: Icon(
                      Icons.image,
                      color: Colors.white,
                    ),
                    title: Text(
                      'THÔNG TIN THI CÔNG',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(7),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(7),
                        bottomLeft: Radius.circular(7),
                        bottomRight: Radius.circular(7),
                      ),
                      border: Border.all(color: const Color(0xFFadb5bd))),
                  child: Column(children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 120,
                            child: Text('Ngày khởi công'),
                          ),
                          Container(
                            width: 145,
                            margin: const EdgeInsets.all(7),
                            child: TextField(
                              enabled: false,
                              onChanged: (newValue) {
                                setState(() {
                                  ngayKhoiCong = newValue;
                                });
                                print('Ngày khởi công: $ngayKhoiCong');
                              },
                              controller: _ngaykhoicong,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.only(
                                    top: 0, bottom: 0, left: 5, right: 5),
                                hintText: 'Nhập ...',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7),
                                  borderSide: const BorderSide(),
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
                                      ('${NKhoiCong.year.toString()}/${NKhoiCong.month.toString()}/${NKhoiCong.day.toString()}');
                                  ngayKhoiCong = _ngaykhoicong.text;
                                  print('Ngày khởi công: $ngayKhoiCong');
                                });
                              }
                              // }
                            },
                            style: ElevatedButton.styleFrom(
                              // độ lớn của nút
                              backgroundColor: Colors.white, // màu nền của nút
                            ),
                            child: const Icon(Icons.calendar_today,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 120,
                            child: Text('Ngày hoàn thành'),
                          ),
                          Container(
                            width: 145,
                            margin: const EdgeInsets.all(7),
                            child: TextField(
                              enabled: false,
                              onChanged: (newValue) {
                                setState(() {
                                  ngayHoanThanh = newValue;
                                });
                                print('Ngày hoàn thành: $ngayHoanThanh');
                              },
                              controller: _ngayhoanthanh,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.only(
                                    top: 0, bottom: 0, left: 5, right: 5),
                                // labelText: 'Tên cầu',
                                hintText: 'Nhập...',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7),
                                  borderSide: const BorderSide(),
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
                                      ('${NHoanThanh.year.toString()}/${NHoanThanh.month.toString()}/${NHoanThanh.day.toString()}');
                                  ngayHoanThanh = _ngayhoanthanh.text;
                                  print('Ngày hoàn thành: $ngayHoanThanh');
                                });
                              }
                              // }
                            },
                            style: ElevatedButton.styleFrom(
                              // độ lớn của nút
                              backgroundColor: Colors.white, // màu nền của nút
                            ),
                            child: const Icon(Icons.calendar_today,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 120,
                            child: Text('Chi phí xây dựng'),
                          ),
                          Container(
                            width: 210,
                            margin: const EdgeInsets.all(7),
                            child: TextField(
                              controller: _controllerChiPhiXayDung,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9]'))
                              ],
                              onChanged: (newValue) {
                                setState(() {
                                  if (newValue.trim() == "") {
                                    chiPhiXayDung = null;
                                  } else {
                                    //Set chi phí đúng
                                    chiPhiXayDung = int.parse(newValue.trim());
                                    //chiPhiXayDung = null; // tạo chi phí null
                                  }
                                });
                                print('Chi phí xây dưng: $chiPhiXayDung');
                              },
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.only(
                                    top: 0, bottom: 0, left: 5, right: 5),
                                // labelText: 'Tên cầu',
                                hintText: 'Nhập...',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7),
                                  borderSide: const BorderSide(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 120,
                            child: Text('Chủ đầu tư'),
                          ),
                          Container(
                            width: 210,
                            margin: const EdgeInsets.all(7),
                            child: TextField(
                              controller: _controllerChuDauTu,
                              onChanged: (newValue) {
                                setState(() {
                                  chuDauTu = newValue;
                                });
                                print('Chủ đầu tư: $chuDauTu');
                              },
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.only(
                                    top: 0, bottom: 0, left: 5, right: 5),
                                // labelText: 'Tên cầu',
                                hintText: 'Nhập...',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7),
                                  borderSide: const BorderSide(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 120,
                            child: Text('Đơn vị thiết kế'),
                          ),
                          Container(
                            width: 210,
                            margin: const EdgeInsets.all(7),
                            child: TextField(
                              controller: _controllerDonViThietKe,
                              onChanged: (newValue) {
                                setState(() {
                                  donViThietKe = newValue;
                                });
                                print('Đơn vị thiết kế: $donViThietKe');
                              },
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.only(
                                    top: 0, bottom: 0, left: 5, right: 5),
                                // labelText: 'Tên cầu',
                                hintText: 'Nhập...',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7),
                                  borderSide: const BorderSide(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 120,
                            child: Text('Đơn vị thi công'),
                          ),
                          Container(
                            width: 210,
                            margin: const EdgeInsets.all(7),
                            child: TextField(
                              controller: _controllerDonViThiCong,
                              onChanged: (newValue) {
                                setState(() {
                                  donViThiCong = newValue;
                                });
                                print('Đơn vị thi công: $donViThiCong');
                              },
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.only(
                                    top: 0, bottom: 0, left: 5, right: 5),
                                // labelText: 'Tên cầu',
                                hintText: 'Nhập...',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7),
                                  borderSide: const BorderSide(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 120,
                            child: Text('Đơn vị giám sát'),
                          ),
                          Container(
                            width: 210,
                            margin: const EdgeInsets.all(7),
                            child: TextField(
                              controller: _controllerDonViGiamSat,
                              onChanged: (newValue) {
                                setState(() {
                                  donViGiamSat = newValue;
                                });
                                print('Đơn vị giám sát: $donViGiamSat');
                              },
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.only(
                                    top: 0, bottom: 0, left: 5, right: 5),
                                // labelText: 'Tên cầu',
                                hintText: 'Nhập...',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7),
                                  borderSide: const BorderSide(),
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
                  margin: const EdgeInsets.only(top: 7),
                  width: 320,
                  height: 45,
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    // borderRadius: BorderRadius.circular(7),
                  ),
                  child: const ListTile(
                    leading: Icon(
                      Icons.image,
                      color: Colors.white,
                    ),
                    title: Text(
                      'CẤU TẠO CẦU',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(7),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(7),
                        bottomLeft: Radius.circular(7),
                        bottomRight: Radius.circular(7),
                      ),
                      border: Border.all(color: const Color(0xFFadb5bd))),
                  child: Column(children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 110,
                            child: Text('Số nhịp'),
                          ),
                          Container(
                            width: 220,
                            margin: const EdgeInsets.all(7),
                            child: TextField(
                              controller: _controllerSoNhip,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9]'))
                              ],
                              onChanged: (newValue) {
                                setState(() {
                                  if (newValue.trim() == "") {
                                    soNhip = 0;
                                  } else {
                                    soNhip = int.parse(newValue);
                                  }
                                });
                                print('Số nhịp: $soNhip');
                              },
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.only(
                                    top: 0, bottom: 0, left: 5, right: 5),
                                // labelText: 'Tên cầu',
                                hintText: 'Nhập...',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7),
                                  borderSide: const BorderSide(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 110,
                            child: Text('Số mố'),
                          ),
                          Container(
                            width: 220,
                            margin: const EdgeInsets.all(7),
                            child: TextField(
                              controller: _controllerSoMo,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9]'))
                              ],
                              onChanged: (newValue) {
                                setState(() {
                                  if (newValue.trim() == "") {
                                    soMo = 0;
                                  } else {
                                    soMo = int.parse(newValue);
                                  }
                                });
                                print('Số mố: $soMo');
                              },
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.only(
                                    top: 0, bottom: 0, left: 5, right: 5),
                                // labelText: 'Tên cầu',
                                hintText: 'Nhập...',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7),
                                  borderSide: const BorderSide(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 110,
                            child: Text('Số trụ'),
                          ),
                          Container(
                            width: 220,
                            margin: const EdgeInsets.all(7),
                            child: TextField(
                              controller: _controllerSoTru,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9]'))
                              ],
                              onChanged: (newValue) {
                                setState(() {
                                  if (newValue.trim() == "") {
                                    soTru = 0;
                                  } else {
                                    soTru = int.parse(newValue);
                                  }
                                });
                                print('Số trụ: $soTru');
                              },
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.only(
                                    top: 0, bottom: 0, left: 5, right: 5),
                                // labelText: 'Tên cầu',
                                hintText: 'Nhập...',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7),
                                  borderSide: const BorderSide(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 110,
                            child: Text('Số dầm ngang'),
                          ),
                          Container(
                            width: 220,
                            margin: const EdgeInsets.all(7),
                            child: TextField(
                              controller: _controllerSoDamNgang,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9]'))
                              ],
                              onChanged: (newValue) {
                                setState(() {
                                  if (newValue.trim() == "") {
                                    soDamNgang = 0;
                                  } else {
                                    soDamNgang = int.parse(newValue);
                                  }
                                });
                                print('Số dầm ngang: $soDamNgang');
                              },
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.only(
                                    top: 0, bottom: 0, left: 5, right: 5),
                                // labelText: 'Tên cầu',
                                hintText: 'Nhập...',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7),
                                  borderSide: const BorderSide(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 110,
                            child: Text('Số dầm chính'),
                          ),
                          Container(
                            width: 220,
                            margin: const EdgeInsets.all(7),
                            child: TextField(
                              controller: _controllerSoDamChinh,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9]'))
                              ],
                              onChanged: (newValue) {
                                setState(() {
                                  if (newValue.trim() == "") {
                                    soDamChinh = 0;
                                  } else {
                                    soDamChinh = int.parse(newValue);
                                  }
                                });
                                print('Số dầm chính: $soDamChinh');
                              },
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.only(
                                    top: 0, bottom: 0, left: 5, right: 5),
                                // labelText: 'Tên cầu',
                                hintText: 'Nhập...',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7),
                                  borderSide: const BorderSide(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 110,
                            child: Text('Số lan can'),
                          ),
                          Container(
                            width: 220,
                            margin: const EdgeInsets.all(7),
                            child: TextField(
                              controller: _controllerSoLanCan,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9]'))
                              ],
                              onChanged: (newValue) {
                                setState(() {
                                  if (newValue.trim() == "") {
                                    soLanCan = 0;
                                  } else {
                                    soLanCan = int.parse(newValue);
                                  }
                                });
                                print('Số lan can: $soLanCan');
                              },
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.only(
                                    top: 0, bottom: 0, left: 5, right: 5),
                                // labelText: 'Tên cầu',
                                hintText: 'Nhập...',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7),
                                  borderSide: const BorderSide(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 110,
                            child: Text('Số dải phân cách'),
                          ),
                          Container(
                            width: 220,
                            margin: const EdgeInsets.all(7),
                            child: TextField(
                              controller: _controllerSoDaiPhanCach,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9]'))
                              ],
                              onChanged: (newValue) {
                                setState(() {
                                  if (newValue.trim() == "") {
                                    soDaiPhanCach = 0;
                                  } else {
                                    soDaiPhanCach = int.parse(newValue);
                                  }
                                });
                                print('Số dải phân cách: $soDaiPhanCach');
                              },
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.only(
                                    top: 0, bottom: 0, left: 5, right: 5),
                                // labelText: 'Tên cầu',
                                hintText: 'Nhập...',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7),
                                  borderSide: const BorderSide(),
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
                  margin: const EdgeInsets.only(top: 7),
                  width: 320,
                  height: 45,
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    // borderRadius: BorderRadius.circular(7),
                  ),
                  child: const ListTile(
                    leading: Icon(
                      Icons.image,
                      color: Colors.white,
                    ),
                    title: Text(
                      'VẬT LIỆU CẦU',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(7),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(7),
                        bottomLeft: Radius.circular(7),
                        bottomRight: Radius.circular(7),
                      ),
                      border: Border.all(color: const Color(0xFFadb5bd))),
                  child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 100,
                                child: Text('Dầm chính'),
                              ),
                              Container(
                                width: 220,
                                margin: const EdgeInsets.all(7),
                                child: TextField(
                                  controller: _controllerVlDamChinh,
                                  onChanged: (newValue) {
                                    setState(() {
                                      vlDamChinh = newValue;
                                    });
                                    print('Vật liệu dầm chính: $vlDamChinh');
                                  },
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.only(
                                        top: 0, bottom: 0, left: 5, right: 5),
                                    // labelText: 'Tên cầu',
                                    hintText: 'Nhập...',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(7),
                                      borderSide: const BorderSide(),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 100,
                                child: Text('Dầm ngang'),
                              ),
                              Container(
                                width: 220,
                                margin: const EdgeInsets.all(7),
                                child: TextField(
                                  controller: _controllerVlDamNgang,
                                  onChanged: (newValue) {
                                    setState(() {
                                      vlDamNgang = newValue;
                                    });
                                    print('Vật liệu dầm ngang: $vlDamNgang');
                                  },
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.only(
                                        top: 0, bottom: 0, left: 5, right: 5),
                                    // labelText: 'Tên cầu',
                                    hintText: 'Nhập...',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(7),
                                      borderSide: const BorderSide(),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 100,
                                child: Text('Bán mặt cầu'),
                              ),
                              Container(
                                width: 220,
                                margin: const EdgeInsets.all(7),
                                child: TextField(
                                  controller: _controllerVlBanMatCau,
                                  onChanged: (newValue) {
                                    setState(() {
                                      vlBanMatCau = newValue;
                                    });
                                    print('Vật liệu bán mặt cầu: $vlBanMatCau');
                                  },
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.only(
                                        top: 0, bottom: 0, left: 5, right: 5),
                                    // labelText: 'Tên cầu',
                                    hintText: 'Nhập...',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(7),
                                      borderSide: const BorderSide(),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 100,
                                child: Text('Lan can'),
                              ),
                              Container(
                                width: 220,
                                margin: const EdgeInsets.all(7),
                                child: TextField(
                                  controller: _controllerVlLanCan,
                                  onChanged: (newValue) {
                                    setState(() {
                                      vlLanCan = newValue;
                                    });
                                    print('Vật liệu lan can: $vlLanCan');
                                  },
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.only(
                                        top: 0, bottom: 0, left: 5, right: 5),
                                    // labelText: 'Tên cầu',
                                    hintText: 'Nhập...',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(7),
                                      borderSide: const BorderSide(),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 100,
                                child: Text('Mố'),
                              ),
                              Container(
                                width: 220,
                                margin: const EdgeInsets.all(7),
                                child: TextField(
                                  controller: _controllerVlMo,
                                  onChanged: (newValue) {
                                    setState(() {
                                      vlMo = newValue;
                                    });
                                    print('Vật liệu mố: $vlMo');
                                  },
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.only(
                                        top: 0, bottom: 0, left: 5, right: 5),
                                    // labelText: 'Tên cầu',
                                    hintText: 'Nhập...',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(7),
                                      borderSide: const BorderSide(),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 100,
                                child: Text('Trụ'),
                              ),
                              Container(
                                width: 220,
                                margin: const EdgeInsets.all(7),
                                child: TextField(
                                  controller: _controllerVlTru,
                                  onChanged: (newValue) {
                                    setState(() {
                                      vlTru = newValue;
                                    });
                                    print('Vật liệu trụ: $vlTru');
                                  },
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.only(
                                        top: 0, bottom: 0, left: 5, right: 5),
                                    // labelText: 'Tên cầu',
                                    hintText: 'Nhập...',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(7),
                                      borderSide: const BorderSide(),
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
                  margin: const EdgeInsets.only(top: 7),
                  width: 320,
                  height: 45,
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    // borderRadius: BorderRadius.circular(7),
                  ),
                  child: const ListTile(
                    leading: Icon(
                      Icons.image,
                      color: Colors.white,
                    ),
                    title: Text(
                      'KÍCH THƯỚC CẦU',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(7),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(7),
                        bottomLeft: Radius.circular(7),
                        bottomRight: Radius.circular(7),
                      ),
                      border: Border.all(color: const Color(0xFFadb5bd))),
                  child: Column(children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 120,
                            child: Text('Chiều dài nhịp'),
                          ),
                          Container(
                            width: 210,
                            margin: const EdgeInsets.all(7),
                            child: TextField(
                              controller: _controllerChieuDaiNhip,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'^\d*\.?\d*$'))
                              ],
                              onChanged: (newValue) {
                                setState(() {
                                  if (newValue.trim() == "") {
                                    chieuDaiNhip = 0.0;
                                  } else {
                                    chieuDaiNhip = double.parse(newValue);
                                  }
                                });
                                print('Chiều dài nhịp: $chieuDaiNhip');
                              },
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.only(
                                    top: 0, bottom: 0, left: 5, right: 5),
                                // labelText: 'Tên cầu',
                                hintText: 'Nhập...',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7),
                                  borderSide: const BorderSide(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 120,
                            child: Text('Bề rộng xe chạy (m)'),
                          ),
                          Container(
                            width: 210,
                            margin: const EdgeInsets.all(7),
                            child: TextField(
                              controller: _controllerBeRongXeChay,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'^\d*\.?\d*$'))
                              ],
                              onChanged: (newValue) {
                                setState(() {
                                  if (newValue.trim() == "") {
                                    beRongXeChay = 0.0;
                                  } else {
                                    beRongXeChay = double.parse(newValue);
                                  }
                                });
                                print('Bề rộng xe chạy: $beRongXeChay');
                              },
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.only(
                                    top: 0, bottom: 0, left: 5, right: 5),
                                // labelText: 'Tên cầu',
                                hintText: 'Nhập...',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7),
                                  borderSide: const BorderSide(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 120,
                            child: Text('Khoảng cách dầm chính'),
                          ),
                          Container(
                            width: 210,
                            margin: const EdgeInsets.all(7),
                            child: TextField(
                              controller: _controllerKhoangCachDamChinh,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'^\d*\.?\d*$'))
                              ],
                              onChanged: (newValue) {
                                setState(() {
                                  if (newValue.trim() == "") {
                                    khoangCachDamChinh = 0.0;
                                  } else {
                                    khoangCachDamChinh = double.parse(newValue);
                                  }
                                });
                                print(
                                    'Khoảng cách dầm chính: $khoangCachDamChinh');
                              },
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.only(
                                    top: 0, bottom: 0, left: 5, right: 5),
                                // labelText: 'Tên cầu',
                                hintText: 'Nhập...',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7),
                                  borderSide: const BorderSide(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 120,
                            child: Text('Khoảng cách dầm ngang'),
                          ),
                          Container(
                            width: 210,
                            margin: const EdgeInsets.all(7),
                            child: TextField(
                              controller: _controllerKhoangCachDamNgang,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'^\d*\.?\d*$'))
                              ],
                              onChanged: (newValue) {
                                setState(() {
                                  if (newValue.trim() == "") {
                                    khoangCachDamNgang = 0.0;
                                  } else {
                                    khoangCachDamNgang = double.parse(newValue);
                                  }
                                });
                                print(
                                    'Khoảng cách dầm ngang: $khoangCachDamNgang');
                              },
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.only(
                                    top: 0, bottom: 0, left: 5, right: 5),
                                // labelText: 'Tên cầu',
                                hintText: 'Nhập...',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7),
                                  borderSide: const BorderSide(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 120,
                            child: Text('Chiều cao bản mặt cầu (m)'),
                          ),
                          Container(
                            width: 210,
                            margin: const EdgeInsets.all(7),
                            child: TextField(
                              controller: _controllerChieuCaoBanMatCau,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'^\d*\.?\d*$'))
                              ],
                              onChanged: (newValue) {
                                setState(() {
                                  if (newValue.trim() == "") {
                                    chieuCaoBanMatCau = 0.0;
                                  } else {
                                    chieuCaoBanMatCau = double.parse(newValue);
                                  }
                                });
                                print(
                                    'Chiều cao bán mặt cầu: $chieuCaoBanMatCau');
                              },
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.only(
                                    top: 0, bottom: 0, left: 5, right: 5),
                                // labelText: 'Tên cầu',
                                hintText: 'Nhập...',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7),
                                  borderSide: const BorderSide(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 120,
                            child: Text('Bề rộng lan can (m)'),
                          ),
                          Container(
                            width: 210,
                            margin: const EdgeInsets.all(7),
                            child: TextField(
                              controller: _controllerBeRongLanCan,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'^\d*\.?\d*$'))
                              ],
                              onChanged: (newValue) {
                                setState(() {
                                  if (newValue.trim() == "") {
                                    beRongLanCan = 0.0;
                                  } else {
                                    beRongLanCan = double.parse(newValue);
                                  }
                                });
                                print('Bề rộng lan can: $beRongLanCan');
                              },
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.only(
                                    top: 0, bottom: 0, left: 5, right: 5),
                                // labelText: 'Tên cầu',
                                hintText: 'Nhập...',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7),
                                  borderSide: const BorderSide(),
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
