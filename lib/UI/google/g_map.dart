import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';



class g_map extends StatefulWidget {
  const g_map({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<g_map> {
  late GoogleMapController mapController;
  var l_data;
  Location location = Location();
  var isServiceEnabled;
  late PermissionStatus _permissionGranted;
  List<Marker> mymarker = [];

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void Service() async {
    isServiceEnabled = await location.serviceEnabled();
    if(!isServiceEnabled) {
      isServiceEnabled = await location.requestService();
      if(!isServiceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if(_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if(_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    l_data = await location.getLocation();

    mymarker.add(Marker(
        markerId: const MarkerId('MyMarker'),
        icon: BitmapDescriptor.defaultMarker,
        position: LatLng(l_data.latitude, l_data.longitude),
        onTap: () {
          setState(() {});
        }
    ));
  }

  @override
  Widget build(BuildContext context) {
    Service();
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Maps Sample App'),
            backgroundColor: Colors.green[700],
          ),
          body: l_data != null?
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target:  LatLng(l_data.latitude, l_data.longitude),
              zoom: 15.0,
            ),
            markers: Set.from(mymarker),
          )
              : const Center(child: CircularProgressIndicator())
      ),
    );
  }
}