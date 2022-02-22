import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';



class availableFcade {
  FirebaseAuth fauth;
  FirebaseFirestore fstore;

  availableFcade(this.fauth, this.fstore);

  Future<void> updateAvailability(int quantity, int price, int option) async{
    List available = [];
    Map resource = {
      'quantity': quantity,
      'price': price
    };
    var data = await fstore.collection('Agency').doc(fauth.currentUser!.uid).get();
    if(data.data()!.containsKey('Availability')) {
      available = data.data()!['Availability'];

      if(option != 2) {
        available.removeAt(option);
        available.insert(option, resource);
        await fstore.collection('Agency').doc(fauth.currentUser!.uid).update(
          {
            'Availability': available
          }
        );
      }
      else {
        available.removeAt(option);
        available.add(resource);
        await fstore.collection('Agency').doc(fauth.currentUser!.uid).update(
            {
              'Availability': available
            }
        );
      }
    }
  }
}