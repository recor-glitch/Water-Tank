import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';



class userbooking {
  final FirebaseAuth fauth;
  final FirebaseFirestore fstore;
  userbooking({required this.fauth, required this.fstore});
  late List<dynamic> _list;


  Future<void> booking(
      {required String name, required String agency, required String quantity, required String location, required String amt, required double latitude, required double longitude, required String agencyUid, required String mode}) async{
    Map<String,dynamic> _position = {
      'latitude': latitude,
      'longitude': longitude,
    };
    await fstore.collection('booking').doc(fauth.currentUser!.uid).set(
      {
        'agency': agency,
        'cusname': name,
        'time': DateFormat('hh-mm-dd-MM-yy').format(DateTime.now()),
        'quantity': quantity,
        'location': location,
        'uid': fauth.currentUser!.uid,
        'status': 'pending',
        'amount': amt,
        'position': _position,
        'mode': mode,
        'agencyuid': agencyUid
      }
    );
    await fstore.collection('order').doc(agencyUid).get().then((snapshot) async {
      if(snapshot.exists) {
        print('order part');
        var ar_data = snapshot.get('orders') as List<dynamic>;
        Map data = {
          'agency': agency,
          'cusname': name,
          'time': DateFormat('hh-mm-dd-MM-yy').format(DateTime.now()),
          'quantity': quantity,
          'location': location,
          'uid': fauth.currentUser!.uid,
          'status': 'pending',
          'amount': amt,
          'position': _position,
          'mode': mode,
        };
        ar_data.add(data);
        await fstore.collection('order').doc(agencyUid).set(
            {
              'orders': ar_data
            },SetOptions(merge: true)
        );
      }
      else {
        _list = [];
        Map data = {
          'agency': agency,
          'cusname': name,
          'time': DateFormat('hh-mm-dd-MM-yy').format(DateTime.now()),
          'quantity': quantity,
          'location': location,
          'uid': fauth.currentUser!.uid,
          'status': 'pending',
          'amount': amt,
          'position': _position,
          'mode': mode,
        };
        _list.add(data);
        await fstore.collection('order').doc(agencyUid).set(
            {
              'orders': _list
            },SetOptions(merge: true)
        );
      }
    });
  }

  Future<void> acceptOrder(int index) async {
    String cusUid = '';
    await fstore.collection('order').doc(fauth.currentUser!.uid).get().then((snapshot) async {
      if (snapshot.exists) {
        var ar_data = snapshot.get('orders') as List<dynamic>;
        cusUid = ar_data[index]['uid'];
        Map data = {
          'agency': ar_data[index]['agency'],
          'cusname': ar_data[index]['cusname'],
          'time': ar_data[index]['time'],
          'quantity': ar_data[index]['quantity'],
          'location': ar_data[index]['location'],
          'uid': ar_data[index]['uid'],
          'status': 'processing',
          'amount': ar_data[index]['amount'],
          'position': ar_data[index]['position'],
          'mode': ar_data[index]['mode'],
        };
        ar_data.removeAt(index);
        ar_data.insert(index, data);
        await fstore.collection('order').doc(fauth.currentUser!.uid).set(
            {
              'orders': ar_data
            }
        );
      }
    });
    await fstore.collection('booking').doc(cusUid).update(
      {
        'status': 'processing'
      }
    );
  }

}