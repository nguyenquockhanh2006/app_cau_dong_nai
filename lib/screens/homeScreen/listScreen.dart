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
              height: 500,
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
                            child: ListTile(
                              title: Text(bridgeList[index].TenCayCau),
                              subtitle: Text(bridgeList[index].DiaDiem),
                            ),
                          ),
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
