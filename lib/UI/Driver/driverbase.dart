import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';




class driverbase extends StatefulWidget {
  const driverbase({Key? key}) : super(key: key);

  @override
  _driverbaseState createState() => _driverbaseState();
}

class _driverbaseState extends State<driverbase> {
  
  late FirebaseFirestore _fstore;
  
  @override
  void initState() {
    _fstore = FirebaseFirestore.instance;
    // TODO: implement initState
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[700],
        title: Text('Water Tank'),
      ),
      body: Center(child: Text('Futurebuilder required!'),)
    );
  }
}
