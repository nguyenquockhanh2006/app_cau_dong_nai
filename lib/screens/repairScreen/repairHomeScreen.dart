import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_4/screens/homeScreen/mapScreen.dart';
import 'package:flutter_application_4/screens/homeScreen/listScreen.dart';
import 'package:flutter_application_4/screens/homeScreen/menu.dart';
import 'package:flutter_application_4/services/controllers/bridgeController.dart';
import 'package:flutter_application_4/services/controllers/repairController.dart';
import 'package:flutter_application_4/services/models/bridgeModel.dart';
import 'package:flutter_application_4/services/models/repairModel.dart';

class repairHomeScreen extends StatefulWidget {
  final RepairController rpC = RepairController();
  final bridgeController bC = bridgeController();
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<repairHomeScreen> {
  String? selectedEffect;
  String? selectedNameBridge;
  List<String> listNameBridge = [];
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  late Future<List<RepairModel>> _futureRepairList;
  late Future<List<bridgeModel>> _futureBridgeList;
  DateTime selectedDate = DateTime.now();
  DateTime selectedDate2 = DateTime.now();
  @override
  void initState() {
    super.initState();
    fetchName();
  }

  Future<void> fetchName() async {
    _futureRepairList = widget.rpC.getApi();
    _futureBridgeList = widget.bC.getApi();
    List<String> temp = await widget.rpC.getBridgeNameApi();
    listNameBridge = temp;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var repairModel = RepairModel;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      home: Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white,
            foregroundColor: Colors.blue,
            title: const Text('CẦU ĐỒNG NAI'),
            toolbarHeight: 60,
            leading: Image.asset("lib/assets/images/Logo_Dong_Nai.png")),
        endDrawer: menu(),
        body: Column(
          children: [
            Container(
                child: FutureBuilder<List<bridgeModel>>(
              future: _futureBridgeList,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<bridgeModel>? bridgeList = snapshot.data;
                  return Column(
                    children: [
                      Container(
                        margin: EdgeInsets.all(7),
                        padding: EdgeInsets.all(7),
                        child: Column(children: [
                          Row(
                            children: [
                              Container(
                                width: 90,
                                child: Text('Cây cầu'),
                              ),
                              DropdownButton<String>(
                                items: listNameBridge
                                    .map<DropdownMenuItem<String>>(
                                        (String value) {
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
                                    },
                                  );
                                },
                              )
                            ],
                          ),
                          Container(
                            child: Row(
                              children: [
                                Container(
                                  width: 90,
                                  child: Text('Trạng thái'),
                                ),
                                DropdownButton<String>(
                                  value: selectedEffect,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      selectedEffect = newValue;
                                    });
                                  },
                                  items: <String>[
                                    'đã sửa',
                                    'chưa sửa',
                                    'tất cả'
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                )
                              ],
                            ),
                          ),
                          Container(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 8),
                                  Text('Thời giam kiểm tra'),
                                  Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(5),
                                        width: 170,
                                        margin:
                                            EdgeInsets.only(right: 5, top: 7),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 100,
                                              child: Text(
                                                  '${selectedDate.day.toString()}/${selectedDate.month.toString()}/ ${selectedDate.year.toString()}'),
                                            ),
                                            ElevatedButton(
                                              onPressed: () async {
                                                final DateTime? pickedDate =
                                                    await showDatePicker(
                                                  context: context,
                                                  initialDate: selectedDate,
                                                  firstDate: DateTime(1900),
                                                  lastDate: DateTime(2100),
                                                );
                                                if (pickedDate != null &&
                                                    pickedDate != selectedDate)
                                                  setState(() {
                                                    selectedDate = pickedDate;
                                                  });
                                              },
                                              child: Icon(Icons.calendar_today,
                                                  color: Colors.black),
                                              style: ElevatedButton.styleFrom(
                                                primary: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(7),
                                            border: Border.all(
                                                color: Color(0xFFadb5bd))),
                                      ),
                                      Container(
                                        width: 170,
                                        margin: EdgeInsets.only(top: 7),
                                        padding: EdgeInsets.all(5),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 100,
                                              child: Text(
                                                  '${selectedDate2.day.toString()}/${selectedDate2.month.toString()}/ ${selectedDate2.year.toString()}'),
                                            ),
                                            ElevatedButton(
                                              onPressed: () async {
                                                final DateTime? picked =
                                                    await showDatePicker(
                                                  context: context,
                                                  initialDate: selectedDate2,
                                                  firstDate: DateTime(1900),
                                                  lastDate: DateTime(2101),
                                                );
                                                if (picked != null &&
                                                    picked != selectedDate2) {
                                                  setState(() {
                                                    selectedDate2 = DateTime(
                                                        picked.year,
                                                        picked.month,
                                                        picked.day);
                                                  });
                                                }
                                              },
                                              child: Icon(Icons.calendar_today,
                                                  color: Colors.black),
                                              style: ElevatedButton.styleFrom(
                                                primary: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(7),
                                            border: Border.all(
                                                color: Color(0xFFadb5bd))),
                                      ),
                                    ],
                                  ),
                                ]),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 7),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton.icon(
                                  onPressed: () {},
                                  label: Text('Làm mới'),
                                  icon: Icon(Icons.restart_alt),
                                  style: TextButton.styleFrom(
                                      backgroundColor: Color(0xff29bf12),
                                      foregroundColor: Colors.white,
                                      elevation: 2,
                                      padding: EdgeInsets.all(5)),
                                ),
                                SizedBox(width: 10),
                                TextButton.icon(
                                  onPressed: () {},
                                  label: Text('Áp dụng'),
                                  icon: Icon(Icons.search),
                                  style: TextButton.styleFrom(
                                      backgroundColor: Colors.blue,
                                      foregroundColor: Colors.white,
                                      elevation: 2,
                                      padding: EdgeInsets.all(5)),
                                )
                              ],
                            ),
                          )
                        ]),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            border: Border.all(color: Color(0xFFadb5bd))),
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return CircularProgressIndicator();
              },
            )),
            Container(
              padding: EdgeInsets.all(7),
              child: FutureBuilder<List<RepairModel>>(
                future: _futureRepairList,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Table(
                      border: TableBorder.all(),
                      children: [
                        TableRow(
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 194, 188, 188)),
                          children: [
                            TableCell(
                              child: Text(
                                'Tên cây cầu',
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                            TableCell(
                              child: Text(
                                'Ngày kiểm tra',
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                            TableCell(
                              child: Text(
                                'Trạng thái',
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                            TableCell(
                              child: Text(''),
                            ),
                            TableCell(
                              child: Text(''),
                            ),
                          ],
                        ),
                        ...snapshot.data!.map((repair) => TableRow(children: [
                              TableCell(child: Text(repair.TenCayCau)),
                              TableCell(child: Text(repair.NgayKiemTra)),
                              TableCell(child: Text(repair.TrangThai)),
                              TableCell(
                                child: TextButton(
                                    onPressed: () => {},
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.warning_amber_rounded,
                                          color: Colors.blue[400],
                                        ),
                                        Text(
                                          'Chi tiết',
                                          style: TextStyle(
                                            color: Colors.blue[400],
                                          ),
                                        ),
                                      ],
                                    )),
                              ),
                              TableCell(
                                  child: TextButton(
                                      onPressed: () => {},
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.auto_delete,
                                            color: Colors.red[400],
                                          ),
                                          Text(
                                            'Xóa',
                                            style: TextStyle(
                                              color: Colors.red[400],
                                            ),
                                          ),
                                        ],
                                      ))),
                            ]))
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error'));
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
