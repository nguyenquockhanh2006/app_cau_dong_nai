import 'package:flutter/material.dart';
import 'package:flutter_application_4/screens/homeScreen/detailScreen.dart';
import '../../services/models/bridgeModel.dart';
import '../../services/controllers/bridgeController.dart';

class list_info_bridge extends StatefulWidget {
  final bridgeController bC = bridgeController();

  list_info_bridge({super.key});

  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<list_info_bridge> {
  late Future<List<bridgeModel>> _futureBridgeList;
  late String? searchContent = '';
  @override
  void initState() {
    super.initState();
    _futureBridgeList = widget.bC.getApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh sách cầu'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.5 / 10,
              margin: const EdgeInsets.all(13),
              child: TextField(
                onChanged: (newValue) {
                  setState(() {
                    searchContent = newValue;
                  });
                  print(searchContent);
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
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.95,
                  child: FutureBuilder<List<bridgeModel>>(
                    future: _futureBridgeList,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<bridgeModel>? bridgeList = snapshot.data;
                        return ListView.builder(
                          itemCount: bridgeList!.length,
                          itemBuilder: (context, index) {
                            return bridgeList[index]
                                        .TenCayCau
                                        .toUpperCase()
                                        .contains((searchContent as String)
                                            .toUpperCase()) ==
                                    false
                                ? SizedBox.shrink()
                                : GestureDetector(
                                    onTap: () => {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Detail(
                                                  text: bridgeList[index]
                                                      .TenCayCau,
                                                  idBridge: bridgeList[index]
                                                      .BridgeId,
                                                )),
                                      )
                                    },
                                    child: Card(
                                        elevation: 5.0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(7.0),
                                        ),
                                        child: Row(
                                          children: [
                                            Container(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      7, 0, 0, 0),
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  1 /
                                                  4,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  1 /
                                                  4,
                                              child: Image.network(
                                                bridgeList[index].HinhAnhCau !=
                                                        ""
                                                    ? 'http://171.244.8.103:9003/${bridgeList[index].HinhAnhCau}'
                                                    : 'http://171.244.8.103:9003//placeholder.jpg',
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    1 /
                                                    4,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    1 /
                                                    4,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  2.75 /
                                                  4,
                                              padding: const EdgeInsets.all(10),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    bridgeList[index].TenCayCau,
                                                    style: const TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    bridgeList[index].DiaDiem,
                                                    style: const TextStyle(
                                                      fontSize: 17,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        )),
                                  );
                          },
                        );
                      } else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }
                      return const CircularProgressIndicator();
                    },
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
