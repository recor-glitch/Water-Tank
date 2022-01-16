import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gps/UI/User/tankbook.dart';
import 'package:gps/UI/core/layouts/drawer.dart';
import 'package:gps/UI/google/g_map.dart';
import '../../constants.dart';

class basePage extends StatefulWidget {
  const basePage({Key? key}) : super(key: key);

  @override
  State<basePage> createState() => _basePageState();
}

class _basePageState extends State<basePage> {

  late bool available;
  late FirebaseAuth fauth;
  late FirebaseFirestore fstore;

  @override
  void initState() {
    available = false;
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
        title: Text('Water Tank'),
      ),
      drawer: profile(fauth: fauth),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  child: CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(dummyProfilePictureUrl)),
                )
              ],
            ),
            SizedBox(height: 20,),
            Row(
              children: [
                Text('Choose your Agency',style: TextStyle(fontSize: 20,color: Colors.grey),)
              ],
            ),
            SizedBox(height: 20,),
            Container(
              height: 155,
              width: MediaQuery.of(context).size.width,
              child: StreamBuilder(
                stream: fstore.collection('Agency').snapshots(),
                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasError) {
                    return Padding(
                      padding: EdgeInsets.all(50.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(image: NetworkImage('https://image.freepik.com/free-vector/400-error-bad-request-concept-illustration_114360-1933.jpg',scale: 3)),
                          Text('Looks like you ran into some error.',style: TextStyle(fontSize: 20),)
                        ],
                      ),
                    );
                  }
                  if(!snapshot.hasData){
                    return Padding(
                      padding: const EdgeInsets.all(50.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Image(image: NetworkImage('https://thumbs.dreamstime.com/b/upset-magnifying-glass-cute-not-found-symbol-unsuccessful-search-zoom-icon-no-suitable-results-upset-magnifying-glass-cute-122205498.jpg',scale: 3)),
                          SizedBox(height: 20,),
                          Text('NO DRIVERS FOUND',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                          SizedBox(height: 10,),
                        ],
                      ),
                    );
                  }
                  if(snapshot.hasData) {
                    final List<DocumentSnapshot> documents = snapshot.data.docs;
                    return Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: documents.length,
                          itemBuilder: (BuildContext context, int index) {
                            var data = documents[index];
                            return InkWell(
                              onTap: () async{
                                return showDialog(context: context, builder: (BuildContext context) {
                                  return mybooking(agency: data);
                                });
                              },
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
                                                Text('${data.get('name')}'),
                                              ],
                                            ),
                                            Divider(),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text('Available water tank:'),
                                                SizedBox(height: 10,),
                                                Text('500LTR'),
                                                Text('1000LTR'),
                                                Text('10000LTR'),
                                              ],
                                            ),
                                          ]
                                      ),
                                      Column(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            MaterialButton(
                                              onPressed: () {},
                                              color: Color(0xff4E295B),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(20),
                                              ),
                                              child: Text(
                                                'View Profile',
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
                          },)
                    );
                  }
                  return const Center(child: CircularProgressIndicator(),);
                },),
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Your location',style: TextStyle(fontSize: 20,color: Colors.grey),)
              ],
            ),
            SizedBox(height: 20,),
            Container(
              height: 400,
              width: MediaQuery.of(context).size.width,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                child: g_map(),
              ),
            )
          ],
        ),
      ),
        ),
      ),
    );
  }
}
