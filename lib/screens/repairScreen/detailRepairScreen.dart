import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:core';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_4/screens/repairScreen/detailRepairCard.dart';
import 'package:flutter_application_4/screens/repairScreen/repairHomeScreen.dart';
import 'package:flutter_application_4/services/controllers/imageController.dart';
import 'package:flutter_application_4/services/controllers/repairController.dart';
import 'package:flutter_application_4/services/models/bridgeModel.dart';
import 'package:flutter_application_4/services/models/detailRepairModel.dart';
import 'package:flutter_application_4/services/models/repairModel.dart';
import 'package:intl/intl.dart';

class detailRepairScreen extends StatefulWidget {
  final repairController rpC = repairController();
  final int BridgeHistoryId;
  final int bridgeId;
  detailRepairScreen(
      {Key? key, required this.BridgeHistoryId, required this.bridgeId})
      : super(key: key);
  @override
  State<detailRepairScreen> createState() => _detailRepairScreen();
}

class _detailRepairScreen extends State<detailRepairScreen> {
  String? selectedNameBridge;
  List<String> listNameBridge = [];
  RepairModel? rM;

  List<detailRepairModel>? _futureDetailRepairList;
  List<detailRepairModel> listDetailRepair = [];
  String selectedRepair = '';
  int? length;
  int? bridgeId;
  int? result;
  DateTime ThoiGian = DateTime.now();
  final TextEditingController _controllerNgayKiemTra = TextEditingController();
  DateTime Nkiemtra = DateTime.now();
  final TextEditingController _controllerNgaySuaChua = TextEditingController();
  DateTime NSua = DateTime.now();
  TextEditingController _controllerTenCayCau = TextEditingController();
  TextEditingController _controllerDonViKiemTra = TextEditingController();
  TextEditingController _controllerNoiDungHuHong = TextEditingController();
  TextEditingController _controllerDonViSuaChua = TextEditingController();
  TextEditingController _controllerChiPhiSuaChua = TextEditingController();
  //
  TextEditingController _controllerThemChiTietAnh = TextEditingController();
  TextEditingController _controllerThemChiTietNgay = TextEditingController();
  TextEditingController _controllerThemChiTietNoiDung = TextEditingController();
  TextEditingController _controllerThemChiTietGhiChu = TextEditingController();
  imageController iC = imageController();
  //
  File? _imageFile;
  String? _hinhAnhCauSrc = '/placeholder.jpg';
  String? anhCayCau = "";
  int? resultSavedDetail;
  int? resultSaved;
  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().getImage(source: source);
    if (pickedFile != null) {
      final srcTemp = await iC.postImage(File(pickedFile.path));
      setState(() {
        _imageFile = File(pickedFile.path);
        _hinhAnhCauSrc = srcTemp;
        //anhCayCau = _hinhAnhCauSrc.toString();
        print('Hình ảnh cầu SRC: ' + _hinhAnhCauSrc.toString());
        _controllerThemChiTietAnh.text = _hinhAnhCauSrc.toString();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    rM = await widget.rpC.getApiById(widget.BridgeHistoryId);
    _futureDetailRepairList =
        await widget.rpC.getDetailById(widget.BridgeHistoryId);
    _futureDetailRepairList?.forEach((element) {
      listDetailRepair.add(element);
    });
    _controllerTenCayCau.text = rM!.TenCayCau.toString();
    _controllerNgayKiemTra.text = rM!.NgayKiemTra.toString();
    _controllerNgaySuaChua.text = rM!.NgaySuaChua.toString();
    _controllerDonViKiemTra.text = rM!.DonViKiemTra.toString();
    _controllerNoiDungHuHong.text = rM!.LoaiHuHong.toString();
    _controllerDonViSuaChua.text = rM!.DonViSuaChua.toString();
    _controllerChiPhiSuaChua.text = rM!.ChiPhiSuaChua.toString();
    setState(() {});
  }

  int getIdfromName(String name, List<bridgeModel> listRM) {
    int tra = 0;
    listRM.forEach((element) {
      if (name == element.TenCayCau) {
        tra = element.BridgeId;
      }
    });
    return tra;
  }

  void saveChange() async {
    int ketQuaSave = await widget.rpC.putRepair(
        widget.BridgeHistoryId,
        widget.bridgeId,
        _controllerNgayKiemTra.text,
        _controllerDonViKiemTra.text,
        _controllerNoiDungHuHong.text,
        _controllerNgaySuaChua.text,
        _controllerDonViSuaChua.text,
        int.parse(_controllerChiPhiSuaChua.text),
        listDetailRepair);
    setState(() {
      resultSaved = ketQuaSave;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thêm kiểm tra / sửa chữa'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return SimpleDialog(
                title: const Text('Thêm chi tiết sửa chữa'),
                children: [
                  const Text(
                    'Ảnh hiện trường',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    enabled: false,
                    onChanged: (newValue) {},
                    controller: _controllerThemChiTietAnh,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(
                          top: 0, bottom: 0, left: 5, right: 5),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7),
                        borderSide: const BorderSide(),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      _pickImage(ImageSource.gallery);
                    },
                    child: Text(
                      'Chọn hình:',
                      style:
                          TextStyle(color: Color.fromARGB(255, 85, 181, 245)),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Thời gian:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: [
                      TextField(
                        enabled: false,
                        onChanged: (newValue) {},
                        controller: _controllerThemChiTietNgay,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(
                              top: 0, bottom: 0, left: 5, right: 5),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7),
                            borderSide: const BorderSide(),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          final DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: ThoiGian,
                            firstDate: DateTime(1900),
                            lastDate: DateTime(2101),
                          );
                          if (picked != null && picked != ThoiGian) {
                            setState(() {
                              ThoiGian = DateTime(
                                  picked.year, picked.month, picked.day);
                              _controllerThemChiTietNgay.text =
                                  DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS")
                                      .format(ThoiGian);
                              ;
                              print(
                                  'Ngày : ' + _controllerThemChiTietNgay.text);
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                        ),
                        child: const Icon(Icons.calendar_today,
                            color: Colors.black),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Nội dung: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    //enabled: false,
                    onChanged: (newValue) {},
                    controller: _controllerThemChiTietNoiDung,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(
                          top: 0, bottom: 0, left: 5, right: 5),
                      hintText: 'Nhập nội dung ...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7),
                        borderSide: const BorderSide(),
                      ),
                    ),
                  ),
                  const Text(
                    'Ghi chú: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    //enabled: false,
                    onChanged: (newValue) {},
                    controller: _controllerThemChiTietGhiChu,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(
                          top: 0, bottom: 0, left: 5, right: 5),
                      hintText: 'Nhập ghi chú ...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7),
                        borderSide: const BorderSide(),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      detailRepairModel addTemp = detailRepairModel(
                        repairDetailId: widget.BridgeHistoryId,
                        repairHistoryId: 0,
                        noiDung: _controllerThemChiTietNoiDung.text,
                        hinhAnh: _controllerThemChiTietAnh.text,
                        ghiChu: _controllerThemChiTietGhiChu.text,
                        thoiGian: _controllerThemChiTietNgay.text,
                      );
                      listDetailRepair.add(addTemp);
                      print(listDetailRepair);
                      saveChange();
                      Navigator.pop(context);
                    },
                    child: const Text('Thêm'),
                  )
                ],
              );
            },
          ),
        },
        label: const Text('Thêm chi tiết'),
        icon: const Icon(Icons.add),
        backgroundColor: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            padding: EdgeInsets.all(7),
            child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              SizedBox(width: 7),
              ElevatedButton.icon(
                icon: Icon(Icons.save_rounded),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Thông báo'),
                        content: Text(
                            'Xác lưu thay đổi thông tin kiểm tra / sửa chửa ${_controllerTenCayCau.text}'),
                        actions: [
                          TextButton(
                            child: const Text('Huỷ bỏ'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: const Text('Xác nhận'),
                            onPressed: () {
                              saveChange();
                              if (resultSaved == 200) {
                                print('thành công!');
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => repairHomeScreen()),
                                );
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
                style: ElevatedButton.styleFrom(
                  primary: Color(0xff7cb518), // Màu nền
                  onPrimary: Colors.white, // Màu chữ
                ),
              ),
            ]),
          ),
          Container(
            padding: EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Center(
                  child: Container(
                    child: Center(
                        child: Text(
                      'THÔNG TIN SỬA CHỬA',
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
                  height: 30,
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 7),
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: [
                      Container(
                        width: 120,
                        child: Text('Cây cầu'),
                      ),
                      Expanded(
                        child: Container(
                          width: 230,
                          child: TextField(
                            enabled: false,
                            controller: _controllerTenCayCau,
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
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 7),
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: [
                      Container(
                        width: 120,
                        child: Text('Ngày kiểm tra'),
                      ),
                      Expanded(
                        child: Container(
                          width: 170,
                          child: TextField(
                            controller: _controllerNgayKiemTra,
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
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          final DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: Nkiemtra,
                            firstDate: DateTime(1900),
                            lastDate: DateTime(2101),
                          );
                          if (picked != null && picked != Nkiemtra) {
                            setState(() {
                              Nkiemtra = DateTime(
                                  picked.year, picked.month, picked.day);
                              _controllerNgayKiemTra.text =
                                  ('${Nkiemtra.year.toString()}-${Nkiemtra.month.toString()}-${Nkiemtra.day.toString()}');
                            });
                          }
                        },
                        child: Icon(Icons.calendar_today, color: Colors.black),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 7),
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: [
                      Container(
                        width: 120,
                        child: Text('Đơn vị kiểm tra'),
                      ),
                      Expanded(
                        child: Container(
                          child: TextField(
                            controller: _controllerDonViKiemTra,
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
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 7),
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: [
                      Container(
                        width: 120,
                        child: Text('Nội dung hư hỏng'),
                      ),
                      Expanded(
                        child: Container(
                          width: 230,
                          child: TextField(
                            controller: _controllerNoiDungHuHong,
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
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 7),
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: [
                      Container(
                        width: 120,
                        child: Text('Ngày sửa chữa'),
                      ),
                      Expanded(
                        child: Container(
                          width: 170,
                          child: TextField(
                            controller: _controllerNgaySuaChua,
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
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          final DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: NSua,
                            firstDate: DateTime(1900),
                            lastDate: DateTime(2101),
                          );
                          if (picked != null && picked != NSua) {
                            setState(() {
                              NSua = DateTime(
                                  picked.year, picked.month, picked.day);
                              _controllerNgaySuaChua.text =
                                  ('${NSua.year.toString()}-${NSua.month.toString()}-${NSua.day.toString()}');
                            });
                          }
                        },
                        child: Icon(Icons.calendar_today, color: Colors.black),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white, // màu nền của nút
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 7),
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: [
                      Container(
                        width: 120,
                        child: Text('Đơn vị sửa chữa'),
                      ),
                      Expanded(
                        child: Container(
                          width: 230,
                          child: TextField(
                            controller: _controllerDonViSuaChua,
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
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 7),
                  width: MediaQuery.of(context).size.width,
                  child: Row(children: [
                    Container(
                      width: 120,
                      child: Text('Chi phí sửa chữa'),
                    ),
                    Expanded(
                      child: Container(
                        width: 230,
                        child: TextField(
                          controller: _controllerChiPhiSuaChua,
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
                    ),
                  ]),
                ),
                Center(
                  child: Container(
                    child: Center(
                        child: Text(
                      'THÔNG TIN CHI TIẾT',
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
                Column(
                  children: [
                    if (_futureDetailRepairList != null)
                      for (var temp
                          in _futureDetailRepairList as List<detailRepairModel>)
                        Container(
                          child: detailRepairCard(
                            detailRepairModelStart: temp,
                            rM: rM as RepairModel,
                            listDetailRepair: listDetailRepair,
                          ),
                        ),
                  ],
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
