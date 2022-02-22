import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class driverLocation {
  final FirebaseFirestore fstore;
  final FirebaseAuth fauth;
  driverLocation({required this.fauth, required this.fstore});

  Future<void> setLocation(double latitude, double longitude) async {
    Map position = {'latitude': latitude, 'longitude': longitude};

    await fstore
        .collection('Driver')
        .doc(fauth.currentUser!.uid)
        .update({'position': position, 'status': 'online'});
  }

  Future<void> offineStatus() async {
    await fstore
        .collection('Driver')
        .doc(fauth.currentUser!.uid)
        .update({'status': 'offline'});
  }

  Future<void> completeOrder(int index, String cusid, String agencyid) async {
    var orders = await fstore.collection('order').doc(agencyid).get();
    var order_data = orders.get('orders') as List;
    Map orde = {
      'agency': order_data[index]['agency'],
      'amount': order_data[index]['amount'],
      'cusname': order_data[index]['cusname'],
      'driver': order_data[index]['driver'],
      'location': order_data[index]['location'],
      'mode': order_data[index]['mode'],
      'position': order_data[index]['position'],
      'quantity': order_data[index]['quantity'],
      'status': "done",
      'time': order_data[index]['time'],
      'uid': order_data[index]['uid'],
    };
    if (index != order_data.length) {
      order_data.removeAt(index);
      order_data.insert(index, orde);
    } else {
      order_data.removeAt(index);
      order_data.add(orde);
    }
    await fstore
        .collection('order')
        .doc(agencyid)
        .update({'orders': order_data});
    var list = [];
    var history = await fstore.collection('history').doc(cusid).get();
    if(history.exists){
      list = history.get('history');
    }
    list.add(orde);
    await fstore.collection('history').doc(cusid).set({'history': list});
    await fstore.collection('booking').doc(cusid).delete();
  }

  Future<void> cancelOrder(int index, String cusid, String agencyid) async {
    var orders = await fstore.collection('order').doc(agencyid).get();
    var order_data = orders.get('orders') as List;
    Map orde = {
      'agency': order_data[index]['agency'],
      'amount': order_data[index]['amount'],
      'cusname': order_data[index]['cusname'],
      'driver': order_data[index]['driver'],
      'location': order_data[index]['location'],
      'mode': order_data[index]['mode'],
      'position': order_data[index]['position'],
      'quantity': order_data[index]['quantity'],
      'status': "canceled",
      'time': order_data[index]['time'],
      'uid': order_data[index]['uid'],
    };
    if (index != order_data.length) {
      order_data.removeAt(index);
      order_data.insert(index, orde);
    } else {
      order_data.removeAt(index);
      order_data.add(orde);
    }
    await fstore
        .collection('order')
        .doc(agencyid)
        .update({'orders': order_data});
    await fstore.collection('booking').doc(cusid).delete();
  }
}
