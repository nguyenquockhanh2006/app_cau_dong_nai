import 'package:flutter/material.dart';
import 'package:flutter_application_4/services/controllers/bridgeController.dart';
import 'package:flutter_application_4/services/controllers/detailBridgeController.dart';
import 'package:flutter_application_4/services/models/bridgeModel.dart';
import 'package:flutter_application_4/services/models/detailBridgeModel.dart';
import 'package:flutter_application_4/screens/infoBridgeScreen/detailBridgeScreenVs2.dart';

class infoBridge extends StatefulWidget {
  //const infoBridge({super.key});
  final bridgeModel bridgeModelTemp;

  const infoBridge({Key? key, required this.bridgeModelTemp}) : super(key: key);

  @override
  _infoBridgeState createState() => _infoBridgeState();
}

class _infoBridgeState extends State<infoBridge> {
  bool _isDeleted = false;

  Future<detailBridgeModel> getData(int id) async {
    detailBridgeController cBC = detailBridgeController();
    return await cBC.getApiById(id);
  }

  @override
  Widget build(BuildContext context) {
    final bridgeModel bridgeModelTemp = widget.bridgeModelTemp;
    final bridgeController bC = bridgeController();
    return _isDeleted
        ? const SizedBox.shrink()
        : Card(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 190,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 1.25 / 3,
                    height: 190,
                    padding: const EdgeInsets.all(0.5),
                    child: SingleChildScrollView(
                      child: Column(
                        //crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            bridgeModelTemp.TenCayCau,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 120,
                            width: MediaQuery.of(context).size.width * 1.25 / 3,
                            child: Image.network(
                              bridgeModelTemp.HinhAnhCau != ""
                                  ? 'http://171.244.8.103:9003/${bridgeModelTemp.HinhAnhCau}'
                                  : 'http://171.244.8.103:9003//placeholder.jpg',
                              height: 109.76,
                              width:
                                  MediaQuery.of(context).size.width * 1.25 / 3,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const Divider(),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailAndUpdate(
                                          idBridge: bridgeModelTemp.BridgeId)));
                            },
                            child: const Text(
                              "CHI TIẾT / CẬP NHẬT",
                              style: TextStyle(
                                fontSize: 11,
                                color: Color.fromARGB(255, 37, 152, 247),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              //
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Thông báo'),
                                    content: Text('Bạn muốn xóa ${bridgeModelTemp.TenCayCau}'),
                                    actions: [
                                      TextButton(
                                        child: const Text('Huỷ bỏ'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      TextButton(
                                        child: const Text('Xác nhận xóa'),
                                        onPressed: () {
                                          // Xử lý khi người dùng chọn xác nhận
                                          bC.deleteRecord(
                                              bridgeModelTemp.BridgeId);
                                          setState(() {
                                            _isDeleted = true;
                                          });
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                              //
                            },
                            child: const Text(
                              "XÓA CÂY CẦU",
                              style: TextStyle(
                                fontSize: 11,
                                color: Color.fromARGB(255, 254, 2, 2),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 1.68 / 3,
                    height: 190,
                    padding: const EdgeInsets.fromLTRB(3, 15, 2, 0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 125,
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Địa điểm: ",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              1.1 /
                                              3,
                                          child: Text(
                                            bridgeModelTemp.DiaDiem,
                                            maxLines: 4,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Lí trình: ",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              1.1 /
                                              3,
                                          child: Text(
                                            bridgeModelTemp.LyTrinh,
                                            maxLines: 4,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Loại cầu: ",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              1.1 /
                                              3,
                                          child: Text(
                                            bridgeModelTemp.LoaiCau,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Chiều dài(m): ",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(bridgeModelTemp.ChieuDai),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Chiều rộng(m): ",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(bridgeModelTemp.ChieuRong),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.bottomLeft,
                          height: 44,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "",
                                style: TextStyle(
                                  fontSize: 10,
                                ),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Ngày khởi công: ",
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 37, 152, 247),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(bridgeModelTemp.NgayKhoiCong),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Ngày hoàn thành: ",
                                    style: TextStyle(
                                      color: Color.fromRGBO(134, 200, 141, 1),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(bridgeModelTemp.NgayHoanThanh),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
