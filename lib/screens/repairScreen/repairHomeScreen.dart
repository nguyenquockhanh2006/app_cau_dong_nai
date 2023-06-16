import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_4/screens/homeScreen/menu.dart';
import 'package:flutter_application_4/screens/repairScreen/addRepairScreen.dart';
import 'package:flutter_application_4/screens/repairScreen/detailRepairScreen.dart';
import 'package:flutter_application_4/services/controllers/bridgeController.dart';
import 'package:flutter_application_4/services/controllers/repairController.dart';
import 'package:flutter_application_4/services/models/bridgeModel.dart';
import 'package:flutter_application_4/services/models/repairModel.dart';
import 'package:intl/intl.dart';

class repairHomeScreen extends StatefulWidget {
  final repairController rpC = repairController();
  final bridgeController bC = bridgeController();

  repairHomeScreen({super.key});
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<repairHomeScreen> {
  int? result;
  String? ten;
  String? trangthai;
  String? selectedEffect = 'Tất cả';
  String? selectedNameBridge = 'Tất cả';
  List<String> listNameBridge = [];
  List<String> dateRange = [];
  List<Container> loc = [];
  List<RepairModel> repairList = [];
  List<TableRow> rows = [];
  bool isDataLoaded = false;
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  late Future<List<RepairModel>> _futureRepairList;
  late Future<List<bridgeModel>> _futureBridgeList;
  DateTime selectedDate = DateTime(2023, 1, 1); // start
  DateTime selectedDate2 = DateTime(2023, 1, 1); //end
  bool shouldHideContainer = false;
  @override
  void initState() {
    super.initState();
    fetchName();
  }

  void _toggleContainerVisibility() {
    setState(() {
      shouldHideContainer = !shouldHideContainer;
    });
  }

  Future<void> fetchName() async {
    _futureRepairList = widget.rpC.getApi();
    _futureBridgeList = widget.bC.getApi();
    List<String> temp = await widget.rpC.getBridgeNameApi();
    listNameBridge = temp;
    setState(() {});
  }

  List<String> items = ['Tất cả'];
  @override
  Widget build(BuildContext context) {
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
          endDrawer: const menu(),
          floatingActionButton: FloatingActionButton(
            onPressed: () => {
              navigatorKey.currentState?.push(
                MaterialPageRoute(builder: (context) => addRepairScreen()),
              ),
            },
            backgroundColor: Colors.blue,
            tooltip: '',
            child: const Icon(Icons.add),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                    child: FutureBuilder<List<bridgeModel>>(
                  future: _futureBridgeList,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<bridgeModel>? bridgeList = snapshot.data;
                      for (int i = 0; i < bridgeList!.length; i++) {
                        items.add(bridgeList[i].TenCayCau);
                      }
                      List<String> options = items.toSet().toList();
                      return Column(
                        children: [
                          Container(
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
                                      items: options
                                          .map<DropdownMenuItem<String>>(
                                              (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      value: selectedNameBridge,
                                      onChanged: (value) {
                                        setState(() {
                                          selectedNameBridge = value;
                                        });
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
                                        value: selectedEffect,
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            selectedEffect = newValue;
                                            // trangthai = selectedEffect;
                                          });
                                        },
                                        items: <String>[
                                          'Tất cả',
                                          'Đã sửa',
                                          'Chưa sửa',
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
                                      const Text('Thời gian kiểm tra'),
                                      Row(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(5),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2.3,
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
                                                SizedBox(
                                                  width: 100,
                                                  child: Text(
                                                      '${selectedDate.day.toString()}/${selectedDate.month.toString()}/${selectedDate.year.toString()}'),
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
                                          Expanded(
                                            child: SizedBox(),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2.3,
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
                                                SizedBox(
                                                  width: 100,
                                                  child: Text(
                                                      '${selectedDate2.day.toString()}/${selectedDate2.month.toString()}/${selectedDate2.year.toString()}'),
                                                ),
                                                ElevatedButton(
                                                  onPressed: () async {
                                                    final DateTime? picked =
                                                        await showDatePicker(
                                                      context: context,
                                                      initialDate:
                                                          selectedDate2,
                                                      firstDate: DateTime(1900),
                                                      lastDate: DateTime(2025),
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
                                      onPressed: () {
                                        setState(() {
                                          rows.clear();
                                          shouldHideContainer = false;
                                          selectedNameBridge = 'Tất cả';
                                          selectedEffect = 'Tất cả';
                                          selectedDate = DateTime(2023, 1, 1);
                                          selectedDate2 = DateTime(2023, 1, 1);
                                        });
                                      },
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
                                      onPressed: () {
                                        rows.clear();
                                        repairList.clear();

                                        _futureRepairList.then((list) {
                                          repairList.addAll(list);
                                          for (var i = 0;
                                              i <=
                                                  selectedDate2
                                                      .difference(selectedDate)
                                                      .inDays;
                                              i++) {
                                            DateTime currentDate = selectedDate
                                                .add(Duration(days: i));
                                            DateFormat formatter =
                                                DateFormat('yyyy-MM-dd');
                                            String formattedDate =
                                                formatter.format(currentDate);
                                            dateRange.add(formattedDate);
                                          }
                                          //lọc
                                          for (int i = 0;
                                              i < repairList.length;
                                              i++) {
                                            void add() {
                                              setState(() {
                                                shouldHideContainer = true;
                                                rows.add(TableRow(children: [
                                                  TableCell(
                                                      child: Padding(
                                                    padding: EdgeInsets.all(5),
                                                    child: Text(repairList[i]
                                                        .TenCayCau as String),
                                                  )),
                                                  TableCell(
                                                      child: Padding(
                                                    padding: EdgeInsets.all(5),
                                                    child: Text(repairList[i]
                                                        .NgayKiemTra as String),
                                                  )),
                                                  TableCell(
                                                      child: Padding(
                                                    padding: EdgeInsets.all(5),
                                                    child: Text(repairList[i]
                                                        .TrangThai as String),
                                                  )),
                                                  TableCell(
                                                      child: Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 5, bottom: 5),
                                                    child: TextButton(
                                                        onPressed: () => {},
                                                        child: Row(
                                                          children: [
                                                            Icon(
                                                              Icons
                                                                  .warning_amber_rounded,
                                                              color: Colors
                                                                  .blue[400],
                                                            ),
                                                          ],
                                                        )),
                                                  )),
                                                  TableCell(
                                                      child: Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 5, bottom: 5),
                                                    child: TextButton(
                                                        onPressed: () => {},
                                                        child: Row(
                                                          children: [
                                                            Icon(
                                                              Icons.delete,
                                                              color: Colors
                                                                  .red[400],
                                                            ),
                                                          ],
                                                        )),
                                                  )),
                                                ]));
                                              });
                                            }

                                            dateRange.forEach((day) {
                                              // lọc cả 3 đk đã pas
                                              if (selectedNameBridge ==
                                                      repairList[i].TenCayCau &&
                                                  selectedEffect ==
                                                      repairList[i].TrangThai &&
                                                  day ==
                                                      repairList[i]
                                                          .NgayKiemTra) {
                                                add();
                                              }
                                              //lọc 1 đk
                                              if (selectedNameBridge ==
                                                      'Tất cả' &&
                                                  selectedEffect == 'Tất cả' &&
                                                  day ==
                                                      repairList[i]
                                                          .NgayKiemTra) {
                                                add();
                                              }
                                              // lọc 2 đk
                                              if (selectedNameBridge ==
                                                      'Tất cả' &&
                                                  selectedEffect ==
                                                      repairList[i].TrangThai &&
                                                  day ==
                                                      repairList[i]
                                                          .NgayKiemTra) {
                                                add();
                                              }
                                              if (selectedNameBridge ==
                                                      repairList[i].TenCayCau &&
                                                  selectedEffect == 'Tất cả' &&
                                                  day ==
                                                      repairList[i]
                                                          .NgayKiemTra) {
                                                add();
                                              }
                                            });
                                            //lọc 1 đk
                                            if (selectedNameBridge ==
                                                    'Tất cả' &&
                                                selectedEffect ==
                                                    repairList[i].TrangThai &&
                                                selectedDate ==
                                                    DateTime(2023, 1, 1) &&
                                                selectedDate2 ==
                                                    DateTime(2023, 1, 1)) {
                                              add();
                                            }
                                            if (selectedNameBridge ==
                                                    repairList[i].TenCayCau &&
                                                selectedEffect == 'Tất cả' &&
                                                selectedDate ==
                                                    DateTime(2023, 1, 1) &&
                                                selectedDate2 ==
                                                    DateTime(2023, 1, 1)) {
                                              add();
                                            }
                                            //lọc 2 đk
                                            if (selectedNameBridge ==
                                                    repairList[i].TenCayCau &&
                                                selectedEffect ==
                                                    repairList[i].TrangThai &&
                                                selectedDate ==
                                                    DateTime(2023, 1, 1) &&
                                                selectedDate2 ==
                                                    DateTime(2023, 1, 1)) {
                                              add();
                                            }
                                          }
                                          ;
                                        });
                                      },
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
                shouldHideContainer
                    ? Container(
                        padding: const EdgeInsets.all(7),
                        child: Table(
                          defaultVerticalAlignment:
                              TableCellVerticalAlignment.middle,
                          columnWidths: {
                            0: FlexColumnWidth(2.1),
                            1: FlexColumnWidth(1.8),
                            2: FlexColumnWidth(1.3),
                            3: FlexColumnWidth(1),
                            4: FlexColumnWidth(0.8),
                          },
                          border: TableBorder.all(color: Color(0xffadb5bd)),
                          children: [
                            const TableRow(
                              decoration:
                                  BoxDecoration(color: Color(0xffa2d2ff)),
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
                            //them tablerow
                            for (TableRow row in rows) row
                          ],
                        ),
                      )
                    : Container(
                        padding: const EdgeInsets.all(7),
                        child: FutureBuilder<List<RepairModel>>(
                          future: _futureRepairList,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Table(
                                defaultVerticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                columnWidths: {
                                  0: FlexColumnWidth(2.1),
                                  1: FlexColumnWidth(1.8),
                                  2: FlexColumnWidth(1.3),
                                  3: FlexColumnWidth(1),
                                  4: FlexColumnWidth(0.8),
                                },
                                border:
                                    TableBorder.all(color: Color(0xffadb5bd)),
                                children: [
                                  const TableRow(
                                    decoration:
                                        BoxDecoration(color: Color(0xffa2d2ff)),
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
                                  ...snapshot.data!
                                      .map((repair) => TableRow(children: [
                                            TableCell(
                                                child: Padding(
                                              padding: EdgeInsets.all(5),
                                              child: Text(
                                                  repair.TenCayCau as String),
                                            )),
                                            TableCell(
                                                child: Padding(
                                              padding: EdgeInsets.all(5),
                                              child: Text(
                                                  repair.NgayKiemTra as String),
                                            )),
                                            TableCell(
                                                child: Padding(
                                              padding: EdgeInsets.all(5),
                                              child: Text(
                                                  repair.TrangThai as String),
                                            )),
                                            TableCell(
                                                child: Padding(
                                              padding: EdgeInsets.only(
                                                  top: 5, bottom: 5),
                                              child: TextButton(
                                                  onPressed: () => {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  detailRepairScreen(
                                                                    BridgeHistoryId:
                                                                        repair.RepairHistoryId
                                                                            as int,
                                                                    bridgeId: repair
                                                                            .BridgeId
                                                                        as int,
                                                                  )),
                                                        ),
                                                      },
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Icons
                                                            .warning_amber_rounded,
                                                        color: Colors.blue[400],
                                                      ),
                                                    ],
                                                  )),
                                            )),
                                            TableCell(
                                                child: Padding(
                                              padding: EdgeInsets.only(
                                                  top: 5, bottom: 5),
                                              child: TextButton(
                                                  onPressed: () => {
                                                        showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return AlertDialog(
                                                              title: const Text(
                                                                  'Thông báo'),
                                                              content: Text(
                                                                  'Xác nhận muốn xóa thông tin sửa chửa được chọn?'),
                                                              actions: [
                                                                TextButton(
                                                                  child: const Text(
                                                                      'Huỷ bỏ'),
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                ),
                                                                TextButton(
                                                                  child: const Text(
                                                                      'Xác nhận xóa'),
                                                                  onPressed:
                                                                      () async {
                                                                    // Xử lý khi người dùng chọn xác nhận
                                                                    result = await widget
                                                                        .rpC
                                                                        .deleteItem(
                                                                            repair.RepairHistoryId.toString());

                                                                    if (result ==
                                                                        200) {
                                                                      print(
                                                                          'thành công!');

                                                                      setState(
                                                                          () {
                                                                        Navigator
                                                                            .push(
                                                                          context,
                                                                          MaterialPageRoute(
                                                                              builder: (context) => repairHomeScreen()),
                                                                        );
                                                                      });
                                                                    } else {
                                                                      print(
                                                                          'thất bại!');
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                    }
                                                                  },
                                                                ),
                                                              ],
                                                            );
                                                          },
                                                        ),
                                                      },
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Icons.delete,
                                                        color: Colors.red[400],
                                                      ),
                                                    ],
                                                  )),
                                            )),
                                          ]))
                                ],
                              );
                            } else if (snapshot.hasError) {
                              return const Center(child: Text('Error'));
                            } else {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                          },
                        ),
                      ),
              ],
            ),
          )),
    );
  }
}
