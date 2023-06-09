import 'package:flutter/material.dart';
import 'package:flutter_application_4/screens/infoBridgeScreen/infoBridgeCard.dart';
import '../../services/controllers/bridgeController.dart';
import '../../services/models/bridgeModel.dart';

class listInfoBridge extends StatefulWidget {
  final bridgeController bC = bridgeController();

  listInfoBridge({super.key});

  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<listInfoBridge> {
  late Future<List<bridgeModel>> _futureBridgeList;
  final TextEditingController _controllerNgayKhoiCong = TextEditingController();
  final TextEditingController _controllerNgayHoanThanh =
      TextEditingController();
  final TextEditingController _controllerNgayXayDung = TextEditingController();
  final TextEditingController _controllerNgayKhoiCongCuoi =
      TextEditingController();
  final TextEditingController _controllerNgayHoanThanhCuoi =
      TextEditingController();
  final TextEditingController _controllerNgayXayDungCuoi =
      TextEditingController();
  late String? dropdownValue = 'Chưa xác định';
  late String? nameBridge = '';
  List<String>? listTypeBridge;
  DateTime NKhoiCong = DateTime.now();
  DateTime NHoanThanh = DateTime.now();
  DateTime NXayDung = DateTime.now();
  DateTime NKhoiCongCuoi = DateTime.now();
  DateTime NHoanThanhCuoi = DateTime.now();
  DateTime NXayDungCuoi = DateTime.now();
  bool? check_l1 = false;
  bool? check_l2 = false;

  @override
  void initState() {
    super.initState();
    _futureBridgeList = widget.bC.getApi();
    FetchData();
    //getTypeNameApi
  }

  FetchData() async {
    listTypeBridge = await widget.bC.getTypeNameApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 114, 151, 239),
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text('Quản lí thông tin cầu'),
        toolbarHeight: 30,
      ),
      body: Container(
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 3 / 4,
                  margin: const EdgeInsets.all(13),
                  child: TextField(
                    onChanged: (newValue) {
                      setState(() {
                        nameBridge = newValue;
                      });
                      print(nameBridge);
                    },
                    decoration: InputDecoration(
                      labelText: 'Tìm kiếm',
                      hintText: 'Nhập...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(),
                      ),
                      suffixIcon: const Icon(Icons.search),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          contentPadding: EdgeInsets.all(10),
                          title: const Text('Lọc danh sách'),
                          content: Container(
                            width: double.maxFinite,
                            height: MediaQuery.of(context).size.height * 2 / 3,
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Divider(
                                    thickness: 1.0,
                                    color: Colors.grey,
                                  ),
                                  const Text('Loại cầu'),
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: DropdownButton<String>(
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 16),
                                      hint: Text('Chọn cầu'),
                                      items: listTypeBridge
                                          ?.map<DropdownMenuItem<String>>(
                                              (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      value: dropdownValue,
                                      onChanged: (String? newValue) {
                                        setState(
                                          () => dropdownValue = newValue,
                                        );
                                      },
                                    ),
                                  ),
                                  const Text('>>> Thời gian khởi công'),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Bắt đầu'),
                                      Row(children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              1.5 /
                                              3,
                                          margin: const EdgeInsets.all(7),
                                          child: TextField(
                                            enabled: false,
                                            onChanged: (newValue) {},
                                            controller: _controllerNgayKhoiCong,
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  const EdgeInsets.only(
                                                      top: 0,
                                                      bottom: 0,
                                                      left: 5,
                                                      right: 5),
                                              hintText:
                                                  'Ngày bắt đầu khởi công',
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(7),
                                                borderSide: const BorderSide(),
                                              ),
                                            ),
                                          ),
                                        ),
                                        ElevatedButton(
                                          onPressed: () async {
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
                                                NKhoiCong = DateTime(
                                                    picked.year,
                                                    picked.month,
                                                    picked.day);
                                                _controllerNgayKhoiCong.text =
                                                    ('${NKhoiCong.year.toString()}/${NKhoiCong.month.toString()}/${NKhoiCong.day.toString()}');

                                                print(
                                                    'Ngày bắt đầu khởi công: ' +
                                                        _controllerNgayKhoiCong
                                                            .text);
                                              });
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.white,
                                          ),
                                          child: const Icon(
                                              Icons.calendar_today,
                                              color: Colors.black),
                                        ),
                                      ]),
                                      Text('Kết thúc'),
                                      Row(children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              1.5 /
                                              3,
                                          margin: const EdgeInsets.all(7),
                                          child: TextField(
                                            enabled: false,
                                            onChanged: (newValue) {},
                                            controller:
                                                _controllerNgayKhoiCongCuoi,
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  const EdgeInsets.only(
                                                      top: 0,
                                                      bottom: 0,
                                                      left: 5,
                                                      right: 5),
                                              hintText:
                                                  'Ngày kết thúc khởi công',
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(7),
                                                borderSide: const BorderSide(),
                                              ),
                                            ),
                                          ),
                                        ),
                                        ElevatedButton(
                                          onPressed: () async {
                                            final DateTime? picked =
                                                await showDatePicker(
                                              context: context,
                                              initialDate: NKhoiCongCuoi,
                                              firstDate: DateTime(1900),
                                              lastDate: DateTime(2101),
                                            );
                                            if (picked != null &&
                                                picked != NKhoiCongCuoi) {
                                              setState(() {
                                                NKhoiCongCuoi = DateTime(
                                                    picked.year,
                                                    picked.month,
                                                    picked.day);
                                                _controllerNgayKhoiCongCuoi
                                                        .text =
                                                    ('${NKhoiCongCuoi.year.toString()}/${NKhoiCongCuoi.month.toString()}/${NKhoiCongCuoi.day.toString()}');
                                                print('Ngày kết thúc khởi công: ' +
                                                    _controllerNgayKhoiCongCuoi
                                                        .text);
                                              });
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.white,
                                          ),
                                          child: const Icon(
                                              Icons.calendar_today,
                                              color: Colors.black),
                                        ),
                                      ]),
                                    ],
                                  ),
                                  const Text('>>> Thời gian hoàn thành'),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Bắt đầu'),
                                      Row(children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              1.5 /
                                              3,
                                          margin: const EdgeInsets.all(7),
                                          child: TextField(
                                            enabled: false,
                                            onChanged: (newValue) {},
                                            controller:
                                                _controllerNgayHoanThanh,
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  const EdgeInsets.only(
                                                      top: 0,
                                                      bottom: 0,
                                                      left: 5,
                                                      right: 5),
                                              hintText: 'Ngày hoàn thành đầu',
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(7),
                                                borderSide: const BorderSide(),
                                              ),
                                            ),
                                          ),
                                        ),
                                        ElevatedButton(
                                          onPressed: () async {
                                            final DateTime? picked =
                                                await showDatePicker(
                                              context: context,
                                              initialDate: NHoanThanh,
                                              firstDate: DateTime(1900),
                                              lastDate: DateTime(2101),
                                            );
                                            if (picked != null &&
                                                picked != NHoanThanh) {
                                              setState(() {
                                                NHoanThanh = DateTime(
                                                    picked.year,
                                                    picked.month,
                                                    picked.day);
                                                _controllerNgayHoanThanh.text =
                                                    ('${NHoanThanh.year.toString()}/${NHoanThanh.month.toString()}/${NHoanThanh.day.toString()}');

                                                print('Ngày hoàn thành đầu: ' +
                                                    _controllerNgayHoanThanh
                                                        .text);
                                              });
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.white,
                                          ),
                                          child: const Icon(
                                              Icons.calendar_today,
                                              color: Colors.black),
                                        ),
                                      ]),
                                      Text('Kết thúc'),
                                      Row(children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              1.5 /
                                              3,
                                          margin: const EdgeInsets.all(7),
                                          child: TextField(
                                            enabled: false,
                                            onChanged: (newValue) {},
                                            controller:
                                                _controllerNgayHoanThanhCuoi,
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  const EdgeInsets.only(
                                                      top: 0,
                                                      bottom: 0,
                                                      left: 5,
                                                      right: 5),
                                              hintText: 'Ngày hoàn thành cuối',
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(7),
                                                borderSide: const BorderSide(),
                                              ),
                                            ),
                                          ),
                                        ),
                                        ElevatedButton(
                                          onPressed: () async {
                                            final DateTime? picked =
                                                await showDatePicker(
                                              context: context,
                                              initialDate: NHoanThanhCuoi,
                                              firstDate: DateTime(1900),
                                              lastDate: DateTime(2101),
                                            );
                                            if (picked != null &&
                                                picked != NHoanThanhCuoi) {
                                              setState(() {
                                                NKhoiCongCuoi = DateTime(
                                                    picked.year,
                                                    picked.month,
                                                    picked.day);
                                                _controllerNgayHoanThanhCuoi
                                                        .text =
                                                    ('${NHoanThanhCuoi.year.toString()}/${NHoanThanhCuoi.month.toString()}/${NHoanThanhCuoi.day.toString()}');
                                                print('Ngày hoàn thành cuối: ' +
                                                    _controllerNgayHoanThanhCuoi
                                                        .text);
                                              });
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.white,
                                          ),
                                          child: const Icon(
                                              Icons.calendar_today,
                                              color: Colors.black),
                                        ),
                                      ]),
                                    ],
                                  ),
                                  const Text('>>> Thời gian xây dựng'),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Bắt đầu'),
                                      Row(children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              1.5 /
                                              3,
                                          margin: const EdgeInsets.all(7),
                                          child: TextField(
                                            enabled: false,
                                            onChanged: (newValue) {},
                                            controller: _controllerNgayXayDung,
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  const EdgeInsets.only(
                                                      top: 0,
                                                      bottom: 0,
                                                      left: 5,
                                                      right: 5),
                                              hintText: 'Ngày xây dựng đầu',
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(7),
                                                borderSide: const BorderSide(),
                                              ),
                                            ),
                                          ),
                                        ),
                                        ElevatedButton(
                                          onPressed: () async {
                                            final DateTime? picked =
                                                await showDatePicker(
                                              context: context,
                                              initialDate: NXayDung,
                                              firstDate: DateTime(1900),
                                              lastDate: DateTime(2101),
                                            );
                                            if (picked != null &&
                                                picked != NXayDung) {
                                              setState(() {
                                                NXayDung = DateTime(picked.year,
                                                    picked.month, picked.day);
                                                _controllerNgayXayDung.text =
                                                    ('${NXayDung.year.toString()}/${NXayDung.month.toString()}/${NXayDung.day.toString()}');

                                                print('Ngày xây dựng đầu: ' +
                                                    _controllerNgayXayDung
                                                        .text);
                                              });
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.white,
                                          ),
                                          child: const Icon(
                                              Icons.calendar_today,
                                              color: Colors.black),
                                        ),
                                      ]),
                                      Text('Kết thúc'),
                                      Row(children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              1.5 /
                                              3,
                                          margin: const EdgeInsets.all(7),
                                          child: TextField(
                                            enabled: false,
                                            onChanged: (newValue) {},
                                            controller:
                                                _controllerNgayXayDungCuoi,
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  const EdgeInsets.only(
                                                      top: 0,
                                                      bottom: 0,
                                                      left: 5,
                                                      right: 5),
                                              hintText: 'Ngày xây dựng cuối',
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(7),
                                                borderSide: const BorderSide(),
                                              ),
                                            ),
                                          ),
                                        ),
                                        ElevatedButton(
                                          onPressed: () async {
                                            final DateTime? picked =
                                                await showDatePicker(
                                              context: context,
                                              initialDate: NXayDungCuoi,
                                              firstDate: DateTime(1900),
                                              lastDate: DateTime(2101),
                                            );
                                            if (picked != null &&
                                                picked != NXayDungCuoi) {
                                              setState(() {
                                                NXayDungCuoi = DateTime(
                                                    picked.year,
                                                    picked.month,
                                                    picked.day);
                                                _controllerNgayXayDungCuoi
                                                        .text =
                                                    ('${NXayDungCuoi.year.toString()}/${NXayDungCuoi.month.toString()}/${NXayDungCuoi.day.toString()}');
                                                print('Ngày bắt đầu khởi công: ' +
                                                    _controllerNgayXayDungCuoi
                                                        .text);
                                              });
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.white,
                                          ),
                                          child: const Icon(
                                              Icons.calendar_today,
                                              color: Colors.black),
                                        ),
                                      ]),
                                    ],
                                  ),
                                  Center(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        _controllerNgayHoanThanh.clear();
                                        _controllerNgayHoanThanhCuoi.clear();
                                        _controllerNgayKhoiCong.clear();
                                        _controllerNgayKhoiCongCuoi.clear();
                                        _controllerNgayXayDung.clear();
                                        _controllerNgayXayDungCuoi.clear();
                                      },
                                      child: const Text('Làm mới'),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  },
                  icon: const Icon(Icons.tornado_rounded),
                ),
              ],
            ),
            Container(
              child: FutureBuilder<List<bridgeModel>>(
                future: _futureBridgeList,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<bridgeModel>? bridgeList = snapshot.data;
                    return Expanded(
                      child: ListView.builder(
                        itemCount: bridgeList!.length,
                        itemBuilder: (context, index) {
                          //
                          return Center(
                            child: bridgeList[index] == null
                                ? SizedBox.shrink()
                                : dropdownValue == 'Chưa xác định'
                                    ? bridgeList[index]
                                                .TenCayCau
                                                .toString()
                                                .toUpperCase()
                                                .contains(nameBridge
                                                    .toString()
                                                    .toUpperCase()) ==
                                            true
                                        ? infoBridge(
                                            bridgeModelTemp: bridgeList[index])
                                        : SizedBox.shrink()
                                    : dropdownValue ==
                                            bridgeList[index].LoaiCau.toString()
                                        ? bridgeList[index]
                                                    .TenCayCau
                                                    .toString()
                                                    .toUpperCase()
                                                    .contains(nameBridge
                                                        .toString()
                                                        .toUpperCase()) ==
                                                true
                                            ? infoBridge(
                                                bridgeModelTemp:
                                                    bridgeList[index])
                                            : SizedBox.shrink()
                                        : SizedBox.shrink(),
                          );
                        },
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
