import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class assignfcade {
  final FirebaseAuth fauth;
  final FirebaseFirestore fstore;
  assignfcade({required this.fauth, required this.fstore});

  Future<void> assignOrder(int index, String driverUid) async {
    await fstore
        .collection('order')
        .doc(fauth.currentUser!.uid)
        .get()
        .then((data) async {
      var orders = data.get('orders') as List;
      Map order = {
        'agency': orders[index]['agency'],
        'amount': orders[index]['amount'],
        'cusname': orders[index]['cusname'],
        'location': orders[index]['location'],
        'quantity': orders[index]['quantity'],
        'mode': orders[index]['mode'],
        'position': orders[index]['position'],
        'status': orders[index]['status'],
        'time': orders[index]['time'],
        'uid': orders[index]['uid'],
        'driver': driverUid
      };
      if (orders.length > index) {
        orders.removeAt(index);
        orders.insert(index, order);
        await fstore
            .collection('order')
            .doc(fauth.currentUser!.uid)
            .update({'orders': orders});
      } else {
        orders.removeAt(index);
        orders.add(order);
        await fstore
            .collection('order')
            .doc(fauth.currentUser!.uid)
            .update({'orders': orders});
      }
      await fstore
          .collection('booking')
          .doc(order['uid'])
          .update({'driver': driverUid});
    });
  }
}
