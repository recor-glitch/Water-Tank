import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class userfcade {
  userfcade(this._fauth, this._fstore);
  final FirebaseFirestore _fstore;
  final FirebaseAuth _fauth;


  Future<String> CreateUser(String name, String email, String pass, String type) async {
    try {
      await _fauth.createUserWithEmailAndPassword(email: email.trim(), password: pass.trim()).then((value) async {
        Map<String, String> data = {'name': name, 'email': email, 'pass': pass, 'uid': value.user!.uid, 'type': type,};
        await _fstore.collection('user').doc(value.user!.uid).set(data);
        print('User Created Successfully!');
        return 'true';
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('Entered a weak password.');
        return e.code.replaceAll("-", " ");
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        return e.code.replaceAll("-", " ");
      }
    }
    return 'true';
  }

  Future<String> SigninUser(String email, String pass) async {
    try {
      await _fauth.signInWithEmailAndPassword(
          email: email.trim(),
          password: pass.trim()
      ).then((value) {
        print('Signed In Successfully!');
        return 'true';
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        return e.code.replaceAll("-", " ");
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        return e.code.replaceAll("-", " ");
      }
    }
    return 'true';
  }
}
