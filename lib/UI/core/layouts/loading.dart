import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class loading extends StatefulWidget {
  const loading({Key? key}) : super(key: key);

  @override
  State<loading> createState() => _loadingState();
}


class _loadingState extends State<loading> {

  late FirebaseFirestore _fstore;
  late FirebaseAuth _fauth;

  @override
  void initState() {
    _fauth = FirebaseAuth.instance;
    _fstore = FirebaseFirestore.instance;
    if(_fauth.currentUser == null) {
      SchedulerBinding.instance!.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(context, '/login');
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(_fauth.currentUser != null) {
      return FutureBuilder(
        future: _fstore.collection('user').doc(_fauth.currentUser!.uid).get(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot?> snap) {
          if(snap.hasData) {
            var data = snap.data;
            if(data!.get('type') == 'user') {
              SchedulerBinding.instance!.addPostFrameCallback((_) {
                Navigator.pushReplacementNamed(context, '/userbase');
              });
            }
            else if(data.get('type') == 'driver') {
              SchedulerBinding.instance!.addPostFrameCallback((_) {
                Navigator.pushReplacementNamed(context, '/driverbase');
              });
            }
            else {
              SchedulerBinding.instance!.addPostFrameCallback((_) {
                Navigator.pushReplacementNamed(context, '/agentbase');
              });
            }
          }
          return Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: SpinKitFadingCube(
                size: 50.0,
                color: Colors.green[700],
              ),
            ),
          );
        },
      );
    }
    else {
      SchedulerBinding.instance!.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(context, '/login');
      });
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SpinKitFadingCube(
          size: 50.0,
          color: Colors.green[700],
        ),
      ),
    );
  }
}
