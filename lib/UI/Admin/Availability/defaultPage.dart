import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gps/UI/Admin/Availability/editPage.dart';




class availableDefault extends StatefulWidget {
  const availableDefault({Key? key}) : super(key: key);

  @override
  _availableDefaultState createState() => _availableDefaultState();
}

class _availableDefaultState extends State<availableDefault> {


  late FirebaseAuth fauth;
  late FirebaseFirestore fstore;

  @override
  void initState() {
    fauth = FirebaseAuth.instance;
    fstore = FirebaseFirestore.instance;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[700],
        elevation: 1,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Availability'),
      ),
      body: SingleChildScrollView(
        child:
        Column(
            children: [
              Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Align(alignment: Alignment.center,
                          child: Text(('List of available water tank'),style: TextStyle(fontSize: 20, color: Colors.grey),),
                        ),
                      )
                    ],
                  )
              ),
              FutureBuilder(
                future: fstore.collection('Agency').doc(fauth.currentUser!.uid).get(),
                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if(snapshot.hasData) {
                  var data = snapshot.data.get('Availability') as List;
                  return ListView.builder(
                    itemCount: data.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return getCard(data[index]['quantity'], data[index]['price'], index);
                    },
                  );
                }
                return const CircularProgressIndicator();
              },)
            ]
        ),
      ),
    );
  }

  Widget getCard(int quantity, int price, int option) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Card(
        elevation: 3.0,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Quantity: $quantity LTR'),
                      ],
                    ),
                    Divider(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Price: $price Rupees'),
                      ],
                    ),
                  ]
              ),
              Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    MaterialButton(
                      onPressed: () async{
                        return showDialog(context: context, builder: (BuildContext context) {
                          return editavailability(option: option);
                        });
                      },
                      color: Color(0xff4E295B),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Edit Details',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ]
              ),
            ],
          ),
        ),
      ),
    );
  }
}
