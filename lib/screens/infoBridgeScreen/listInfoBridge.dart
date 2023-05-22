import 'package:flutter/material.dart';
import 'package:flutter_application_4/screens/infoBridgeScreen/infoBridge.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../../services/controllers/bridgeController.dart';
import '../../services/models/bridgeModel.dart';
import 'package:flutter_application_4/screens/infoBridgeScreen/addBridgeScreen.dart';

class listInfoBridge extends StatefulWidget {
  final bridgeController bC = bridgeController();

  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<listInfoBridge> {
  late Future<List<bridgeModel>> _futureBridgeList;
  bool check_l1 = false;
  bool check_l2 = false;
  @override
  void initState() {
    super.initState();
    _futureBridgeList = widget.bC.getApi();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'QUẢN LÍ THÔNG TIN CẦU',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 350,
                  margin: EdgeInsets.all(13),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Tìm kiếm',
                      hintText: 'Nhập...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(),
                      ),
                      suffixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return SimpleDialog(
                          title: Text('Lọc danh sách'),
                          children: [
                            Divider(
                              thickness: 1.0,
                              color: Colors.grey,
                            ),
                            Text('Loại cầu'),
                            Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Checkbox(
                                        value: check_l1,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            check_l1 = value!;
                                          });
                                        },
                                      ),
                                      Text('Chưa xác định'),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Checkbox(
                                        value: check_l2,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            check_l2 = value!;
                                          });
                                        },
                                      ),
                                      Text('Bê tông cốt thép dự ứng lực'),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Text('Thời gian khởi công'),
                            Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Column(children: []),
                            ),
                            Text('Thời gian hoàn thành'),
                            Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Column(children: []),
                            ),
                            Text('Thời gian xây dựng'),
                            Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Column(children: []),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('Lọc'),
                            )
                          ],
                        );
                      },
                    ),
                    //
                  },
                  icon: Icon(Icons.tornado_rounded),
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
                          return Center(
                            child:
                                infoBridge(bridgeModelTemp: bridgeList[index]),
                          );
                        },
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  // Hiển thị tiêu đề khi đang chờ Future hoàn thành
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => {
          navigatorKey.currentState?.push(
            MaterialPageRoute(builder: (context) => addBridgeScreen()),
          ),
        },
        label: Text('Thêm cầu'),
        icon: Icon(Icons.add),
        backgroundColor: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}


