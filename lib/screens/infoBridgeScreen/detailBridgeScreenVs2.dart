import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_4/screens/infoBridgeScreen/infoBridgeScreen.dart';
import 'package:flutter_application_4/services/controllers/detailBridgeController.dart';
import 'package:flutter_application_4/services/controllers/imageController.dart';
import 'package:flutter_application_4/services/models/detailBridgeModel.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:image_picker/image_picker.dart';

class DetailAndUpdate extends StatefulWidget {
  final detailBridgeController dBC = detailBridgeController();
  final int idBridge;
  DetailAndUpdate({Key? key, required this.idBridge}) : super(key: key);

  @override
  State<DetailAndUpdate> createState() => _DetailState();
}

class _DetailState extends State<DetailAndUpdate> {
  imageController iC = imageController();
  final MapController mapController = MapController();
  late Future<detailBridgeModel> _futureBridgeList;
  // biến kết quả thêm trả về của hàm putApi
  int? result;
  // late Future<List<RepairModel>> _futureRepairList;
  DateTime NKhoiCong = DateTime.now();
  DateTime NHoanThanh = DateTime.now();
  String? anhCayCau = "";
  String? anhMatCat = "";
  String? anhBinhDo = "";
  // thông tin chung
  final TextEditingController _controllerTenCayCau = TextEditingController();
  final TextEditingController _controllerLoaiCau = TextEditingController();
  final TextEditingController _controllerCap = TextEditingController();
  final TextEditingController _controllerLyTrinh = TextEditingController();
  final TextEditingController _controllerTaiTrong = TextEditingController();
  final TextEditingController _controllerChieuDai = TextEditingController();
  final TextEditingController _controllerChieuRong = TextEditingController();
  final TextEditingController _controllerDiaDiem = TextEditingController();
  final TextEditingController _controllerKinhDo = TextEditingController();
  final TextEditingController _controllerViDo = TextEditingController();
  // thông tin thi công
  final TextEditingController _controllerNgayKhoiCong = TextEditingController();
  final TextEditingController _controllerNgayHoanThanh =
      TextEditingController();
  late String ngayKhoiCong = '';
  late String ngayHoanThanh = '';
  int? chiPhiXayDung = null;
  final TextEditingController _controllerChiPhiXayDung =
      TextEditingController();
  final TextEditingController _controllerChuDauTu = TextEditingController();
  final TextEditingController _controllerDonViThietKe = TextEditingController();
  final TextEditingController _controllerDonViThiCong = TextEditingController();
  final TextEditingController _controllerDonViGiamSat = TextEditingController();
  // cấu tạo cầu
  final TextEditingController _controllerSoNhip = TextEditingController();
  final TextEditingController _controllerSoMo = TextEditingController();
  final TextEditingController _controllerSoTru = TextEditingController();
  final TextEditingController _controllerSoDamNgang = TextEditingController();
  final TextEditingController _controllerSoDamChinh = TextEditingController();
  final TextEditingController _controllerSoLanCan = TextEditingController();
  final TextEditingController _controllerSoDaiPhanCach =
      TextEditingController();
  // vật liệu cầu
  final TextEditingController _controllerVlDamChinh = TextEditingController();
  final TextEditingController _controllerVlDamNgang = TextEditingController();
  final TextEditingController _controllerVlBanMatCau = TextEditingController();
  final TextEditingController _controllerVlLanCan = TextEditingController();
  final TextEditingController _controllerVlMo = TextEditingController();
  final TextEditingController _controllerVlTru = TextEditingController();
  // kích thước cầu
  final TextEditingController _controllerChieuDaiNhip = TextEditingController();
  final TextEditingController _controllerBeRongXeChay = TextEditingController();
  final TextEditingController _controllerKhoangCachDamChinh =
      TextEditingController();
  final TextEditingController _controllerKhoangCachDamNgang =
      TextEditingController();
  final TextEditingController _controllerChieuCaoBanMatCau =
      TextEditingController();
  final TextEditingController _controllerBeRongLanCan = TextEditingController();
  // ảnh ban đầu của cầu
  String? _hinhAnhCauSrc;
  String? _hinhAnhMatCatSrc;
  String? _hinhAnhBinhDoSrc;
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

        // kiểm tra kết quả trả về
        anhCayCau = _hinhAnhCauSrc.toString();
        print('Hình ảnh cầu SRC: ' + anhCayCau.toString());
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

