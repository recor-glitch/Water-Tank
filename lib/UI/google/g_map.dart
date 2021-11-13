import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gps/UI/core/widgets/customTextField.dart';
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
  late double lat, lon;
  late Marker origin, destination;
  late TextEditingController placescontroller;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void dispose() {
    mapController.dispose();
    placescontroller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    placescontroller = new TextEditingController();
    super.initState();
  }

  Future<void> Service() async {
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
  }

  @override
  Widget build(BuildContext context) {
    Service();
    return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text('Water Tank'),
            backgroundColor: Colors.green[700],
          ),
          body: FutureBuilder(
            future: location.getLocation(),
            builder: (BuildContext context, AsyncSnapshot<LocationData> snapshot) {
              if(snapshot.hasData) {
                print(snapshot.data);
                lat = snapshot.data!.latitude!;
                lon = snapshot.data!.longitude!;
                mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(lat, lon),zoom: 15.0)));
                origin = Marker(markerId: const MarkerId('mypos'),
                    position: LatLng(lat, lon),
                    draggable: true,
                    infoWindow: const InfoWindow(title: 'Your Position'),
                    icon: BitmapDescriptor.defaultMarker);
                mymarker.add(origin);
              }
              return Stack(
                children: [
                  GoogleMap(
                      onMapCreated: _onMapCreated,
                      initialCameraPosition: const CameraPosition(
                        target:  LatLng(26.144518, 91.736237),
                        zoom: 12.0,
                      ),
                      markers: Set.from(mymarker),
                      mapType: MapType.normal,
                    onLongPress: (loc) {
                        setState(() {
                          mymarker.add(
                              Marker(markerId: MarkerId('des'),
                                position: LatLng(loc.latitude,loc.longitude),
                                icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
                                infoWindow: const InfoWindow(title: 'Destination'),
                              ));
                        });
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Column(
                        children: [
                          customTextField(placescontroller, const Icon(Icons.search), "Your Location"),
                        ],
                      )
                    ),
                  ),
                ],
              );
            },)
    );
  }
}