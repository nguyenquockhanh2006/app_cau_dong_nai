import 'package:flutter/material.dart';
import 'package:flutter_application_4/screens/homeScreen/detailScreen.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../../services/models/bridgeModel.dart';
import '../../services/controllers/bridgeController.dart';

class list_info_bridge extends StatefulWidget {
  final bridgeController bC = bridgeController();

  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<list_info_bridge> {
  late Future<List<bridgeModel>> _futureBridgeList;

  @override
  void initState() {
    super.initState();
    _futureBridgeList = widget.bC.getApi();
  }

  @override
  Widget build(BuildContext context) {
    double _containerHeight = 0.0;
    return Scaffold(
        appBar: AppBar(
          title: Text('Danh sách cầu'),
        ),
        body: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.5 / 10,
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
            Container(
              margin: EdgeInsets.all(5),
              height: MediaQuery.of(context).size.height * 8 / 10,
              child: FutureBuilder<List<bridgeModel>>(
                future: _futureBridgeList,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<bridgeModel>? bridgeList = snapshot.data;
                    return ListView.builder(
                      itemCount: bridgeList!.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () => {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Detail(
                                        text: bridgeList[index].TenCayCau,
                                      )),
                            )
                          },
                          child: Card(
                              elevation: 5.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7.0),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.fromLTRB(7, 0, 0, 0),
                                    height: MediaQuery.of(context).size.width *
                                        1 /
                                        4,
                                    width: MediaQuery.of(context).size.width *
                                        1 /
                                        4,
                                    child: Image.network(
                                      bridgeList[index].HinhAnhCau != ""
                                          ? 'http://171.244.8.103:9003/' +
                                              bridgeList[index].HinhAnhCau
                                          : 'http://171.244.8.103:9003//placeholder.jpg',
                                      height:
                                          MediaQuery.of(context).size.width *
                                              1 /
                                              4,
                                      width: MediaQuery.of(context).size.width *
                                          1 /
                                          4,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        2.75 /
                                        4,
                                    padding: EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          bridgeList[index].TenCayCau,
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          bridgeList[index].DiaDiem,
                                          style: TextStyle(
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
                  return CircularProgressIndicator();
                },
              ),
            ),
          ],
        ));
  }
}
