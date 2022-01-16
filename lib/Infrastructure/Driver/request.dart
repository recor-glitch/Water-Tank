import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';


class requestfcade {
  final FirebaseAuth fauth;
  final FirebaseFirestore fstore;
  late List requests;
  late String ret;

  requestfcade({required this.fauth, required this.fstore});

  Future<String> initiateRequest(String uid) async {

      DocumentSnapshot datasnapshot = await fstore.collection('request').doc(uid).get();
      requests = [];
      if(datasnapshot.exists) {
        var res = datasnapshot.data() as Map;
        requests = res['request'] as List<dynamic>;

        ret = "";

        requests.forEach((doc) {
          if(doc['uid'] == fauth.currentUser!.uid) {
            ret = "Already send a request.";
          }
        });
        if(ret == "") {
          requests.add(
            {
              'uid': fauth.currentUser!.uid,
              'time': DateFormat('hh-mm-dd-MM-yy').format(DateTime.now()).toString()
            }
          );
          await fstore.collection('request').doc(uid).set(
              {
                'request': requests
              },
            SetOptions(merge: true)
          );
          return "Your request was successfully send.";
        }
        else{
          return ret;
        }
      }
      if(!datasnapshot.exists) {
        requests.add(
            {
              'uid': fauth.currentUser!.uid,
              'time': DateFormat('hh-mm-dd-MM-yy').format(DateTime.now()).toString()
            }
        );
        await fstore.collection('request').doc(uid).set(
            {
              'request': requests
            },
            SetOptions(merge: true)
        );
        return "Your request was successfully send.";
      }
      return 'Something went wrong.';
  }
}
