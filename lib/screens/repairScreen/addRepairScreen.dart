import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_application_4/screens/repairScreen/repairHomeScreen.dart';
import 'package:flutter_application_4/services/controllers/bridgeController.dart';
import 'package:flutter_application_4/services/controllers/repairController.dart';
import 'package:flutter_application_4/services/models/bridgeModel.dart';
import 'package:flutter_application_4/services/models/repairModel.dart';

class addRepairScreen extends StatefulWidget {
  final repairController rpC = repairController();
  final bridgeController bC = bridgeController();
  addRepairScreen({super.key});
  @override
  State<addRepairScreen> createState() => _addRepairState();
}

class _addRepairState extends State<addRepairScreen> {
  String? selectedNameBridge;
  List<String> listNameBridge = [];
  List<RepairModel>? _futureRepairList;
  List<bridgeModel>? _futureBridgeList;
  String selectedRepair = '';
  int? length;
  int? bridgeId;
  int? result;
  final TextEditingController _ngaykiemtra = TextEditingController();
  DateTime Nkiemtra = DateTime.now();
  final TextEditingController _ngaysuachua = TextEditingController();
  DateTime NSua = DateTime.now();
  TextEditingController _controller1 = TextEditingController();
  TextEditingController _controller2 = TextEditingController();
  TextEditingController _controller3 = TextEditingController();
  TextEditingController _controller4 = TextEditingController();
  TextEditingController _controller5 = TextEditingController();
  // List<TextEditingController> controllers = [];
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    _futureRepairList = await widget.rpC.getApi();
    _futureBridgeList = await widget.bC.getApi();
    List<String> temp = await widget.bC.getBridgeNameApi();
    length = await widget.bC.getLength();
    listNameBridge = temp;
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

  void addRepair() async {
    int? chiPhi;
    //String chiPhiText = _controller5.text.toString();
    if (_controller5.text.toString().trim() == '') {
      chiPhi = null;
    } else {
      chiPhi = int.parse(_controller5.text.toString().trim());
    }
    result = await widget.rpC.postAPI(
        bridgeId,
        selectedNameBridge,
        _ngaykiemtra.text.toString(),
        _controller2.text.toString(),
        _controller3.text.toString(),
        _ngaysuachua.text.toString(),
        _controller4.text.toString(),
        chiPhi);
    if (result == 200) {
      print('Thành công');
    } else {
      print('Thất bại');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('thêm kiểm tra/ sửa chữa'),
        ),
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            padding: EdgeInsets.all(7),
            child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              OutlinedButton.icon(
                onPressed: () {
                  _controller1.clear();
                  _controller2.clear();
                  _controller3.clear();
                  _controller4.clear();
                  _controller5.clear();
                  _ngaykiemtra.clear();
                  _ngaysuachua.clear();
                },
                icon: Icon(Icons.restart_alt),
                label: Text('Làm mới'),
                style: OutlinedButton.styleFrom(
                  primary: Colors.blue,
                  side: BorderSide(color: Colors.blue),
                ),
              ),
              SizedBox(width: 7),
              ElevatedButton.icon(
                icon: Icon(Icons.add),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Thông báo'),
                        content: Text(
                            'Xác nhận thêm thông tin kiểm tra / sửa chửa cho ${selectedNameBridge}'),
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
                              // Xử lý khi người dùng chọn xác nhận
                              addRepair();
                              if (result == 200) {
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
                label: Text('Thêm'),
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
            child: Column(children: [
              Container(
                margin: EdgeInsets.only(bottom: 7),
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: [
                    Container(
                      width: 120,
                      child: Text('Cây cầu'),
                    ),
                    Container(
                      width: 230,
                      child: DropdownButton<String>(
                        style: TextStyle(color: Colors.black, fontSize: 16),
                        hint: Text('Chọn cầu'),
                        items: listNameBridge
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        value: selectedNameBridge,
                        onChanged: (String? newValue) {
                          setState(
                            () => {
                              selectedNameBridge = newValue,
                              bridgeId =
                                  getIdfromName(newValue!, _futureBridgeList!),
                              print('id đã chọn: $bridgeId'),
                            },
                          );
                        },
                      ),
                    )
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
                    Container(
                      width: 170,
                      child: TextField(
                        controller: _ngaykiemtra,
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
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: Nkiemtra,
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2101),
                        );
                        if (picked != null && picked != Nkiemtra) {
                          setState(() {
                            Nkiemtra =
                                DateTime(picked.year, picked.month, picked.day);
                            _ngaykiemtra.text =
                                ('${Nkiemtra.year.toString()}/${Nkiemtra.month.toString()}/${Nkiemtra.day.toString()}');
                          });
                        }
                      },
                      child: Icon(Icons.calendar_today, color: Colors.black),
                      style: ElevatedButton.styleFrom(
                        // độ lớn của nút
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
                      child: Text('Đơn vị kiểm tra'),
                    ),
                    Container(
                      width: 230,
                      child: TextField(
                        controller: _controller2,
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
                    )
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
                    Container(
                      width: 230,
                      child: TextField(
                        controller: _controller3,
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
                    )
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
                    Container(
                      width: 170,
                      child: TextField(
                        controller: _ngaysuachua,
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
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: NSua,
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2101),
                        );
                        if (picked != null && picked != NSua) {
                          setState(() {
                            NSua =
                                DateTime(picked.year, picked.month, picked.day);
                            _ngaysuachua.text =
                                ('${NSua.year.toString()}/${NSua.month.toString()}/${NSua.day.toString()}');
                          });
                        }
                      },
                      child: Icon(Icons.calendar_today, color: Colors.black),
                      style: ElevatedButton.styleFrom(
                        // độ lớn của nút
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
                    Container(
                      width: 230,
                      child: TextField(
                        controller: _controller4,
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
                    )
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
                  Container(
                    width: 230,
                    child: TextField(
                      controller: _controller5,
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
                  )
                ]),
              ),
            ]),
          ),
        ]));
  }
}
