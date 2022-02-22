import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';



class agencyfcade{
  agencyfcade(this._fauth,this._fstore);
  final FirebaseAuth _fauth;
  final FirebaseFirestore _fstore;

  Future<void> Register_agency(String name,String email, String phn, String address) async {
    List available = [];
    Map avail1 = {
      'quantity': 500,
      'price': 200
    };
    Map avail2 = {
      'quantity': 1000,
      'price': 500
    };
    Map avail3 = {
      'quantity': 10000,
      'price': 1000
    };
    available.add(avail1);
    available.add(avail2);
    available.add(avail3);
    try {
      Map<String, dynamic> data = {
        'name': name,
        'email': email,
        'type': 'agency',
        'uid': _fauth.currentUser!.uid,
        'Availability': available,
        'phn': phn,
        'address': address
      };
      await _fstore.collection('Agency').doc(FirebaseAuth.instance.currentUser!.uid).set(data);
      print('Agency details uploaded!');
    }catch (e) {
      print(e);
    }
  }
}