//10.952772, 106.807671
import 'package:app_cau_dong_nai/services/controllers/bridge_controller.dart';
import 'package:app_cau_dong_nai/services/models/bridge_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

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
    bridge_controller b_c = new bridge_controller();
    List<bridge_model> list_bridge_model = await b_c.getApi();

    list_bridge_model.forEach((bridge) {
      markers.add(
        Marker(
          width: 80.0,
          height: 80.0,
          point: LatLng(bridge.KinhDo, bridge.ViDo),
          builder: (ctx) => Icon(Icons.location_on, color: Colors.red),
        ),
      );
    });

    // Gọi setState() để báo cho Flutter biết rằng state đã được thay đổi.
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
          MarkerLayerOptions(markers: markers)
        ],
      ),
    );
  }
}
