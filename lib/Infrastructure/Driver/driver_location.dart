import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class driverLocation {
  final FirebaseFirestore fstore;
  final FirebaseAuth fauth;
  driverLocation({required this.fauth, required this.fstore});
  
  
  Future<void> setLocation(double latitude, double longitude) async {
    Map position = {
      'latitude': latitude,
      'longitude': longitude
    };
    
    await fstore.collection('Driver').doc(fauth.currentUser!.uid).update(
      {
        'position': position
      }
    );
  }
}