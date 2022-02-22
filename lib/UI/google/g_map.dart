import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gps/Infrastructure/Google/Direction/direction_repository.dart';
import 'package:gps/Models/Google%20Models/direction_model.dart';
import 'package:location/location.dart';

class g_map extends StatefulWidget {
  const g_map({Key? key, this.position, this.name}) : super(key: key);
  final position;
  final name;

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<g_map> {
  Completer<GoogleMapController> mapController = Completer();
  late GoogleMapController controller;
  var l_data;
  Location location = Location();
  var isServiceEnabled;
  late PermissionStatus _permissionGranted;
  List<Marker> mymarker = [];
  late double lat, lon;
  late Marker origin, destination;
  late LatLng originpos, despos;
  var route;
  late DirectionData info;
  late DirectionRepository direction;
  late BitmapDescriptor customIcon;

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> custom() async {
    customIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(30, 30)), 'assets/tank-truck.png');
  }

  @override
  void initState() {
    direction = DirectionRepository();
    // TODO: implement initState
    super.initState();
  }

  Future<void> Service() async {
    isServiceEnabled = await location.serviceEnabled();
    if (!isServiceEnabled) {
      isServiceEnabled = await location.requestService();
      if (!isServiceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Service();
    custom();
    return FutureBuilder(
      future: location.getLocation(),
      builder: (BuildContext context, AsyncSnapshot<LocationData> snapshot) {
        if (snapshot.hasData) {
          lat = snapshot.data!.latitude!;
          lon = snapshot.data!.longitude!;
          originpos = LatLng(lat, lon);
          gotolocation(lat, lon);
          origin = Marker(
              markerId: const MarkerId('mypos'),
              position: LatLng(lat, lon),
              draggable: false,
              infoWindow: const InfoWindow(title: 'Your Position'),
              icon: BitmapDescriptor.defaultMarker);
          mymarker.add(origin);
          if (widget.position != null && widget.name == 'driver') {
            var pos = Marker(
                markerId: const MarkerId('destination'),
                position: LatLng(
                    widget.position['latitude'], widget.position['longitude']),
                draggable: false,
                infoWindow: InfoWindow(title: widget.name),
                icon: customIcon);
            mymarker.add(pos);
          }
          if (widget.position != null && widget.name == 'user') {
            var pos = Marker(
                markerId: const MarkerId('destination'),
                position: LatLng(
                    widget.position['latitude'], widget.position['longitude']),
                draggable: false,
                infoWindow: InfoWindow(title: widget.name),
                icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen));
            mymarker.add(pos);
          }
        }
        return Stack(
          children: [
            GoogleMap(
              onMapCreated: (GoogleMapController controller) async {
                mapController.complete(controller);
              },
              initialCameraPosition: const CameraPosition(
                target: LatLng(26.144518, 91.736237),
                zoom: 12.0,
              ),
              markers: Set.from(mymarker),
              mapType: MapType.normal,
              onTap: (LatLng) {
                if (widget.position != null) {
                  gotolocation(widget.position['latitude'],
                      widget.position['longitude']);
                }
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> gotolocation(double lat, double lon) async {
    controller = await mapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(lat, lon), zoom: 15.0)));
  }
}
