import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io' as i;
import 'package:image_picker/image_picker.dart';



class driverfcade{
  driverfcade(this._fauth,this._fstore,this._fstorage);
  final FirebaseAuth _fauth;
  final FirebaseFirestore _fstore;
  final FirebaseStorage _fstorage;

  Future<void> Register_driver(String name,String phn,String vehicle,String regno,XFile _image) async {
    Reference ref = FirebaseStorage.instance.ref('Upload').child(FirebaseAuth.instance.currentUser!.uid);
    try {
      await ref.putFile(i.File(_image.path));
      String url = await ref.getDownloadURL();
      Map<String, dynamic> data = {
        'name': name,
        'phn': phn,
        'vehicle': vehicle,
        'regno': regno,
        'profile': url,
        'type': 'driver',
        'verification': 'unverified'
      };
      await _fstore.collection('Driver').doc(FirebaseAuth.instance.currentUser!.uid).set(data);
      print('Driver details uploaded!');
    }catch (e) {
      print(e);
    }
  }
}