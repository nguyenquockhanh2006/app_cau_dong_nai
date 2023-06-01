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
  bool check_l1 = false;
  bool check_l2 = false;
  @override
  void initState() {
    super.initState();
    _futureBridgeList = widget.bC.getApi();
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
                        return SimpleDialog(
                          title: const Text('Lọc danh sách'),
                          children: [
                            const Divider(
                              thickness: 1.0,
                              color: Colors.grey,
                            ),
                            const Text('Loại cầu'),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
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
                                      const Text('Chưa xác định'),
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
                                      const Text('Bê tông cốt thép dự ứng lực'),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const Text('Thời gian khởi công'),
                            const Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Column(children: []),
                            ),
                            const Text('Thời gian hoàn thành'),
                            const Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Column(children: []),
                            ),
                            const Text('Thời gian xây dựng'),
                            const Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Column(children: []),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Lọc'),
                            )
                          ],
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
