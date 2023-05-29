import 'package:flutter_application_4/services/controllers/bridgeController.dart';
import 'package:flutter_application_4/services/controllers/jsonController.dart';
import 'package:flutter_application_4/services/models/bridgeModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_application_4/screens/homeScreen/detailScreen.dart';

class flutter_map_load extends StatefulWidget {
  const flutter_map_load({Key? key}) : super(key: key);

  @override
  _MyMapState createState() => _MyMapState();
}

class _MyMapState extends State<flutter_map_load> {
  final MapController mapController = MapController();
  List<Marker> markers = [];

  @override
  void initState() {
    super.initState();
    fetchData();
    //setJson();
  }

  Future<void> setJson() async {
    jsonController j_c = new jsonController();
    j_c.writeFileJson();
  }

  Future<void> fetchData() async {
    bridgeController b_c = new bridgeController();
    List<bridgeModel> list_bridge_model = await b_c.getApi();
    list_bridge_model.forEach((bridge) {
      markers.add(
        Marker(
          width: 80.0,
          height: 80.0,
          point: LatLng(bridge.KinhDo, bridge.ViDo),
          builder: (ctx) => Container(
            child: IconButton(
              icon: Image.network(
                'https://i.imgur.com/x94d3tp.png',
                width: 50,
                height: 50,
              ),
              color: Colors.red,
              iconSize: 30.0,
              onPressed: () {
                showModalBottomSheet<void>(
                  context: ctx,
                  builder: (BuildContext context) {
                    return Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 15, bottom: 7),
                          child: Text(
                            bridge.TenCayCau.toUpperCase(),
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          margin:
                              EdgeInsets.only(right: 10, left: 10, bottom: 7),
                          height: 180,
                          child: Image.network(
                            bridge.HinhAnhCau != ""
                                ? 'http://171.244.8.103:9003/' +
                                    bridge.HinhAnhCau
                                : 'http://171.244.8.103:9003//placeholder.jpg',
                            width: MediaQuery.of(context).size.width,
                            height: 180,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          margin:
                              EdgeInsets.only(right: 10, left: 10, bottom: 7),
                          child: Row(
                            children: [
                              Container(
                                width:
                                    MediaQuery.of(context).size.width * 0.7 / 4,
                                child: Text(
                                  'Địa điểm:',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Container(
                                width:
                                    MediaQuery.of(context).size.width * 3 / 4,
                                child: Text(bridge.DiaDiem),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin:
                              EdgeInsets.only(right: 10, left: 10, bottom: 7),
                          child: Row(
                            children: [
                              Text(
                                'Chiều dài: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(bridge.ChieuDai),
                            ],
                          ),
                        ),
                        Container(
                          margin:
                              EdgeInsets.only(right: 10, left: 10, bottom: 7),
                          child: Row(
                            children: [
                              Text(
                                'Chiều rộng: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(bridge.ChieuRong),
                            ],
                          ),
                        ),
                        Container(
                            width: 400,
                            margin: EdgeInsets.all(7),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 35,
                                  width: 180,
                                  padding: EdgeInsets.only(left: 30, right: 10),
                                  child: TextButton.icon(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Detail(
                                                  text: bridge.TenCayCau,
                                                )),
                                      );
                                    },
                                    icon: Icon(Icons.info),
                                    label: Text('Chi tiết'),
                                    style: TextButton.styleFrom(
                                        foregroundColor: Colors.white,
                                        elevation: 2,
                                        backgroundColor: Colors.blue),
                                  ),
                                ),
                                Container(
                                  height: 35,
                                  width: 180,
                                  padding: EdgeInsets.only(left: 10, right: 30),
                                  child: OutlinedButton.icon(
                                    icon: Icon(
                                      Icons.close,
                                      color: Color(0xffe5383b),
                                    ),
                                    onPressed: () => {
                                      Navigator.of(context).pop("Done"),
                                    },
                                    label: Text(
                                      'Đóng',
                                      style:
                                          TextStyle(color: Color(0xffe5383b)),
                                    ),
                                    style: OutlinedButton.styleFrom(
                                      side:
                                          BorderSide(color: Color(0xffe5383b)),
                                    ),
                                  ),
                                ),
                              ],
                            )),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ),
      );
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 114, 151, 239),
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text('Bản đồ'),
        toolbarHeight: 30,
      ),
      body: FlutterMap(
        mapController: mapController,
        options: MapOptions(center: LatLng(10.952772, 106.807671), zoom: 12),
        layers: [
          TileLayerOptions(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: ['a', 'b', 'c'],
          ),
          MarkerLayerOptions(markers: markers)
        ],
      ),
    );
  }
}
