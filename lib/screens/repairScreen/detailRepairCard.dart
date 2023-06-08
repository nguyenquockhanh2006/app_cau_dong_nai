import 'package:flutter/material.dart';
import 'package:flutter_application_4/services/models/detailRepairModel.dart';
import 'package:flutter/src/widgets/framework.dart';

class detailRepairCard extends StatefulWidget {
  final detailRepairModel detailRepairModelStart;
  const detailRepairCard({Key? key, required this.detailRepairModelStart})
      : super(key: key);
  @override
  _detailRepairCard createState() => _detailRepairCard();
}

class _detailRepairCard extends State<detailRepairCard> {
  bool _isDeleted = false;
  final TextEditingController _controllerNoiDung = TextEditingController();

  @override
  void initState() {
    _controllerNoiDung.text = widget.detailRepairModelStart.noiDung as String;
    super.initState();
    //fetchData();
  }

  Future<void> fetchData() async {
    setState(() {});
  }

  

  @override
  Widget build(BuildContext context) {
    final detailRepairModel _detailRepairModel = widget.detailRepairModelStart;
    return _isDeleted
        ? const SizedBox.shrink()
        : Card(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              //height: 190,
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      //
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Thông báo'),
                            content: Text('Bạn muốn xóa chi tiết được chọn?'),
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
                                  //bC.deleteRecord(bridgeModelTemp.BridgeId);
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
                    child: Icon(
                      Icons.delete_rounded,
                      color: Color.fromARGB(255, 255, 0, 0),
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 1 / 3,
                        child: Image.network(
                          _detailRepairModel.hinhAnh != ""
                              ? 'http://171.244.8.103:9003/${_detailRepairModel.hinhAnh}'
                              : 'http://171.244.8.103:9003//placeholder.jpg',
                          height: 150,
                          width: MediaQuery.of(context).size.width * 0.9 / 3,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: 10),
                      Container(
                        width: MediaQuery.of(context).size.width * 1.6 / 3,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Nội dung: '),
                              Row(
                                children: [
                                  //Text('Nội dung: '),
                                  Expanded(
                                    child: TextField(
                                      onChanged: (newValue) {
                                        print('nội dung: ' +
                                            _controllerNoiDung.text);
                                      },
                                      controller: _controllerNoiDung,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.only(
                                            top: 0,
                                            bottom: 0,
                                            left: 5,
                                            right: 5),
                                        hintText: 'Nhập nội dung ...',
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(7),
                                          borderSide: BorderSide(),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Text('Thời gian: '),
                              Row(
                                children: [
                                  //Text('Nội dung: '),
                                  Expanded(
                                    child: TextField(
                                      onChanged: (newValue) {
                                        print('Thời gian: ' +
                                            _controllerNoiDung.text);
                                      },
                                      controller: _controllerNoiDung,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.only(
                                            top: 0,
                                            bottom: 0,
                                            left: 5,
                                            right: 5),
                                        hintText: 'Nhập thời gian ...',
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(7),
                                          borderSide: BorderSide(),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Text('Ghi chú: '),
                              Row(
                                children: [
                                  //Text('Nội dung: '),
                                  Expanded(
                                    child: TextField(
                                      onChanged: (newValue) {
                                        print('Ghi chú: ' +
                                            _controllerNoiDung.text);
                                      },
                                      controller: _controllerNoiDung,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.only(
                                            top: 0,
                                            bottom: 0,
                                            left: 5,
                                            right: 5),
                                        hintText: 'Nhập ghi chú ... ',
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(7),
                                          borderSide: BorderSide(),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ]),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
  }
}
