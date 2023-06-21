import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_4/screens/repairScreen/repairHomeScreenShow.dart';
import 'package:flutter_application_4/services/controllers/bridgeController.dart';
import 'package:flutter_application_4/services/controllers/repairController.dart';
import 'package:flutter_application_4/services/models/bridgeModel.dart';

class addRepairScreen extends StatefulWidget {
  final repairController rpC = repairController();
  final bridgeController bC = bridgeController();
  final String TenCayCau;
  final int idBridge;
  addRepairScreen({super.key,required this.idBridge, required this.TenCayCau});
  @override
  State<addRepairScreen> createState() => _addRepairState();
}

class _addRepairState extends State<addRepairScreen> {
  String? selectedNameBridge;
  List<String> listNameBridge = [];

  String selectedRepair = '';
  int? length;
  int? bridgeId;
  late int? result;
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

    List<String> temp = await widget.bC.getBridgeNameApi();
    length = await widget.bC.getLength();
    listNameBridge = temp;
    selectedNameBridge = listNameBridge.first;
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
    // ignore: await_only_futures
    // setState(() async {
    result = await widget.rpC.postAPI(
        widget.idBridge,
        widget.TenCayCau,
        _ngaykiemtra.text.toString(),
        _controller2.text.toString(),
        _controller3.text.toString(),
        _ngaysuachua.text.toString(),
        _controller4.text.toString(),
        chiPhi);
    // });
    if (result == 1) {
      print('thành công');
      setState(() {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => repairHomeScreenShow()),
        );
      });
    } else {
      setState(() {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => repairHomeScreenShow()),
        );
      });
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
                              addRepair();
                              Navigator.of(context).pop();
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
                    Expanded(
                      child: Container(
                        width: 230,
                        child: Text(widget.TenCayCau),
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
                    Expanded(
                      child: Container(
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
                    Expanded(
                      child: Container(
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
                    ),
                  ),
                ]),
              ),
            ]),
          ),
        ]));
  }
}
