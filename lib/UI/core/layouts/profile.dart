import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class profiledetails extends StatefulWidget {
  final FirebaseAuth fauth;
  final String uid;
  profiledetails({required this.fauth, required this.uid});
  @override
  State<profiledetails> createState() => _profiledetailsState();
}

class _profiledetailsState extends State<profiledetails> {

  late FirebaseFirestore fstore;

  @override
  void initState() {
    fstore = FirebaseFirestore.instance;
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.green[700],elevation: 0,title: const Text('Driver Details'),),
        body: FutureBuilder(
          future: fstore.collection('Driver').doc(widget.uid).get(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if(snapshot.hasData) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      color: Colors.green[700],
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      child: Stack(
                        children: [
                          Align(child: snapshot.data.get('profile') != ""? SizedBox(width: MediaQuery.of(context).size.width,child: Image(image: NetworkImage(snapshot.data.get('profile')),fit: BoxFit.cover,filterQuality: FilterQuality.high)) :
                          Icon(Icons.account_circle,size: 100,color: Colors.green,),
                            alignment: Alignment.topCenter,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Align(alignment: Alignment.bottomLeft,
                              child: Text(snapshot.data.get('name'),style: TextStyle(color: Colors.white,fontSize: 30, fontWeight: FontWeight.bold),),
                            ),
                          )
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        ListTile(
                          leading: Icon(Icons.person, color: Colors.blue,),
                          title: Text('Gender'),
                          subtitle: Text('Male'),
                          onTap: () => null,
                        ),
                        ListTile(
                          leading: Icon(Icons.phone, color: Colors.green,),
                          title: Text('Phone number'),
                          subtitle: Text(snapshot.data.get('phn')),
                          onTap: () => null,
                        ),
                        ListTile(
                          leading: Icon(Icons.airport_shuttle_rounded, color: Colors.red,),
                          title: Text('Vehicle'),
                          subtitle: Text(snapshot.data.get('vehicle')),
                          onTap: () => null,
                        ),
                        ListTile(
                          leading: Icon(Icons.assignment, color: Colors.yellow[700],),
                          title: Text('Vehicle Registration number'),
                          subtitle: Text(snapshot.data.get('regno')),
                          onTap: () => null,
                        ),
                        ListTile(
                          leading: Icon(Icons.assignment_ind_rounded, color: Colors.black45,),
                          title: Text('License'),
                          onTap: () => null,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: SizedBox(
                            height: 200,
                            width: MediaQuery.of(context).size.width,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image(image: NetworkImage(snapshot.data.get('license')),fit: BoxFit.cover,)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment
                                .spaceBetween,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: ElevatedButton(onPressed: () {},
                                    child: Text('Report', style: TextStyle(
                                        color: Colors.black45),),
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.grey[350]),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    child: Text('Recruit'),
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.green),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              );
            }
            return const Center(child: CircularProgressIndicator(),);
        },)
    );
  }
}