        // kiểm tra kết quả trả về
        anhMatCat = _hinhAnhMatCatSrc.toString();
        print('Hình ảnh mặt cắt SRC: ' + anhMatCat.toString());
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

        // kiểm tra kết quả trả về
        anhBinhDo = _hinhAnhBinhDoSrc.toString();
        print('Hình ảnh bình đồ SRC: ' + anhBinhDo.toString());
      });
    }
  }

  //
  void PutBridge() async {
    double KD = double.parse(_controllerKinhDo.text);
    double VD = double.parse(_controllerViDo.text);
    int SN = int.parse(_controllerSoNhip.text);
    int SM = int.parse(_controllerSoMo.text);
    int ST = int.parse(_controllerSoTru.text);
    int SDN = int.parse(_controllerSoDamNgang.text);
    int SDC = int.parse(_controllerSoDamChinh.text);
    int SLC = int.parse(_controllerSoLanCan.text);
    int SDPC = int.parse(_controllerSoDaiPhanCach.text);
    double CDN = double.parse(_controllerChieuDaiNhip.text);
    double BRXC = double.parse(_controllerBeRongXeChay.text);
    double KCDC = double.parse(_controllerKhoangCachDamChinh.text);
    double KCDN = double.parse(_controllerKhoangCachDamNgang.text);
    double CCBMC = double.parse(_controllerChieuCaoBanMatCau.text);
    double BRLC = double.parse(_controllerBeRongLanCan.text);
    String anhCau, anhCat, anhBinh;

    if (anhCayCau as String == "") {
      anhCau = _hinhAnhCauSrc as String;
    } else {
      anhCau = anhCayCau as String;
    }

    if (anhMatCat as String == "") {
      anhCat = _hinhAnhMatCatSrc as String;
    } else {
      anhCat = anhMatCat as String;
    }

    if (anhBinhDo as String == "") {
      anhBinh = _hinhAnhBinhDoSrc as String;
    } else {
      anhBinh = anhBinhDo as String;
    }

    result = await widget.dBC.putApi(
        widget.idBridge,
        anhCau,
        anhCat,
        anhBinh,
        _controllerTenCayCau.text,
        _controllerLoaiCau.text,
        _controllerCap.text,
        _controllerLyTrinh.text,
        _controllerTaiTrong.text,
        _controllerChieuDai.text,
        _controllerChieuRong.text,
        _controllerDiaDiem.text,
        KD,
        VD,
        _controllerNgayKhoiCong.text,
        _controllerNgayHoanThanh.text,
        null,
        _controllerChuDauTu.text,
        _controllerDonViThietKe.text,
        _controllerDonViThiCong.text,
        _controllerDonViGiamSat.text,
        SN,
        SM,
        ST,
        SDN,
        SDC,
        SLC,
        SDPC,
        _controllerVlDamChinh.text,
        _controllerVlDamNgang.text,
        _controllerVlBanMatCau.text,
        _controllerVlLanCan.text,
        _controllerVlMo.text,
        _controllerVlTru.text,
        CDN,
        BRXC,
        KCDC,
        KCDN,
        CCBMC,
        BRLC);
    if (result == 200) {
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
  void setDataController(detailBridgeModel detaiTemp) {
    _hinhAnhCauSrc = detaiTemp.hinhAnhCau as String;
    _hinhAnhBinhDoSrc = detaiTemp.hinhAnhBinhDo as String;
    _hinhAnhMatCatSrc = detaiTemp.hinhAnhMatCat as String;
    _controllerTenCayCau.text = detaiTemp.tenCayCau as String;
    _controllerLoaiCau.text = detaiTemp.loaiCau as String;
    _controllerCap.text = detaiTemp.cap as String;
    _controllerLyTrinh.text = detaiTemp.lyTrinh as String;
    _controllerTaiTrong.text = detaiTemp.taiTrong as String;
    _controllerChieuDai.text = detaiTemp.chieuDai as String;
    _controllerChieuRong.text = detaiTemp.chieuRong as String;
    _controllerDiaDiem.text = detaiTemp.diaDiem as String;
    double kinhDo = detaiTemp.kinhDo as double;
    double viDo = detaiTemp.viDo as double;
    _controllerKinhDo.text = kinhDo.toString();
    _controllerViDo.text = viDo.toString();
    chiPhiXayDung = detaiTemp.chiPhiXayDung as int;
    _controllerChiPhiXayDung.text = chiPhiXayDung.toString();
    _controllerNgayKhoiCong.text = detaiTemp.ngayKhoiCong as String;
    ngayKhoiCong = detaiTemp.ngayKhoiCong as String;
    _controllerNgayHoanThanh.text = detaiTemp.ngayHoanThanh as String;
    ngayHoanThanh = detaiTemp.ngayHoanThanh as String;
    chiPhiXayDung = detaiTemp.chiPhiXayDung;
    _controllerChuDauTu.text = detaiTemp.chuDauTu as String;
    _controllerDonViThietKe.text = detaiTemp.donViThietKe as String;
    _controllerDonViThiCong.text = detaiTemp.donViThiCong as String;
    _controllerDonViGiamSat.text = detaiTemp.donViGiamSat as String;
    int soNhip = detaiTemp.soNhip as int;
    _controllerSoNhip.text = soNhip.toString();
    int soMo = detaiTemp.soMo as int;
    _controllerSoMo.text = soMo.toString();
    int soTru = detaiTemp.soTru as int;
    _controllerSoTru.text = soTru.toString();
    int soDamNgang = detaiTemp.soDamNgang as int;
    _controllerSoDamNgang.text = soDamNgang.toString();
    int soDamChinh = detaiTemp.soDamChinh as int;
    _controllerSoDamChinh.text = soDamChinh.toString();
    int soLanCan = detaiTemp.soLanCan as int;
    _controllerSoLanCan.text = soLanCan.toString();
    int soDaiPhanCach = detaiTemp.soDaiPhanCach as int;
    _controllerSoDaiPhanCach.text = soDaiPhanCach.toString();
    _controllerVlDamChinh.text = detaiTemp.damChinh as String;
    _controllerVlDamNgang.text = detaiTemp.damNgang as String;
    _controllerVlBanMatCau.text = detaiTemp.banMatCau as String;
    _controllerVlLanCan.text = detaiTemp.lanCan as String;
    _controllerVlMo.text = detaiTemp.mo as String;
    _controllerVlTru.text = detaiTemp.tru as String;
    double chieuDaiNhip = detaiTemp.chieuDaiNhip as double;
    double beRongXeChay = detaiTemp.beRongXeChay as double;
    double khoangCachDamChinh = detaiTemp.khoangCachDamChinh as double;
    double khoanCachDamNgang = detaiTemp.khoanCachDamNgang as double;
    double chieuCaoBanMatCau = detaiTemp.chieuCaoBanMatCau as double;
    double BeRongLanCan = detaiTemp.beRongLanCan as double;
    _controllerChieuDaiNhip.text = chieuDaiNhip.toString();
    _controllerBeRongXeChay.text = beRongXeChay.toString();
    _controllerKhoangCachDamChinh.text = khoangCachDamChinh.toString();
    _controllerKhoangCachDamNgang.text = khoanCachDamNgang.toString();
    _controllerChieuCaoBanMatCau.text = chieuCaoBanMatCau.toString();
    _controllerBeRongLanCan.text = BeRongLanCan.toString();
  }

//
  @override
  void initState() {
    super.initState();
    _futureBridgeList =
        widget.dBC.getApiById(widget.idBridge) as Future<detailBridgeModel>;

    //_futureRepairList = widget.repairController.getApi();
  }

  void setDataStart(detailBridgeModel temp) {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Chi tiết / cập nhật'),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            //PutBridge
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Thông báo'),
                  content: Text(
                      'Bạn cập nhật lại thông tin của   ${_controllerTenCayCau.text}'),
                  actions: [
                    TextButton(
                      child: const Text('Huỷ bỏ'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      child: const Text('Xác nhận cập nhật'),
                      onPressed: () {
                        // Xử lý khi người dùng chọn xác nhận
                        PutBridge();
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
          label: Text('Lưu thay đổi'),
          icon: Icon(Icons.save_alt),
          backgroundColor: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        // endDrawer: menu(),
        body: SingleChildScrollView(
          child: FutureBuilder<detailBridgeModel>(
            future: _futureBridgeList,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                detailBridgeModel? bridgeList = snapshot.data;
                if (bridgeList!.bridgeId == widget.idBridge) {
                  setDataController(bridgeList);

                  return Column(
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
                                  border: Border.all(
                                      color: const Color(0xFFadb5bd))),
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
                                            image: NetworkImage(_imageFile ==
                                                    null
                                                ? _hinhAnhCauSrc == ""
                                                    ? 'http://171.244.8.103:9003//placeholder.jpg'
                                                    : 'http://171.244.8.103:9003/$_hinhAnhCauSrc'
                                                : 'http://171.244.8.103:9003/$anhCayCau')),
                                        TextButton(
                                            onPressed: () => {
                                                  _pickImage(
                                                      ImageSource.gallery),
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
                                            image: NetworkImage(_imageFileBinhDo ==
                                                    null
                                                ? _hinhAnhBinhDoSrc == ""
                                                    ? 'http://171.244.8.103:9003//placeholder.jpg'
                                                    : 'http://171.244.8.103:9003/$_hinhAnhBinhDoSrc'
                                                : 'http://171.244.8.103:9003/$anhBinhDo')),
                                        TextButton(
                                            onPressed: () => {
                                                  _pickImageBinhDo(
                                                      ImageSource.gallery),
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
                                            image: NetworkImage(_imageFileMatCat ==
                                                    null
                                                ? _hinhAnhMatCatSrc == ""
                                                    ? 'http://171.244.8.103:9003//placeholder.jpg'
                                                    : 'http://171.244.8.103:9003/$_hinhAnhMatCatSrc'
                                                : 'http://171.244.8.103:9003/$anhMatCat')),
                                        TextButton(
                                            onPressed: () => {
                                                  _pickImageMatCat(
                                                      ImageSource.gallery),
                                                },
                                            child: const Text('Chọn hình')),
                                      ]),
                                    )
                                  ]),
                            ),
                          ],
                        ),
                      ),
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
                                      Expanded(child: Container(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                180,
                                        margin: EdgeInsets.all(7),
                                        child: TextField(
                                          onChanged: (newValue) {
                                            // setState(() {
                                            //   _controllerTenCayCau.text =
                                            //       newValue;
                                            // });
                                            print('tên cầu: ' +
                                                _controllerTenCayCau.text);
                                          },
                                          controller: _controllerTenCayCau,
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.only(
                                                top: 0,
                                                bottom: 0,
                                                left: 5,
                                                right: 5),
                                            hintText: _controllerTenCayCau.text,
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(7),
                                              borderSide: BorderSide(),
                                            ),
                                          ),
                                        ),
                                      ),),
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
                                      Expanded(child: Container(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                180,
                                        margin: EdgeInsets.all(7),
                                        child: TextField(
                                          onChanged: (newValue) {
                                            // setState(() {
                                            //   _controllerLoaiCau.text =
                                            //       newValue;
                                            // });
                                            print('tên cầu: ' +
                                                _controllerLoaiCau.text);
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
                                      ),),
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
                                      Expanded(child: Container(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                180,
                                        margin: EdgeInsets.all(7),
                                        child: TextField(
                                          controller: _controllerCap,
                                          onChanged: (newValue) {
                                            // setState(() {
                                            //   _controllerCap.text = newValue;
                                            // });
                                            print(
                                                'Cấp :' + _controllerCap.text);
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
                                      ),),
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
                                      Expanded(child: Container(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                180,
                                        margin: EdgeInsets.all(7),
                                        child: TextField(
                                          controller: _controllerLyTrinh,
                                          onChanged: (newValue) {
                                            // setState(() {
                                            //   _controllerLyTrinh.text =
                                            //       newValue;
                                            // });
                                            print('Lý trình: ' +
                                                _controllerLyTrinh.text);
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
                                      ),),
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
                                      Expanded(child: Container(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                180,
                                        margin: EdgeInsets.all(7),
                                        child: TextField(
                                          controller: _controllerTaiTrong,
                                          onChanged: (newValue) {
                                            // setState(() {
                                            //   _controllerTaiTrong.text =
                                            //       newValue;
                                            // });
                                            print('Tải trọng: ' +
                                                _controllerTaiTrong.text);
                                          },
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.only(
                                                top: 0,
                                                bottom: 0,
                                                left: 5,
                                                right: 5),
                                            // labelText: 'Tên cầu',
                                            hintText: _controllerTaiTrong.text,
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(7),
                                              borderSide: BorderSide(),
                                            ),
                                          ),
                                        ),
                                      ),),
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
                                      Expanded(child: Container(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                180,
                                        margin: EdgeInsets.all(7),
                                        child: TextField(
                                          controller: _controllerChieuDai,
                                          onChanged: (newValue) {
                                            // setState(() {
                                            //   _controllerChieuDai.text =
                                            //       newValue;
                                            // });
                                            print('Chiều dài: ' +
                                                _controllerChieuDai.text);
                                          },
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.only(
                                                top: 0,
                                                bottom: 0,
                                                left: 5,
                                                right: 5),
                                            // labelText: 'Tên cầu',
                                            hintText: _controllerChieuDai.text,
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(7),
                                              borderSide: BorderSide(),
                                            ),
                                          ),
                                        ),
                                      ),),
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
                                      Expanded(child:  Container(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                180,
                                        margin: EdgeInsets.all(7),
                                        child: TextField(
                                          controller: _controllerChieuRong,
                                          onChanged: (newValue) {
                                            // setState(() {
                                            //   _controllerChieuRong.text =
                                            //       newValue;
                                            // });
                                            print('Chiều rộng: ' +
                                                _controllerChieuRong.text);
                                          },
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.only(
                                                top: 0,
                                                bottom: 0,
                                                left: 5,
                                                right: 5),
                                            // labelText: 'Tên cầu',
                                            hintText: _controllerChieuRong.text,
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(7),
                                              borderSide: BorderSide(),
                                            ),
                                          ),
                                        ),
                                      ),),
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
                              Expanded(child: Container(
                                width: 260,
                                margin: const EdgeInsets.all(7),
                                child: TextField(
                                  controller: _controllerDiaDiem,
                                  onChanged: (newValue) {
                                    // setState(() {
                                    //   _controllerDiaDiem.text = newValue;
                                    // });
                                    print(
                                        'Địa điểm: ' + _controllerDiaDiem.text);
                                  },
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
                              ),),
                            ]),
                          ),
                          Container(
                            child: Row(children: [
                              const SizedBox(
                                width: 70,
                                child: Text('Kinh độ'),
                              ),
                              Expanded(child: Container(
                                width: 260,
                                margin: const EdgeInsets.all(7),
                                child: TextField(
                                  enabled: false,
                                  onChanged: (newValue) {
                                    // setState(() {
                                    //   if (newValue.trim() == "") {
                                    //     _controllerKinhDo.text = '0.00';
                                    //   } else {
                                    //     _controllerKinhDo.text = newValue;
                                    //   }
                                    // });
                                    print('Kinh độ: ' + _controllerKinhDo.text);
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
                              ),),
                            ]),
                          ),
                          Container(
                            child: Row(children: [
                              const SizedBox(
                                width: 70,
                                child: Text('Vĩ độ'),
                              ),
                              Expanded(child: Container(
                                width: 260,
                                margin: const EdgeInsets.all(7),
                                child: TextField(
                                  enabled: false,
                                  onChanged: (newValue) {
                                    // setState(() {
                                    //   if (newValue.trim() == "") {
                                    //     _controllerViDo.text = '0.00';
                                    //   } else {
                                    //     _controllerViDo.text = newValue;
                                    //   }
                                    // });
                                    print('Vĩ độ: ' + _controllerViDo.text);
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
                              ),),
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
                                      double kinhDo = 0.00;
                                      double viDo = 0.00;
                                      final lat = tapPosition.latitude;
                                      final lng = tapPosition.latitude;
                                      // set kinh độ
                                      _controllerKinhDo.text = lat.toString();
                                      // -> kinhDo
                                      kinhDo =
                                          double.parse(_controllerKinhDo.text);
                                      print('Kinh độ: $kinhDo');
                                      // set vĩ độ
                                      _controllerViDo.text = lng.toString();
                                      // -> viDo
                                      viDo = double.parse(_controllerViDo.text);
                                      print('Vĩ độ: $viDo');
                                    }
                                  },
                                  center: LatLng(
                                      double.parse(_controllerKinhDo.text),
                                      double.parse(_controllerViDo.text)),
                                  zoom: 15),
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
                        child: Container(
                          padding: const EdgeInsets.all(7),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(7),
                                bottomLeft: Radius.circular(7),
                                bottomRight: Radius.circular(7),
                              ),
                              border:
                                  Border.all(color: const Color(0xFFadb5bd))),
                          child: Column(children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                children: [
                                  const SizedBox(
                                    width: 120,
                                    child: Text('Ngày khởi công'),
                                  ),
                                  Expanded(child: Container(
                                    width: 145,
                                    margin: const EdgeInsets.all(7),
                                    child: TextField(
                                      enabled: false,
                                      onChanged: (newValue) {},
                                      controller: _controllerNgayKhoiCong,
                                      decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.only(
                                            top: 0,
                                            bottom: 0,
                                            left: 5,
                                            right: 5),
                                        // hintText: ngayKhoiCong,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(7),
                                          borderSide: const BorderSide(),
                                        ),
                                      ),
                                    ),
                                  ),),
                                  ElevatedButton(
                                    onPressed: () async {
                                      // Future<void> _selectDate(BuildContext context) async {
                                      final DateTime? picked =
                                          await showDatePicker(
                                        context: context,
                                        initialDate: NKhoiCong,
                                        firstDate: DateTime(1900),
                                        lastDate: DateTime(2101),
                                      );
                                      if (picked != null &&
                                          picked != NKhoiCong) {
                                        setState(() {
                                          NKhoiCong = DateTime(picked.year,
                                              picked.month, picked.day);
                                          _controllerNgayKhoiCong.text =
                                              ('${NKhoiCong.year.toString()}-${NKhoiCong.month.toString()}-${NKhoiCong.day.toString()}');

                                          print('Ngày khởi công: ' +
                                              _controllerNgayKhoiCong.text);
                                        });
                                      }
                                      // }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      // độ lớn của nút
                                      backgroundColor:
                                          Colors.white, // màu nền của nút
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
                                  Expanded(child: Container(
                                    width: 145,
                                    margin: const EdgeInsets.all(7),
                                    child: TextField(
                                      enabled: false,
                                      onChanged: (newValue) {},
                                      controller: _controllerNgayHoanThanh,
                                      decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.only(
                                            top: 0,
                                            bottom: 0,
                                            left: 5,
                                            right: 5),
                                        // labelText: 'Tên cầu',
                                        // hintText: ngayHoanThanh,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(7),
                                          borderSide: const BorderSide(),
                                        ),
                                      ),
                                    ),
                                  ),),
                                  ElevatedButton(
                                    onPressed: () async {
                                      // Future<void> _selectDate(BuildContext context) async {
                                      final DateTime? picked =
                                          await showDatePicker(
                                        context: context,
                                        initialDate: NHoanThanh,
                                        firstDate: DateTime(1900),
                                        lastDate: DateTime(2101),
                                      );
                                      if (picked != null &&
                                          picked != NKhoiCong) {
                                        setState(() {
                                          NHoanThanh = DateTime(picked.year,
                                              picked.month, picked.day);
                                          _controllerNgayHoanThanh.text =
                                              ('${NHoanThanh.year.toString()}-${NHoanThanh.month.toString()}-${NHoanThanh.day.toString()}');

                                          print('Ngày hoàn thành: ' +
                                              _controllerNgayHoanThanh.text);
                                        });
                                      }
                                      // }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      // độ lớn của nút
                                      backgroundColor:
                                          Colors.white, // màu nền của nút
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
                                  Expanded(child: Container(
                                    width: 210,
                                    margin: const EdgeInsets.all(7),
                                    child: TextField(
                                      //controller: _controllerChiPhiXayDung,
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
                                            chiPhiXayDung = int.parse(newValue);
                                            chiPhiXayDung =
                                                null; // tạo chi phí null
                                          }
                                        });
                                        print(
                                            'Chi phí xây dưng: $chiPhiXayDung');
                                      },
                                      decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.only(
                                            top: 0,
                                            bottom: 0,
                                            left: 5,
                                            right: 5),
                                        // labelText: 'Tên cầu',
                                        hintText: chiPhiXayDung.toString(),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(7),
                                          borderSide: const BorderSide(),
                                        ),
                                      ),
                                    ),
                                  ),),
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
                                  Expanded(child: Container(
                                    width: 210,
                                    margin: const EdgeInsets.all(7),
                                    child: TextField(
                                      controller: _controllerChuDauTu,
                                      onChanged: (newValue) {
                                        print('Chủ đầu tư: ' +
                                            _controllerChuDauTu.text);
                                      },
                                      decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.only(
                                            top: 0,
                                            bottom: 0,
                                            left: 5,
                                            right: 5),
                                        // labelText: 'Tên cầu',
                                        hintText: 'Nhập ...',
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(7),
                                          borderSide: const BorderSide(),
                                        ),
                                      ),
                                    ),
                                  ),),
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
                                  Expanded(child: Container(
                                    width: 210,
                                    margin: const EdgeInsets.all(7),
                                    child: TextField(
                                      controller: _controllerDonViThietKe,
                                      onChanged: (newValue) {
                                        // setState(() {
                                        //   _controllerDonViThietKe.text = newValue;
                                        // });
                                        print('Đơn vị thiết kế: ' +
                                            _controllerDonViThietKe.text);
                                      },
                                      decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.only(
                                            top: 0,
                                            bottom: 0,
                                            left: 5,
                                            right: 5),
                                        // labelText: 'Tên cầu',
                                        hintText: "Nhập ...",
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(7),
                                          borderSide: const BorderSide(),
                                        ),
                                      ),
                                    ),
                                  ),),
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
                                  Expanded(child: Container(
                                    width: 210,
                                    margin: const EdgeInsets.all(7),
                                    child: TextField(
                                      controller: _controllerDonViThiCong,
                                      onChanged: (newValue) {
                                        // setState(() {
                                        //   _controllerDonViThiCong.text =
                                        //       newValue;
                                        // });
                                        print('Đơn vị thi công: ' +
                                            _controllerDonViThiCong.text);
                                      },
                                      decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.only(
                                            top: 0,
                                            bottom: 0,
                                            left: 5,
                                            right: 5),
                                        // labelText: 'Tên cầu',
                                        hintText: 'Nhập ...',
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(7),
                                          borderSide: const BorderSide(),
                                        ),
                                      ),
                                    ),
                                  ),),
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
                                  Expanded(child: Container(
                                    width: 210,
                                    margin: const EdgeInsets.all(7),
                                    child: TextField(
                                      controller: _controllerDonViGiamSat,
                                      onChanged: (newValue) {
                                        // setState(() {
                                        //   _controllerDonViGiamSat.text =
                                        //       newValue;
                                        // });
                                        print('Đơn vị giám sát: ' +
                                            _controllerDonViGiamSat.text);
                                      },
                                      decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.only(
                                            top: 0,
                                            bottom: 0,
                                            left: 5,
                                            right: 5),
                                        // labelText: 'Tên cầu',
                                        hintText: 'Nhập ...',
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(7),
                                          borderSide: const BorderSide(),
                                        ),
                                      ),
                                    ),
                                  ),)
                                ],
                              ),
                            ),
                          ]),
                        ),
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
                                      // setState(() {
                                      // if (newValue.trim() == "") {
                                      //   _controllerSoNhip.text = '0';
                                      // }else{
                                      //   _controllerSoNhip.text = newValue;
                                      // }
                                      // });
                                      print(
                                          'Số nhịp: ' + _controllerSoNhip.text);
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
                                      // setState(() {
                                      // if (newValue.trim() == "") {
                                      //   _controllerSoMo.text = '0';
                                      // }
                                      // });
                                      print('Số mố: ' + _controllerSoMo.text);
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
                                      // setState(() {
                                      //   if (newValue.trim() == "") {
                                      //     _controllerSoTru.text = '0';
                                      //   }
                                      // });
                                      print('Số trụ: ' + _controllerSoTru.text);
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
                                      // setState(() {
                                      //   if (newValue.trim() == "") {
                                      //     _controllerSoDamNgang.text = '0';
                                      //   }
                                      // });
                                      print('Số dầm ngang: ' +
                                          _controllerSoDamNgang.text);
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
                                      // setState(() {
                                      //   if (newValue.trim() == "") {
                                      //     _controllerSoDamChinh.text = '0';
                                      //   }
                                      // });
                                      print('Số dầm chính: ' +
                                          _controllerSoDamChinh.text);
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
                                      // setState(() {
                                      //   if (newValue.trim() == "") {
                                      //     _controllerSoLanCan.text = '0';
                                      //   }
                                      // });
                                      print('Số lan can: ' +
                                          _controllerSoLanCan.text);
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
                                      // setState(() {
                                      //   if (newValue.trim() == "") {
                                      //     _controllerSoDaiPhanCach.text = '0';
                                      //   }
                                      // });
                                      print('Số dải phân cách: ' +
                                          _controllerSoDaiPhanCach.text);
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
                                          // setState(() {
                                          //   vlDamChinh = newValue;
                                          // });
                                          print('Vật liệu dầm chính: ' +
                                              _controllerVlDamChinh.text);
                                        },
                                        decoration: InputDecoration(
                                          contentPadding: const EdgeInsets.only(
                                              top: 0,
                                              bottom: 0,
                                              left: 5,
                                              right: 5),
                                          // labelText: 'Tên cầu',
                                          hintText: 'Nhập...',
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(7),
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
                                          // setState(() {
                                          //   vlDamNgang = newValue;
                                          // });
                                          print('Vật liệu dầm ngang: ' +
                                              _controllerVlDamNgang.text);
                                        },
                                        decoration: InputDecoration(
                                          contentPadding: const EdgeInsets.only(
                                              top: 0,
                                              bottom: 0,
                                              left: 5,
                                              right: 5),
                                          // labelText: 'Tên cầu',
                                          hintText: 'Nhập...',
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(7),
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
                                          // setState(() {
                                          //   vlBanMatCau = newValue;
                                          // });
                                          print('Vật liệu bán mặt cầu: ' +
                                              _controllerVlBanMatCau.text);
                                        },
                                        decoration: InputDecoration(
                                          contentPadding: const EdgeInsets.only(
                                              top: 0,
                                              bottom: 0,
                                              left: 5,
                                              right: 5),
                                          // labelText: 'Tên cầu',
                                          hintText: 'Nhập...',
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(7),
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
                                          // setState(() {
                                          //   vlLanCan = newValue;
                                          // });
                                          print('Vật liệu lan can: ' +
                                              _controllerVlLanCan.text);
                                        },
                                        decoration: InputDecoration(
                                          contentPadding: const EdgeInsets.only(
                                              top: 0,
                                              bottom: 0,
                                              left: 5,
                                              right: 5),
                                          // labelText: 'Tên cầu',
                                          hintText: 'Nhập...',
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(7),
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
                                          // setState(() {
                                          //   vlMo = newValue;
                                          // });
                                          print('Vật liệu mố: ' +
                                              _controllerVlMo.text);
                                        },
                                        decoration: InputDecoration(
                                          contentPadding: const EdgeInsets.only(
                                              top: 0,
                                              bottom: 0,
                                              left: 5,
                                              right: 5),
                                          // labelText: 'Tên cầu',
                                          hintText: 'Nhập...',
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(7),
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
                                          //setState(() {
                                          //   vlTru = newValue;
                                          // });
                                          print('Vật liệu trụ: ' +
                                              _controllerVlTru.text);
                                        },
                                        decoration: InputDecoration(
                                          contentPadding: const EdgeInsets.only(
                                              top: 0,
                                              bottom: 0,
                                              left: 5,
                                              right: 5),
                                          // labelText: 'Tên cầu',
                                          hintText: 'Nhập...',
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(7),
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
                                      // setState(() {
                                      //   if (newValue.trim() == "") {
                                      //     chieuDaiNhip = 0.0;
                                      //   } else {
                                      //     chieuDaiNhip = double.parse(newValue);
                                      //   }
                                      // });
                                      print('Chiều dài nhịp: ' +
                                          _controllerChieuDaiNhip.text);
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
                                      // setState(() {
                                      //   if (newValue.trim() == "") {
                                      //     beRongXeChay = 0.0;
                                      //   } else {
                                      //     beRongXeChay = double.parse(newValue);
                                      //   }
                                      // });
                                      print('Bề rộng xe chạy: ' +
                                          _controllerBeRongXeChay.text);
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
                                      // setState(() {
                                      //   if (newValue.trim() == "") {
                                      //     khoangCachDamChinh = 0.0;
                                      //   } else {
                                      //     khoangCachDamChinh = double.parse(newValue);
                                      //   }
                                      // });
                                      print('Khoảng cách dầm chính: ' +
                                          _controllerKhoangCachDamChinh.text);
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
                                      // setState(() {
                                      //   if (newValue.trim() == "") {
                                      //     khoangCachDamNgang = 0.0;
                                      //   } else {
                                      //     khoangCachDamNgang = double.parse(newValue);
                                      //   }
                                      // });
                                      print('Khoảng cách dầm ngang: ' +
                                          _controllerKhoangCachDamNgang.text);
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
                                      // setState(() {
                                      //   if (newValue.trim() == "") {
                                      //     chieuCaoBanMatCau = 0.0;
                                      //   } else {
                                      //     chieuCaoBanMatCau = double.parse(newValue);
                                      //   }
                                      // });
                                      print('Chiều cao bán mặt cầu: ' +
                                          _controllerChieuCaoBanMatCau.text);
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
                                      // setState(() {
                                      //   if (newValue.trim() == "") {
                                      //     beRongLanCan = 0.0;
                                      //   } else {
                                      //     beRongLanCan = double.parse(newValue);
                                      //   }
                                      // });
                                      print('Bề rộng lan can: ' +
                                          _controllerBeRongLanCan.text);
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
                  );
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