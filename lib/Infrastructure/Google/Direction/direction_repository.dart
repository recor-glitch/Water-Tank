import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gps/Models/Google%20Models/direction_model.dart';
import 'package:gps/constants.dart';
import 'package:dio/dio.dart';

class DirectionRepository {
   static late final String baseUrl;
   Dio dio = Dio();
   DirectionData directionData = DirectionData();

   Future<DirectionData> getDirection (LatLng initialPos, LatLng finalpos) async {
      baseUrl = "https://maps.googleapis.com/maps/api/directions/json?";
          dynamic result = await dio.get(baseUrl,
          queryParameters: {
            'origin': '${initialPos.latitude},${initialPos.longitude}',
             'destination': '${finalpos.latitude},${finalpos.longitude}',
             'key': g_apikey,
          });
      if(result.statusCode == 200) {
        print('Request successfull.');
        print('Result :: $result');
         //get the direction data...
        directionData.polylinepoints = result["routes"][0]["overview_polyline"]["points"];
        directionData.distancetext = result["routes"][0]["legs"][0]["distance"]["text"];
        directionData.distancevalue = result["routes"][0]["legs"][0]["distance"]["value"];
        directionData.durationtext = result["routes"][0]["legs"][0]["duration"]["text"];
        directionData.durationvalue = result["routes"][0]["legs"][0]["duration"]["value"];
      }
     return directionData;
   }
}