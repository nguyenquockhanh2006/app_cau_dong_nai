import 'package:flutter_application_4/services/controllers/bridgeController.dart';
import 'package:flutter_application_4/services/models/bridgeModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
// import 'package:flutter_application_4/services/models/imageSrc.dart';

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
          builder: (ctx) =>
          Container(
            child: IconButton(
              icon: Image.network('https://i.imgur.com/F7m2gCK.png'),
              color: Colors.red,
              iconSize: 7.0,
              onPressed: () {
                // print(bridge.HinhAnhCau);
                showModalBottomSheet<void>(
                  context: ctx,
                  builder: (BuildContext context) {
                    return Column(
                      children: [
                        Text(
                          bridge.TenCayCau.toUpperCase(),
                        ),
                       
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
      body: FlutterMap(
        mapController: mapController,
        options: MapOptions(center: LatLng(10.952772, 106.807671), zoom: 12),
        layers: [
          TileLayerOptions(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: ['a', 'b', 'c'],
          ),
          MarkerLayerOptions(
            markers: markers
            )
        ],
      ),
    );
  }
}
