import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';



class agencyfcade{
  agencyfcade(this._fauth,this._fstore);
  final FirebaseAuth _fauth;
  final FirebaseFirestore _fstore;

  Future<void> Register_agency(String name,String email) async {
    try {
      Map<String, dynamic> data = {
        'name': name,
        'email': email,
        'type': 'agency',
        'uid': _fauth.currentUser!.uid,
      };
      await _fstore.collection('Agency').doc(FirebaseAuth.instance.currentUser!.uid).set(data);
      print('Agency details uploaded!');
    }catch (e) {
      print(e);
    }
  }
}