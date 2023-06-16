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
  final TextEditingController _controllerNgayKhoiCong = TextEditingController();
  final TextEditingController _controllerNgayHoanThanh =
      TextEditingController();
  //final TextEditingController _controllerNgayXayDung = TextEditingController();
  final TextEditingController _controllerNgayKhoiCongCuoi =
      TextEditingController();
  final TextEditingController _controllerNgayHoanThanhCuoi =
      TextEditingController();
  // final TextEditingController _controllerNgayXayDungCuoi =
  //     TextEditingController();
  String dropdownValue = 'Chưa xác định';
  List<String>? listTypeBridge;
  String finalValue = '';
  late String? nameBridge = '';
  DateTime NKhoiCong = DateTime.now();
  DateTime NHoanThanh = DateTime.now();
  //DateTime NXayDung = DateTime.now();
  DateTime NKhoiCongCuoi = DateTime.now();
  DateTime NHoanThanhCuoi = DateTime.now();
  //DateTime NXayDungCuoi = DateTime.now();
  bool? check_l1 = false;
  bool? check_l2 = false;
  bool? checkAnHien = false;
  bool? reset = false;
  @override
  void initState() {
    super.initState();
  }

  Future<List<bridgeModel>> setLoai() async {
    List<bridgeModel> bridgesT = await widget.bC.getApi();
    List<bridgeModel> bridges = [];
    List<bridgeModel> bridgesKC = [];
    List<bridgeModel> bridgesKCC = [];
    List<bridgeModel> bridgesHT = [];
    List<bridgeModel> bridgesHTC = [];
    // List<bridgeModel> bridgesXD = [];
    // List<bridgeModel> bridgesXDC = [];
    if (dropdownValue != 'Chưa xác định') {
      for (int i = 0; i < bridgesT.length; i++) {
        if (bridgesT.elementAt(i).LoaiCau == dropdownValue) {
          bridges.add(bridgesT.elementAt(i));
        }
      }
    } else {
      bridges = bridgesT;
    }
//
    if (_controllerNgayKhoiCong.text == '') {
      bridgesKC = bridges;
    } else {
      for (int i = 0; i < bridges.length; i++) {
        if (bridges
                .elementAt(i)
                .NgayKhoiCong
                .compareTo(_controllerNgayKhoiCong.text) >=
            0) {
          bridgesKC.add(bridges.elementAt(i));
        }
      }
    }
//
    if (_controllerNgayKhoiCongCuoi.text == '') {
      bridgesKCC = bridgesKC;
    } else {
      for (int i = 0; i < bridgesKC.length; i++) {
        if (bridgesKC
                .elementAt(i)
                .NgayKhoiCong
                .compareTo(_controllerNgayKhoiCongCuoi.text) <=
            0) {
          bridgesKCC.add(bridgesKC.elementAt(i));
        }
      }
    }
//
    if (_controllerNgayHoanThanh.text == '') {
      bridgesHT = bridgesKCC;
    } else {
      for (int i = 0; i < bridgesKCC.length; i++) {
        if (bridgesKCC
                .elementAt(i)
                .NgayHoanThanh
                .compareTo(_controllerNgayHoanThanh.text) >=
            0) {
          bridgesHT.add(bridgesKCC.elementAt(i));
        }
      }
    }
//
    if (_controllerNgayHoanThanhCuoi.text == '') {
      bridgesHTC = bridgesHT;
    } else {
      for (int i = 0; i < bridgesKCC.length; i++) {
        if (bridgesHT
                .elementAt(i)
                .NgayHoanThanh
                .compareTo(_controllerNgayHoanThanhCuoi.text) <=
            0) {
          bridgesHTC.add(bridgesHT.elementAt(i));
        }
      }
    }
    //return bridgesXDC;
    return bridgesHTC;
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
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  //width: MediaQuery.of(context).size.width * 4 / 5,
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
              ),
              IconButton(
                onPressed: () => {
                  setState(() {
                    checkAnHien = !checkAnHien!;
                  }),
                },
                icon: const Icon(Icons.tornado_rounded),
              ),
            ],
          ),
          checkAnHien == false
              ? const SizedBox.shrink()
              : Container(
                  padding: const EdgeInsets.all(7),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(7),
                        bottomLeft: Radius.circular(7),
                        bottomRight: Radius.circular(7),
                      ),
                      border: Border.all(color: const Color(0xFFadb5bd))),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Lọc danh sách',
                          style: TextStyle(
                              fontSize: 18,
                              color: Color.fromARGB(255, 100, 100, 241),
                              fontWeight: FontWeight.bold),
                        ),
                        const Divider(
                          thickness: 1.0,
                          color: Colors.grey,
                        ),
                        const Text(
                          '>>> Loại cầu',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Row(children: [
                          Expanded(
                            child: FutureBuilder(
                              future: widget.bC.getTypeNameApi(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return DropdownButton<String>(
                                    value: dropdownValue,
                                    items: snapshot.data
                                        ?.map((item) => DropdownMenuItem(
                                              value: item,
                                              child: Text(item),
                                            ))
                                        .toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        dropdownValue = value as String;
                                      });
                                    },
                                  );
                                } else if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                } else {
                                  return CircularProgressIndicator();
                                }
                              },
                            ),
                          ),
                        ]),
                        const Text(
                          '>>> Thời gian khởi công',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Bắt đầu'),
                                  Row(children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          1 /
                                          4,
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
                                          hintText: 'Bắt đầu',
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
                                            NKhoiCong = DateTime(picked.year,
                                                picked.month, picked.day);
                                            _controllerNgayKhoiCong.text =
                                                ('${NKhoiCong.year.toString()}-${NKhoiCong.month.toString()}-${NKhoiCong.day.toString()}');

                                            print('Ngày bắt đầu khởi công: ' +
                                                _controllerNgayKhoiCong.text);
                                          });
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                      ),
                                      child: const Icon(Icons.calendar_today,
                                          color: Colors.black),
                                    ),
                                  ]),
                                ],
                              ),
                            ),
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Kết thúc'),
                                Row(children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        1 /
                                        4,
                                    margin: const EdgeInsets.all(7),
                                    child: TextField(
                                      enabled: false,
                                      onChanged: (newValue) {},
                                      controller: _controllerNgayKhoiCongCuoi,
                                      decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.only(
                                            top: 0,
                                            bottom: 0,
                                            left: 5,
                                            right: 5),
                                        hintText: 'Kết thúc',
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
                                          NKhoiCongCuoi = DateTime(picked.year,
                                              picked.month, picked.day);
                                          _controllerNgayKhoiCongCuoi.text =
                                              ('${NKhoiCongCuoi.year.toString()}-${NKhoiCongCuoi.month.toString()}-${NKhoiCongCuoi.day.toString()}');
                                          print('Ngày kết thúc khởi công: ' +
                                              _controllerNgayKhoiCongCuoi.text);
                                        });
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                    ),
                                    child: const Icon(Icons.calendar_today,
                                        color: Colors.black),
                                  ),
                                ]),
                              ],
                            )),
                          ],
                        ),
                        const Text(
                          '>>> Thời gian hoàn thành',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Bắt đầu'),
                                    Row(children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                1 /
                                                4,
                                        margin: const EdgeInsets.all(7),
                                        child: TextField(
                                          enabled: false,
                                          onChanged: (newValue) {},
                                          controller: _controllerNgayHoanThanh,
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
                                              NHoanThanh = DateTime(picked.year,
                                                  picked.month, picked.day);
                                              _controllerNgayHoanThanh.text =
                                                  ('${NHoanThanh.year.toString()}-${NHoanThanh.month.toString()}-${NHoanThanh.day.toString()}');

                                              print('Ngày hoàn thành đầu: ' +
                                                  _controllerNgayHoanThanh
                                                      .text);
                                            });
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.white,
                                        ),
                                        child: const Icon(Icons.calendar_today,
                                            color: Colors.black),
                                      ),
                                    ]),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Kết thúc'),
                                    Row(children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                1 /
                                                4,
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
                                              picked != NKhoiCong) {
                                            setState(() {
                                              NHoanThanhCuoi = DateTime(
                                                  picked.year,
                                                  picked.month,
                                                  picked.day);
                                              _controllerNgayHoanThanhCuoi
                                                      .text =
                                                  ('${NHoanThanhCuoi.year.toString()}-${NHoanThanhCuoi.month.toString()}-${NHoanThanhCuoi.day.toString()}');

                                              print('Ngày hoàn thành cuối: ' +
                                                  _controllerNgayHoanThanhCuoi
                                                      .text);
                                            });
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.white,
                                        ),
                                        child: const Icon(Icons.calendar_today,
                                            color: Colors.black),
                                      ),
                                    ]),
                                  ],
                                ),
                              ),
                            ]),
                        //
                        // const Text(
                        //   '>>> Thời gian xây dựng',
                        //   style: TextStyle(
                        //     fontWeight: FontWeight.bold,
                        //   ),
                        // ),
                        // Row(
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   children: [
                        //     Container(
                        //       width: MediaQuery.of(context).size.width / 2,
                        //       child: Column(
                        //           crossAxisAlignment: CrossAxisAlignment.start,
                        //           children: [
                        //             Text('Bắt đầu'),
                        //             Row(children: [
                        //               Container(
                        //                 width:
                        //                     MediaQuery.of(context).size.width *
                        //                         1 /
                        //                         4,
                        //                 margin: const EdgeInsets.all(7),
                        //                 child: TextField(
                        //                   enabled: false,
                        //                   onChanged: (newValue) {},
                        //                   controller: _controllerNgayXayDung,
                        //                   decoration: InputDecoration(
                        //                     contentPadding:
                        //                         const EdgeInsets.only(
                        //                             top: 0,
                        //                             bottom: 0,
                        //                             left: 5,
                        //                             right: 5),
                        //                     hintText: 'Ngày xây dựng đầu',
                        //                     border: OutlineInputBorder(
                        //                       borderRadius:
                        //                           BorderRadius.circular(7),
                        //                       borderSide: const BorderSide(),
                        //                     ),
                        //                   ),
                        //                 ),
                        //               ),
                        //               ElevatedButton(
                        //                 onPressed: () async {
                        //                   final DateTime? picked =
                        //                       await showDatePicker(
                        //                     context: context,
                        //                     initialDate: NXayDung,
                        //                     firstDate: DateTime(1900),
                        //                     lastDate: DateTime(2101),
                        //                   );
                        //                   if (picked != null &&
                        //                       picked != NXayDung) {
                        //                     setState(() {
                        //                       NXayDung = DateTime(picked.year,
                        //                           picked.month, picked.day);
                        //                       _controllerNgayXayDung.text =
                        //                           ('${NXayDung.year.toString()}-${NXayDung.month.toString()}-${NXayDung.day.toString()}');

                        //                       print('Ngày xây dựng đầu: ' +
                        //                           _controllerNgayXayDung.text);
                        //                     });
                        //                   }
                        //                 },
                        //                 style: ElevatedButton.styleFrom(
                        //                   backgroundColor: Colors.white,
                        //                 ),
                        //                 child: const Icon(Icons.calendar_today,
                        //                     color: Colors.black),
                        //               ),
                        //             ]),
                        //           ]),
                        //     ),
                        //     Expanded(
                        //         child: Column(
                        //       crossAxisAlignment: CrossAxisAlignment.start,
                        //       children: [
                        //         Text('Kết thúc'),
                        //         Row(children: [
                        //           Container(
                        //             width: MediaQuery.of(context).size.width *
                        //                 1 /
                        //                 4,
                        //             margin: const EdgeInsets.all(7),
                        //             child: TextField(
                        //               enabled: false,
                        //               onChanged: (newValue) {},
                        //               controller: _controllerNgayXayDungCuoi,
                        //               decoration: InputDecoration(
                        //                 contentPadding: const EdgeInsets.only(
                        //                     top: 0,
                        //                     bottom: 0,
                        //                     left: 5,
                        //                     right: 5),
                        //                 hintText: 'Ngày xây dựng cuối',
                        //                 border: OutlineInputBorder(
                        //                   borderRadius:
                        //                       BorderRadius.circular(7),
                        //                   borderSide: const BorderSide(),
                        //                 ),
                        //               ),
                        //             ),
                        //           ),
                        //           ElevatedButton(
                        //             onPressed: () async {
                        //               final DateTime? picked =
                        //                   await showDatePicker(
                        //                 context: context,
                        //                 initialDate: NXayDungCuoi,
                        //                 firstDate: DateTime(1900),
                        //                 lastDate: DateTime(2101),
                        //               );
                        //               if (picked != null &&
                        //                   picked != NXayDungCuoi) {
                        //                 setState(() {
                        //                   NXayDungCuoi = DateTime(picked.year,
                        //                       picked.month, picked.day);
                        //                   _controllerNgayXayDungCuoi.text =
                        //                       ('${NXayDungCuoi.year.toString()}-${NXayDungCuoi.month.toString()}-${NXayDungCuoi.day.toString()}');
                        //                   print('Ngày bắt đầu khởi công: ' +
                        //                       _controllerNgayXayDungCuoi.text);
                        //                 });
                        //               }
                        //             },
                        //             style: ElevatedButton.styleFrom(
                        //               backgroundColor: Colors.white,
                        //             ),
                        //             child: const Icon(Icons.calendar_today,
                        //                 color: Colors.black),
                        //           ),
                        //         ]),
                        //       ],
                        //     ))
                        //   ],
                        // ),
                        Center(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: SizedBox(),
                              ),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      checkAnHien = !checkAnHien!;
                                    });
                                  },
                                  child: const Text('Áp dụng'),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    _controllerNgayHoanThanh.clear();
                                    _controllerNgayHoanThanhCuoi.clear();
                                    _controllerNgayKhoiCong.clear();
                                    _controllerNgayKhoiCongCuoi.clear();
                                    // _controllerNgayXayDung.clear();
                                    // _controllerNgayXayDungCuoi.clear();
                                    setState(() {
                                      reset = !reset!;
                                    });
                                  },
                                  child: const Text('Làm mới'),
                                ),
                              ),
                              Expanded(
                                child: SizedBox(),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
          Expanded(
              child: Container(
            height: 200,
            child: FutureBuilder<List<bridgeModel>>(
              future: setLoai(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<bridgeModel>? bridgeList = snapshot.data;
                  return Expanded(
                    child: ListView.builder(
                      itemCount: bridgeList!.length,
                      itemBuilder: (context, index) {
                        return Center(
                          child: infoBridge(bridgeModelTemp: bridgeList[index]),
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
          ))
        ],
      ),
    );
  }
}
