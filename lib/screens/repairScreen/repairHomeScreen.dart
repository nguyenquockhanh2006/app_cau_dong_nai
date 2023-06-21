import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_4/screens/repairScreen/repairHomeScreenShow.dart';
import 'package:flutter_application_4/services/controllers/bridgeController.dart';
import 'package:flutter_application_4/services/controllers/repairController.dart';
import 'package:flutter_application_4/services/models/bridgeModel.dart';
import 'package:flutter_application_4/services/models/repairModel.dart';
import 'package:flutter_application_4/screens/repairScreen/detailRepairScreen.dart';

class repairHomeScreen extends StatefulWidget {
  final repairController rpC = repairController();
  final bridgeController bC = bridgeController();

  repairHomeScreen({super.key});
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<repairHomeScreen> {
  String? selectedEffect = 'Tất cả';
  String? selectedNameBridge = 'Tất cả';
  int? result;
  List<String> listNameBridge = [];
  //final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  late Future<List<bridgeModel>> _futureBridgeList;
  DateTime selectedDate = DateTime(1900, 01, 01);
  DateTime selectedDate2 = DateTime.now();
  @override
  void initState() {
    super.initState();
    fetchName();
  }

  Future<void> fetchName() async {
    _futureBridgeList = widget.bC.getApi();
    List<String> temp = await widget.rpC.getBridgeNameApi();
    temp.add('Tất cả');
    listNameBridge = temp;
  }

  Future<List<RepairModel>> setRepairList() async {
    List<RepairModel> repair1 = await widget.rpC.getApi();
    List<RepairModel> repair2 = [];
    List<RepairModel> repair3 = [];
    List<RepairModel> repair4 = [];
    List<RepairModel> repair5 = [];
    if (selectedNameBridge.toString() == 'Tất cả') {
      repair2 = repair1;
    } else {
      for (int i = 0; i < repair1.length; i++) {
        if (repair1.elementAt(i).TenCayCau == selectedNameBridge) {
          repair2.add(repair1.elementAt(i));
        }
      }
    }

    if (selectedEffect.toString() == 'Tất cả') {
      repair3 = repair2;
    } else {
      for (int i = 0; i < repair2.length; i++) {
        if (repair2.elementAt(i).TrangThai == selectedEffect) {
          repair3.add(repair2.elementAt(i));
        }
      }
    }
    String day1 =
        '${selectedDate.year}-${selectedDate.month}-${selectedDate.day}';
    String day2 =
        '${selectedDate2.year}-${selectedDate2.month}-${selectedDate2.day}';
    for (int i = 0; i < repair3.length; i++) {
      if (day1.compareTo(repair3.elementAt(i).NgayKiemTra as String) <= 0) {
        repair4.add(repair3.elementAt(i));
      }
    }
    for (int i = 0; i < repair4.length; i++) {
      if (day2.compareTo(repair4.elementAt(i).NgayKiemTra as String) >= 0) {
        repair5.add(repair4.elementAt(i));
      }
    }
    return repair5;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 114, 151, 239),
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text('Thông tin kiểm tra / sửa chửa'),
        toolbarHeight: 30,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                width: MediaQuery.of(context).size.width,
                child: FutureBuilder<List<bridgeModel>>(
                  future: _futureBridgeList,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.all(7),
                            padding: const EdgeInsets.all(7),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                border:
                                    Border.all(color: const Color(0xFFadb5bd))),
                            child: Column(children: [
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 90,
                                    child: Text('Cây cầu'),
                                  ),
                                  Expanded(
                                    child: DropdownButton<String>(
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 16),
                                      //hint: Text('Chọn cầu'),
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
                                          () => selectedNameBridge = newValue,
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                child: Row(
                                  children: [
                                    const SizedBox(
                                      width: 90,
                                      child: Text('Trạng thái'),
                                    ),
                                    Expanded(
                                      child: DropdownButton<String>(
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 16),
                                        hint: Text('Trạng thái'),
                                        value: selectedEffect,
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            selectedEffect = newValue;
                                          });
                                        },
                                        items: <String>[
                                          'Đã sửa',
                                          'Chưa sửa',
                                          'Tất cả'
                                        ].map<DropdownMenuItem<String>>(
                                            (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 8),
                                      const Text('Thời giam kiểm tra'),
                                      Row(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(5),
                                            width: (MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    28) /
                                                2,
                                            margin: const EdgeInsets.only(
                                                right: 5, top: 7),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(7),
                                                border: Border.all(
                                                    color: const Color(
                                                        0xFFadb5bd))),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: SizedBox(
                                                    width: 100,
                                                    child: Text(
                                                        '${selectedDate.day.toString()}/${selectedDate.month.toString()}/ ${selectedDate.year.toString()}'),
                                                  ),
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
                                                        pickedDate !=
                                                            selectedDate) {
                                                      setState(() {
                                                        selectedDate =
                                                            pickedDate;
                                                      });
                                                    }
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.white,
                                                  ),
                                                  child: const Icon(
                                                      Icons.calendar_today,
                                                      color: Colors.black),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: (MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    42) /
                                                2,
                                            margin:
                                                const EdgeInsets.only(top: 7),
                                            padding: const EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(7),
                                                border: Border.all(
                                                    color: const Color(
                                                        0xFFadb5bd))),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: SizedBox(
                                                    width: 100,
                                                    child: Text(
                                                        '${selectedDate2.day.toString()}/${selectedDate2.month.toString()}/ ${selectedDate2.year.toString()}'),
                                                  ),
                                                ),
                                                ElevatedButton(
                                                  onPressed: () async {
                                                    final DateTime? picked =
                                                        await showDatePicker(
                                                      context: context,
                                                      initialDate:
                                                          selectedDate2,
                                                      firstDate: DateTime(1900),
                                                      lastDate: DateTime(2101),
                                                    );
                                                    if (picked != null &&
                                                        picked !=
                                                            selectedDate2) {
                                                      setState(() {
                                                        selectedDate2 =
                                                            DateTime(
                                                                picked.year,
                                                                picked.month,
                                                                picked.day);
                                                      });
                                                    }
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.white,
                                                  ),
                                                  child: const Icon(
                                                      Icons.calendar_today,
                                                      color: Colors.black),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ]),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 7),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextButton.icon(
                                      onPressed: () {},
                                      label: const Text('Làm mới'),
                                      icon: const Icon(Icons.restart_alt),
                                      style: TextButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xff29bf12),
                                          foregroundColor: Colors.white,
                                          elevation: 2,
                                          padding: const EdgeInsets.all(5)),
                                    ),
                                    const SizedBox(width: 10),
                                    TextButton.icon(
                                      onPressed: () {},
                                      label: const Text('Áp dụng'),
                                      icon: const Icon(Icons.search),
                                      style: TextButton.styleFrom(
                                          backgroundColor: Colors.blue,
                                          foregroundColor: Colors.white,
                                          elevation: 2,
                                          padding: const EdgeInsets.all(5)),
                                    )
                                  ],
                                ),
                              )
                            ]),
                          ),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    return const CircularProgressIndicator();
                  },
                )),
            Container(
              padding: const EdgeInsets.all(7),
              child: FutureBuilder<List<RepairModel>>(
                future: setRepairList(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Table(
                      columnWidths: {
                        0: FlexColumnWidth(2.1),
                        1: FlexColumnWidth(1.8),
                        2: FlexColumnWidth(1.3),
                        3: FlexColumnWidth(1),
                        4: FlexColumnWidth(0.8),
                      },
                      defaultColumnWidth: FixedColumnWidth(
                          (MediaQuery.of(context).size.width - 14) / 5),
                      border: TableBorder.all(),
                      children: [
                        const TableRow(
                          decoration: BoxDecoration(color: Color(0xffa2d2ff)),
                          children: [
                            TableCell(
                                child: Padding(
                              padding: EdgeInsets.all(5),
                              child: Text('Tên cây cầu'),
                            )),
                            TableCell(
                                child: Padding(
                              padding: EdgeInsets.all(5),
                              child: Text('Ngày kiểm tra'),
                            )),
                            TableCell(
                                child: Padding(
                              padding: EdgeInsets.all(5),
                              child: Text('Trạng thái'),
                            )),
                            TableCell(
                                child: Padding(
                              padding: EdgeInsets.all(5),
                              child: Text('Chi tiết'),
                            )),
                            TableCell(
                                child: Padding(
                              padding: EdgeInsets.all(5),
                              child: Text('Xóa'),
                            )),
                          ],
                        ),
                        ...snapshot.data!.map((repair) => TableRow(children: [
                              TableCell(
                                  child: Text(
                                repair.TenCayCau as String,
                                style: TextStyle(fontSize: 16),
                              )),
                              TableCell(
                                  child: Text(
                                repair.NgayKiemTra as String,
                                style: TextStyle(fontSize: 15),
                              )),
                              TableCell(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      repair.TrangThai as String,
                                      style: TextStyle(fontSize: 16),
                                    )
                                  ],
                                ),
                              ),
                              TableCell(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextButton(
                                      onPressed: () => {
                                        //getApiById
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  detailRepairScreen(
                                                    BridgeHistoryId: repair
                                                        .RepairHistoryId as int,
                                                    bridgeId:
                                                        repair.BridgeId as int,
                                                  )),
                                        ),
                                      },
                                      child: Icon(
                                        Icons.warning_amber_rounded,
                                        color: Colors.blue[400],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              TableCell(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextButton(
                                      onPressed: () => {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: const Text('Thông báo'),
                                              content: Text(
                                                  'Xác nhận muốn xóa thông tin sửa chửa được chọn?'),
                                              actions: [
                                                TextButton(
                                                  child: const Text('Huỷ bỏ'),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                                TextButton(
                                                  child: const Text(
                                                      'Xác nhận xóa'),
                                                  onPressed: () async {
                                                    // Xử lý khi người dùng chọn xác nhận
                                                    result = await widget.rpC
                                                        .deleteItem(repair
                                                                .RepairHistoryId
                                                            .toString());

                                                    if (result == 200) {
                                                      print('thành công!');

                                                      setState(() {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  repairHomeScreenShow()),
                                                        );
                                                      });
                                                    } else {
                                                      print('thất bại!');
                                                      Navigator.of(context)
                                                          .pop();
                                                    }
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                      },
                                      child: Icon(
                                        Icons.auto_delete,
                                        color: Colors.red[400],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ]))
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return const Center(child: Text('Error'));
                  } else {
                    return const Center(child: CircularProgressIndicator());
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
