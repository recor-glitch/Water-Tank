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

  Future<void> Register_driver(String name,String phn,String vehicle,String regno,XFile _image, XFile license) async {
    Reference ref = FirebaseStorage.instance.ref('ProfileUpload').child(FirebaseAuth.instance.currentUser!.uid);
    Reference ref2 = FirebaseStorage.instance.ref('licenseUpload').child(FirebaseAuth.instance.currentUser!.uid);
    try {
      await ref.putFile(i.File(_image.path));
      String profile_url = await ref.getDownloadURL();
      await ref2.putFile(i.File(license.path));
      String license_url = await ref2.getDownloadURL();

      Map<String, dynamic> data = {
        'name': name,
        'phn': phn,
        'vehicle': vehicle,
        'regno': regno,
        'profile': profile_url,
        'type': 'driver',
        'verification': 'unverified',
        'uid': _fauth.currentUser!.uid,
        'license': license_url
      };
      await _fstore.collection('Driver').doc(FirebaseAuth.instance.currentUser!.uid).set(data);
      print('Driver details uploaded!');
    }catch (e) {
      print(e);
    }
  }
}