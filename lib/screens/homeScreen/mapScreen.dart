import 'package:flutter_application_4/services/controllers/bridgeController.dart';
import 'package:flutter_application_4/services/models/bridgeModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_application_4/screens/homeScreen/detailScreen.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';
import 'dart:math' as Math;

class flutter_map_load extends StatefulWidget {
  const flutter_map_load({Key? key}) : super(key: key);

  @override
  _MyMapState createState() => _MyMapState();
}

class _MyMapState extends State<flutter_map_load> {
  final MapController mapController = MapController();
  List<Marker> markers = [];
  bool servicestatus = false;
  bool haspermission = false;
  late LocationPermission permission;
  late Position position;
  late StreamSubscription<Position> positionStream;

  @override
  void initState() {
    super.initState();
    fetchData();
    checkGps();
    //setJson();
  }

  checkGps() async {
    servicestatus = await Geolocator.isLocationServiceEnabled();
    if (servicestatus) {
      permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          print('Location permissions are denied');
        } else if (permission == LocationPermission.deniedForever) {
          print("'Location permissions are permanently denied");
        } else {
          haspermission = true;
        }
      } else {
        haspermission = true;
      }

      if (haspermission) {
        setState(() {
          //refresh the UI
        });

        getLocation();
      }
    } else {
      print("GPS Service is not enabled, turn on GPS location");
    }

    setState(() {
      //refresh the UI
    });
  }

  Future<List<double>> getLocation() async {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    double long = position.longitude;
    double lat = position.latitude;
    setState(() {
      //refresh UI
    });

    LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high, //accuracy of the location data
      distanceFilter: 100, //minimum distance (measured in meters) a
    );

    StreamSubscription<Position> positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position position) {
      setState(() {
        //refresh UI on update
      });
    });
    return Future.value([lat, long]);
    ;
  }

  Future<void> fetchData() async {
    bridgeController bC = bridgeController();
    List<Container> myContainerList = [];
    List<bridgeModel> listBridgeModel = await bC.getApi();
    for (var bridge in listBridgeModel) {
      getLocation().then((List<double> values) {
        final distance = Distance().as(LengthUnit.Meter,
            LatLng(bridge.KinhDo, bridge.ViDo), LatLng(values[0], values[1]));
        if (distance <= 2000) {
          print('Khoảng cách vs ${bridge.TenCayCau} là: $distance m');
          myContainerList.add(Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(7),
              child: GestureDetector(
                onTap: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Detail(
                              text: bridge.TenCayCau,
                              idBridge: bridge.BridgeId,
                            )),
                  )
                },
                child: Card(
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7.0),
                  ),
                  child: ListTile(
                    title: Text('${bridge.TenCayCau}'),
                    subtitle: Text('Khoảng cách $distance m'),
                  ),
                ),
              )));
        }
        markers.add(
          Marker(
              point: LatLng(values[0], values[1]),
              builder: (ctx) => Container(
                    child: IconButton(
                        icon: Icon(
                          Icons.accessibility,
                          color: Color(0xff0077b6),
                          size: 40,
                        ),
                        onPressed: () => {
                              showModalBottomSheet<void>(
                                context: ctx,
                                builder: (BuildContext context) {
                                  return Container(
                                    height: 400,
                                    child: SingleChildScrollView(
                                        child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 30,
                                          decoration:
                                              BoxDecoration(color: Colors.blue),
                                          padding: EdgeInsets.all(7),
                                          child: Text(
                                            'Cầu gần bạn trong khoảng cách 2000 mét',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                        for (Container container
                                            in myContainerList)
                                          container,
                                      ],
                                    )),
                                  );
                                },
                              )
                            }),
                  )),
        );
      });
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
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 15, bottom: 7),
                            child: Text(
                              bridge.TenCayCau.toUpperCase(),
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                                right: 10, left: 10, bottom: 7),
                            height: MediaQuery.of(context).size.height / 3,
                            child: Image.network(
                              bridge.HinhAnhCau != ""
                                  ? 'http://171.244.8.103:9003/${bridge.HinhAnhCau}'
                                  : 'http://171.244.8.103:9003//placeholder.jpg',
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height / 3,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                                right: 10, left: 10, bottom: 7),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                      0.7 /
                                      4,
                                  child: const Text(
                                    'Địa điểm:',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 3 / 4,
                                  child: Text(bridge.DiaDiem),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                                right: 10, left: 10, bottom: 7),
                            child: Row(
                              children: [
                                const Text(
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
                            margin: const EdgeInsets.only(
                                right: 10, left: 10, bottom: 7),
                            child: Row(
                              children: [
                                const Text(
                                  'Chiều rộng: ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(bridge.ChieuRong),
                              ],
                            ),
                          ),
                          Center(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton.icon(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Detail(
                                              text: bridge.TenCayCau,
                                              idBridge: bridge.BridgeId,
                                            )),
                                  );
                                },
                                icon: const Icon(Icons.info),
                                label: const Text('Chi tiết'),
                                style: TextButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    elevation: 2,
                                    backgroundColor: Colors.blue),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              OutlinedButton.icon(
                                icon: const Icon(
                                  Icons.close,
                                  color: Color(0xffe5383b),
                                ),
                                onPressed: () => {
                                  Navigator.of(context).pop("Done"),
                                },
                                label: const Text(
                                  'Đóng',
                                  style: TextStyle(color: Color(0xffe5383b)),
                                ),
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(
                                      color: Color(0xffe5383b)),
                                ),
                              ),
                            ],
                          )),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
      );
    }
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
