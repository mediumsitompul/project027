import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'data_model.dart';

main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Center(child: Text("Flutter_Gmaps_Query_From_dB")),
        ),
        body: Home(),
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future? _future;
  List<Marker> markerAll = [];

  Future _loadString() async {
    var url = Uri.parse(
        "http://192.168.100.100:8087/table/json_map.php?auth=kjgdkhdfldfguttedfgr");
    var response = await http.get(Uri.parse(url.toString()));
    final dynamic responsebody = jsonDecode(response.body);
    print(responsebody);
    return responsebody;
  }

  final CameraPosition _kLake = const CameraPosition(
      bearing: 0.0, target: LatLng(2.677803, 98.854665), tilt: 60.0, zoom: 10);

  @override
  void initState() {
    _future = _loadString();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder(
            future: _future,
            builder: (context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              } else {
                //.......................................
                //Query Data LatLng from database (REST API)
                ListDataModel loc = ListDataModel.fromJson(snapshot.data);
                loc.data!.forEach((i) {
                  markerAll.add(Marker(
                    markerId: MarkerId(i.locId.toString()),
                    position: LatLng(double.parse(i.locX.toString()),
                        double.parse(i.locY.toString())),
                    infoWindow: InfoWindow(
                      title: i.title1.toString(),
                      snippet: i.snippet1.toString(),
                    ),
                    onTap: () {},
                  ));
                });

                //.......................................
              }
              ;
              return GoogleMap(
                initialCameraPosition: _kLake,
                markers: Set.from(markerAll),
                mapType: MapType.hybrid,
              );
            },
          )
        ],
      ),
    );
  }
}
